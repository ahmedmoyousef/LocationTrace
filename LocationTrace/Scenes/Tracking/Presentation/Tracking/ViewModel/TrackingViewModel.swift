//
//  TrackingViewModel.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI
import Combine
import MapKit
import AYLocationManager

@Observable
class TrackingViewModel {
    
    var cameraPosition: MapCameraPosition
    var currentLocation: CLLocation?
    var hasLocationPermission: Bool = true
    var state: TarckingState = .initial {
        didSet { logStatus() }
    }
    var toast: Toast? = nil
    var segments: [Segment] = []
    var startTrackDate: Date = .init()
    var startSegmentDate: Date = .init()
    var currentLocations: [CLLocation] = []
    var currentCoordinate: [CLLocationCoordinate2D] {
        currentLocations.compactMap { $0.coordinate }
    }
    
    private let appCoordinator: AppCoordinatorImpl
    private let saveTrackUseCase: SaveTrackUseCase
    private let deleteTrackUseCase: DeleteTrackUseCase
    
    
    init(appCoordinator: AppCoordinatorImpl, saveTrackUseCase: SaveTrackUseCase, deleteTrackUseCase: DeleteTrackUseCase) {
        self.cameraPosition = .userLocation(fallback: .automatic)
        self.appCoordinator = appCoordinator
        self.saveTrackUseCase = saveTrackUseCase
        self.deleteTrackUseCase = deleteTrackUseCase
    }
    
    func viewDidAppear() {
        hasLocationPermission = AYLocationManager.shared.accessGranted
        AYLocationManager.shared.delegate = self
        if hasLocationPermission {
            getUserLocation()
        } else {
            requestLocationPermission()
        }
    }
    
    func openSavedTrackedList() {
        appCoordinator.push(.tracksList)
    }
    
    func cancelTracking() {
        state = .initial
        AYLocationManager.shared.stopTracking()
        currentLocations.removeAll()
        segments.removeAll()
    }
    
    func requestLocationPermission() {
        hasLocationPermission = AYLocationManager.shared.accessGranted
        guard !hasLocationPermission else { return }
        AYLocationManager.shared.requestPermission()
    }
    
    func getUserLocation() {
        AYLocationManager.shared.requestLocation()
    }
    
    func startTracking() {
        guard AYLocationManager.shared.accessGranted else { return }
        state = .tracking
        startTrackDate = Date()
        startSegmentDate = Date()
        AYLocationManager.shared.startTracking()
    }
    
    fileprivate func saveNewSegment() {
        guard !currentLocations.isEmpty else { return }
        let newSegement = Segment(startDate: startSegmentDate, endDate: Date(), points: [], track: nil)
        newSegement.points = currentLocations.map { LocationPoint(
            latitude: $0.coordinate.latitude,
            longitude: $0.coordinate.longitude,
            timestamp: $0.timestamp, segment: newSegement) }
        segments.append(newSegement)
        currentLocations.removeAll()
    }

    func pauseTracking() {
        state = .paused
        AYLocationManager.shared.stopTracking()
        DispatchQueue.main.async {
            self.saveNewSegment()
        }
    }
    
    func resumeTracking() {
        guard AYLocationManager.shared.accessGranted else { return }
        state = .resumed
        startSegmentDate = Date()
        AYLocationManager.shared.startTracking()
    }
    
    func stopTracking() {
        state = .initial
        AYLocationManager.shared.stopTracking()
        DispatchQueue.main.async {
            self.saveNewSegment()
            self.saveTarack()
        }
    }
    
    private
    func saveTarack() {
        let newTrack = Track(startDate: startTrackDate, endDate: Date(), segments: segments)
        Task {
            do {
                try await saveTrackUseCase.execute(track: newTrack)
                self.segments.removeAll()
                toast = .init(style: .success, message: "Track saved successfully")
            } catch {
                print("Error saving segment \(error.localizedDescription)")
            }
        }
    }
    
    private
    func logStatus() {
        guard state != .initial else { return }
        toast = .init(style: .info, message: state.message)
    }
}

extension TrackingViewModel: AYLocationServices.Delegate {
    
    func didUpdateLocation(locations: [CLLocation]) {
        self.currentLocation = locations.last
        if state == .tracking || state == .resumed {
            self.currentLocations.append(contentsOf: locations)
        }
    }
    
    func didChangeAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            hasLocationPermission = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            hasLocationPermission = true
        @unknown default:
            fatalError("didChangeAuthorizationStatus @unknown default case")
        }
    }
}

//
//  TrackDetailsViewModel.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import Foundation
import Combine
import CoreLocation
import MapKit

@Observable
class TrackDetailsViewModel {
    
    let track: Track
    
    var coordinates: [CLLocationCoordinate2D] {
        return track.segments.flatMap { $0.points }.compactMap { .init(latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    var formatedTotalTime: String? {
        guard let endDate = track.endDate else { return nil }
        return track.startDate.timeDifference(to: endDate)
    }
    
    var formatedTotalDistance: String {
        if track.totalDistance < 1000 {
            return String(format: "%.0f meters", track.totalDistance)
        } else {
            let distanceInKilometers = track.totalDistance / 1000
            return String(format: "%.2f kilometers", distanceInKilometers)
        }
    }
    
    var region: MKCoordinateRegion {
        let latitudes = coordinates.map { $0.latitude }
        let longitudes = coordinates.map { $0.longitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat, longitudeDelta: maxLon - minLon)
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    init(track: Track) {
        self.track = track
        print(track.segments.flatMap(\.points))
    }
}

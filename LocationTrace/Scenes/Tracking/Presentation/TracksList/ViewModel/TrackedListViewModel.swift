//
//  HomeViewModel.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI
import Combine
import SwiftData

@Observable
class TrackedListViewModel {
    
    var tracks: [Track] = []
    var toast: Toast?
    private let appCoordinator: AppCoordinatorImpl
    private let getTracksUseCase: GetTrackListUseCase
    private let deleteTrackUseCase: DeleteTrackUseCase
    private let deleteAllTracksUseCase: DeleteAllTracksUseCase
    
    init(appCoordinator: AppCoordinatorImpl,
         getTracksUseCase: GetTrackListUseCase,
         deleteTrackUseCase: DeleteTrackUseCase,
         deleteAllTracksUseCase: DeleteAllTracksUseCase) {
        self.appCoordinator = appCoordinator
        self.getTracksUseCase = getTracksUseCase
        self.deleteTrackUseCase = deleteTrackUseCase
        self.deleteAllTracksUseCase = deleteAllTracksUseCase
    }
    
    func fetchTracks() async {
        do {
            tracks = try await getTracksUseCase.execute()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func openTrackOnMap(track: Track) {
        appCoordinator.push(.trackDetails(track))
    }
    
    func deleteTracks(offsets: IndexSet) {
        Task {
            await withTaskGroup(of: Void.self) { group in
                for index in offsets {
                    let item = tracks[index]
                    group.addTask {
                        try? await self.deleteTrackUseCase.execute(track: item)
                    }
                }
            }
            tracks.remove(atOffsets: offsets)
            toast = .init(style: .warning, message: "Track deleted")
        }
    }
    
    func deleteAllTracks() {
        Task {
            do {
                try await deleteAllTracksUseCase.execute()
                tracks.removeAll()
                toast = .init(style: .warning, message: "All Tracks deleted")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//
//  AppCoordinatorProtocol.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Foundation
import SwiftUI
import SwiftData

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ screen:  AppScreen)
    func pop()
    func popToRoot()
}

class AppCoordinatorImpl: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Navigation Functions
    func push(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: AppScreen) -> some View {
        switch screen {
        case .tracksList:
            let trackRepository = TrackRepository(dataSource: modelContext)
            let vm = TrackedListViewModel(
                appCoordinator: self,
                getTracksUseCase: GetTrackListUseCase(repository: trackRepository),
                deleteTrackUseCase: DeleteTrackUseCase(repository: trackRepository),
                deleteAllTracksUseCase: DeleteAllTracksUseCase(repository: trackRepository))
            TrackedListView(viewModel: vm)
        case .tragckingMap:
            let trackRepository = TrackRepository(dataSource: modelContext)
            let vm = TrackingViewModel(
                appCoordinator: self,
                saveTrackUseCase: SaveTrackUseCase(repository: trackRepository),
                deleteTrackUseCase: DeleteTrackUseCase(repository: trackRepository))
            TrackingView(viewModel: vm)
        case .trackDetails(let track):
            let vm = TrackDetailsViewModel(track: track)
            TrackDetailsView(viewModel: vm)
        }
    }
    
}

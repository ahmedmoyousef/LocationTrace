//
//  DeleteAllTracksUseCase.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Combine

class DeleteAllTracksUseCase {
    
    private let repository: TrackRepositoryProtocol
    
    init(repository: TrackRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws {
        try await repository.deleteAllTracks()
    }
}

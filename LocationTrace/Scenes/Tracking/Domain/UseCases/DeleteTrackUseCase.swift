//
//  DeleteTrackUseCase.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Combine

class DeleteTrackUseCase {
    
    private let repository: TrackRepositoryProtocol
    
    init(repository: TrackRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(track: Track) async throws {
        try await repository.deleteTrack(track)
    }
}

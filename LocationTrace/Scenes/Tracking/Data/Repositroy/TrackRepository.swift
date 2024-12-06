//
//  TrackRepository.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import SwiftData
import Foundation

class TrackRepository: TrackRepositoryProtocol {
        
    private let dataSource: ModelContext
    
    init(dataSource: ModelContext) {
        self.dataSource = dataSource
    }
    
    func saveTrack(_ track: Track) async throws {
        do {
            dataSource.insert(track)
            try dataSource.save()
        } catch {
            throw error
        }
    }
    
    func deleteTrack(_ track: Track) async throws {
        do {
            dataSource.delete(track)
            try dataSource.save()
        } catch {
            throw error
        }
    }
    
    func deleteAllTracks() async throws {
        do {
            try dataSource.delete(model: Track.self)
            try dataSource.save()
        } catch {
            throw error
        }
    }
    
    func getTracksList() async throws -> [Track] {
        do {
            let descriptor = FetchDescriptor<Track>(sortBy: [SortDescriptor(\.startDate)])
            return try dataSource.fetch(descriptor)
        } catch {
            throw error
        }
    }
}

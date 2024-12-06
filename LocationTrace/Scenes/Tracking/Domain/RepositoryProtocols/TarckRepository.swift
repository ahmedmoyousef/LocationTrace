//
//  TarckRepository.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Foundation

protocol TrackRepositoryProtocol {
    func saveTrack(_ track: Track) async throws
    func deleteTrack(_ track: Track) async throws
    func deleteAllTracks() async throws
    func getTracksList() async throws -> [Track]
}

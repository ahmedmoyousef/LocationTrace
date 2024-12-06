//
//  Segment.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Segment {
    @Attribute(.unique)
    var id: String
    var startDate: Date
    var endDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \LocationPoint.segment)
    var points: [LocationPoint]
    
    var coordinates: [CLLocationCoordinate2D] {
        points.sorted { $0.timestamp < $1.timestamp }.map { .init(latitude: $0.latitude, longitude: $0.longitude) }
    }
    
    var distance: Double { coordinates.totalDistance() }
    
    var track: Track?
    
    init(startDate: Date, endDate: Date? = nil, points: [LocationPoint], track: Track?) {
        self.id = UUID().uuidString
        self.startDate = startDate
        self.endDate = endDate
        self.points = points
        self.track = track
    }
}

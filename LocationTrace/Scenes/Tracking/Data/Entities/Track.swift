//
//  Track.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import Foundation
import SwiftData

@Model
class Track {
    @Attribute(.unique)
    var id: String
    var startDate: Date
    var endDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \Segment.track)
    var segments: [Segment]
    var totalDistance: Double {
        segments.reduce(0) { $0 + $1.distance }
    }
    
    init(startDate: Date, endDate: Date? = nil, segments: [Segment]) {
        self.id = UUID().uuidString
        self.startDate = startDate
        self.endDate = endDate
        self.segments = segments
    }
}

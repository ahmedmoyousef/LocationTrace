//
//  LocationPoint.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import Foundation
import SwiftData

@Model
class LocationPoint {
    var latitude: Double
    var longitude: Double
    var timestamp: Date
    var segment: Segment?
    
    init(latitude: Double, longitude: Double, timestamp: Date, segment: Segment?) {
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
        self.segment = segment
    }
}

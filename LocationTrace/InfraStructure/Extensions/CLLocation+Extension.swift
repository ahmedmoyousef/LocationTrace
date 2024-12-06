//
//  CLLocation+Extension.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 06/12/2024.
//

import Foundation
import CoreLocation

extension Array where Element == CLLocationCoordinate2D {
    
    func totalDistance() -> Double {
        guard self.count > 1 else { return 0.0 }
        
        var totalDistance: Double = 0.0
        
        for i in 1..<self.count {
            let startLocation = CLLocation(latitude: self[i - 1].latitude, longitude: self[i - 1].longitude)
            let endLocation = CLLocation(latitude: self[i].latitude, longitude: self[i].longitude)
            totalDistance += startLocation.distance(from: endLocation)
        }
        
        return totalDistance
    }
}

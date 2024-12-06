//
//  Date+Extension.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 06/12/2024.
//

import Foundation

extension Date {
    
    func timeDifference(to endDate: Date) -> String {
        guard endDate > self else { return "Invalid date range" }

        // Calculate the total difference in seconds
        let totalSeconds = Int(endDate.timeIntervalSince(self))

        // Convert to hours, minutes, and seconds
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        return "\(hours) hours, \(minutes) minutes, \(seconds) seconds"
    }
}

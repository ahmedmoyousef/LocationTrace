//
//  Item.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 06/12/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

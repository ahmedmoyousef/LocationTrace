//
//  PresentationStyles.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Foundation

enum AppScreen: Identifiable, Hashable {
    case tragckingMap
    case tracksList
    case trackDetails(Track)
    
    var id: Self { return self }
}

//
//  TarckingState.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 04/12/2024.
//

enum TarckingState: String, Codable {
   
    case initial
    case tracking
    case paused
    case resumed
    case ended
    
    var isPlayEnabled: Bool {
        switch self {
        case .initial:
            return true
        case .tracking, .resumed, .ended, .paused:
            return false
        }
    }
    
    var isPauseEnabled: Bool {
        switch self {
        case .tracking, .resumed:
            return true
        case .initial, .paused, .ended:
            return false
        }
    }
    
    var isResumeEnabled: Bool {
        switch self {
        case .paused:
            return true
        case .initial, .resumed, .tracking, .ended:
            return false
        }
    }
    
    var isEndEnabled: Bool {
        switch self {
        case .tracking, .resumed, .paused:
            return true
        case .initial, .ended:
            return false
        }
    }
    
    var message: String {
        switch self {
        case .initial:
            return "Normal State"
        case .tracking:
            return "Tracking Started"
        case .paused:
            return "Tracking Paused"
        case .resumed:
            return "Tracking Resumed"
        case .ended:
            return "Tracking Ended"
        }
    }
}

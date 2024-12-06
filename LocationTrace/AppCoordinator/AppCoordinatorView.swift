//
//  AppCoordinatorView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinatorImpl = AppCoordinatorImpl(modelContext: Constants.modelContainer.mainContext)
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.tragckingMap)
                .navigationDestination(for: AppScreen.self) { screen in
                    appCoordinator.build(screen)
                }
        }
        .environmentObject(appCoordinator)
    }
}

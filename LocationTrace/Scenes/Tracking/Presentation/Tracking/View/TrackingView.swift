//
//  TrackingView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI
import SwiftData
import MapKit

struct TrackingView: View {
    
    @State private var viewModel: TrackingViewModel
    @Namespace private var mapScope
    
    var body: some View {
        Map(position: $viewModel.cameraPosition, scope: mapScope) {
            if !viewModel.currentCoordinate.isEmpty {
                MapPolyline(coordinates: viewModel.currentCoordinate)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .toastView(toast: $viewModel.toast)
        .animation(.linear, value: viewModel.cameraPosition)
        .overlay(alignment: .bottomTrailing, content: {
            VStack {
                MapUserLocationButton(scope: mapScope)
                MapPitchToggle(scope: mapScope)
                MapCompass(scope: mapScope)
                    .mapControlVisibility(.visible)
            }
            .padding(.trailing, 10)
            .buttonBorderShape(.circle)
            
        })
        .mapScope(mapScope)
        .safeAreaInset(edge: .bottom, content: {
            if viewModel.hasLocationPermission {
                TrackingControlsView(viewModel: $viewModel)
            } else {
                VStack(spacing: 0) {
                    Button("Loaction access not granted", systemImage: "location.slash.fill") {
                        viewModel.requestLocationPermission()
                    }
                    .font(.headline)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.red)
                    .cornerRadius(12)
                    
                    Text("To enable location access, please follow these steps:\n\n1. Open the Settings app on your device.\n2. Scroll down and find the name of this app.\n3. Tap on the app and toggle the Location setting to 'While Using the App' or 'Always'.\n\nOnce you’ve enabled location access, please return to the app.")
                        .font(.footnote)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                }
            }
        })
        .onAppear {
            viewModel.viewDidAppear()
        }
        .navigationBarTitle("Tracking")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    viewModel.openSavedTrackedList()
                } label: {
                    Image(systemName: "list.bullet.circle")
                }
            }
        }
    }
    
    init(viewModel: TrackingViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
}

//#Preview {
//    TrackingView(viewModel: .init(modelContext: Constants.modelContainer.mainContext))
//}

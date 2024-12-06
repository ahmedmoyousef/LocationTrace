//
//  TrackingControlsView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 05/12/2024.
//

import SwiftUI

struct TrackingControlsView: View {
    
    @Binding var viewModel: TrackingViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack() {
                // Start button
                if viewModel.state.isPlayEnabled {
                    Button {
                        viewModel.startTracking()
                    } label: {
                        Image(systemName: "play.fill")
                            .font(.largeTitle)
                            .tint(.green)
                    }
                    .disabled(!viewModel.state.isPlayEnabled)
                }
                
                // Pause button
                if viewModel.state.isPauseEnabled {
                    Button {
                        viewModel.pauseTracking()
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(.largeTitle)
                    }
                    .disabled(!viewModel.state.isPauseEnabled)
                }
                
                // Resume button
                if viewModel.state.isResumeEnabled {
                    Button {
                        viewModel.resumeTracking()
                    } label: {
                        Image(systemName: "playpause.fill")
                            .font(.largeTitle)
                            .tint(.orange)
                    }
                    .disabled(!viewModel.state.isResumeEnabled)
                }
                
                // End button
                if viewModel.state.isEndEnabled {
                    Button {
                        viewModel.stopTracking()
                    } label: {
                        Image(systemName: "stop.fill")
                            .font(.largeTitle)
                            .tint(.red)
                    }
                    .disabled(!viewModel.state.isEndEnabled)
                }
            }
            
            if viewModel.state != .initial {
                Button("Cancel") {
                    viewModel.cancelTracking()
                }
                .tint(.red)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(.thinMaterial)
        .cornerRadius(12)
    }
}
//
//#Preview {
//    TrackingControlsView(viewModel: .constant(TrackingViewModel(modelContext: Constants.modelContainer.mainContext)))
//}

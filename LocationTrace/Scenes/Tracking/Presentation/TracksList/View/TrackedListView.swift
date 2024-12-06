//
//  HomeView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI
import SwiftData


struct TrackedListView: View {
    
    @State private var viewModel: TrackedListViewModel
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            if !viewModel.tracks.isEmpty {
                List {
                    ForEach(viewModel.tracks) { track in
                        TrackItemView(track: track)
                            .onTapGesture {
                                viewModel.openTrackOnMap(track: track)
                            }
                    }
                    .onDelete(perform: viewModel.deleteTracks)
                }
            }
            
            if viewModel.tracks.isEmpty {
                TrackedListEmptyView()
            }
        }
        .task {
            await viewModel.fetchTracks()
        }
        .toastView(toast: $viewModel.toast)
        .navigationTitle("Saved tracks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Delete all", systemImage: "trash.fill") {
                    showingAlert = true
                }
                .disabled(viewModel.tracks.isEmpty)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Delete All Items"),
                message: Text("Are you sure you want to delete all items?"),
                primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteAllTracks()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    init(viewModel: TrackedListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
}

//#Preview {
//    TrackedListView()
//}

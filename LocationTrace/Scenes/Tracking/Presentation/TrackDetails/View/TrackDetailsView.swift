//
//  TrackDetailsView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI
import MapKit

struct TrackDetailsView: View {
    
    @State private var viewModel: TrackDetailsViewModel
    
    var body: some View {
        Map(initialPosition: .region(viewModel.region)) {
            ForEach(viewModel.track.segments) { segment in
                MapPolyline(coordinates: segment.coordinates)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            VStack(alignment: .leading) {
                Text("Start Date: \(viewModel.track.startDate, format: .dateTime.hour().minute().second())")
                
                if let endDate = viewModel.track.endDate {
                    Text("End Date: \(endDate, format: .dateTime.hour().minute().second())")
                }
                
                if let time = viewModel.formatedTotalTime {
                    Text("Total Time: \(time)")
                }
                
                Text("Total Distance: \(viewModel.formatedTotalDistance)")
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        })
        .navigationTitle("\(viewModel.track.startDate, format: .dateTime.month().day())")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(viewModel: TrackDetailsViewModel) {
        _viewModel = .init(initialValue: viewModel)
    }
}
//
//#Preview {
//    NavigationStack {
//        TrackDetailsView(viewModel: .init(track: .init(startDate: Date(), segments: [])))
//    }
//}

//
//  TrackCell.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 03/12/2024.
//

import SwiftUI

struct TrackItemView: View {
    let track: Track
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Text("From: \(track.startDate, format: .dateTime.month().day().hour().minute())")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.green)
                
                if let endDate = track.endDate {
                    Image(systemName: "arrow.right")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("To: \(endDate, format: .dateTime.month().day().hour().minute())")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.orange)
                }
            }
            
            if !track.segments.isEmpty {
                Text("Sgments: \(track.segments.count)")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

//#Preview {
//    TrackItemView(track: .init(startDate: Date(), segments: []))
//}

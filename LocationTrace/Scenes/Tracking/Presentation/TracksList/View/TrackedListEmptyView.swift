//
//  TrackedListEmptyView.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 04/12/2024.
//

import SwiftUI

struct TrackedListEmptyView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(spacing: 12) {
                Image(systemName: "folder")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text("No Tracking Data found")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    TrackedListEmptyView()
//}

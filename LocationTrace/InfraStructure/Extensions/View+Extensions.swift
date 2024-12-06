//
//  View+Extentions.swift
//  LocationTrace
//
//  Created by Ahmed Mohamed Yousef on 06/12/2024.
//

import Foundation
import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}

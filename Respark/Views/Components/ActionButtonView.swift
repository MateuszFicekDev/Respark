//
//  ActionButtonView.swift
//  Respark
//
//  Created by Mateusz Ficek on 29/11/2024.
//

import SwiftUI

struct ActionButtonView: View {
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action,
               label: {
                   Image(systemName: icon)
                       .resizable()
                       .frame(width: 76, height: 76)
                       .symbolRenderingMode(.hierarchical)
                       .foregroundStyle(.primaryFont)
                       .contentTransition(.symbolEffect)

               })
               .padding()
    }
}

#Preview {
    ActionButtonView(icon: "", action: {})
}

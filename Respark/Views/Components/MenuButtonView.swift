//
//  MenuButton.swift
//  Respark
//
//  Created by Mateusz Ficek on 29/11/2024.
//

import SwiftUI

struct MenuButtonView: View {
    var icon: String
    var width: CGFloat?
    var height: CGFloat?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .frame(width: width ?? 36, height: height ?? 36)
                .foregroundColor(.primaryFont)
                .padding(.horizontal, 36)
                .padding(.vertical, 24)
        }
    }
}

#Preview {
    MenuButtonView(icon: "", action: {})
}

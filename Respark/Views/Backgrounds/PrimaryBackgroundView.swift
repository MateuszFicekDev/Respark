//
//  PrimaryBackgroundView.swift
//  Respark
//
//  Created by Mateusz Ficek on 30/11/2024.
//

import SwiftUI

struct PrimaryBackgroundView: View {
    var progressAmount: Double
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                Color.primaryBlue
                VStack {
                    Spacer()
                    Color.primaryOrange
                        .frame(height: geometry.size.height * (1 - progressAmount))
                }
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    PrimaryBackgroundView(progressAmount: 0.001)
}

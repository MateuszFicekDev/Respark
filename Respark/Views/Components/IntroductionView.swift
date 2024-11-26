//
//  IntroductionView.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("RESPARK")
                    .fontWeight(.bold)
                    .font(.largeTitle) +
                    Text(" Your Focus, Ignite Your Productivity!")
                    .font(.largeTitle)
                    .fontWeight(.thin)
            }
            .padding(.all, 48)

            Spacer()

            Image(systemName: "chevron.down.2")
                .resizable()
                .frame(width: 32, height: 32)
        }
        .padding(.bottom, 64)
    }
}

#Preview {
    IntroductionView()
}

//
//  OnboardingView.swift
//  Respark
//
//  Created by Mateusz Ficek on 26/11/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State var backgroundColor: Color = .primaryOrange
    @State var didPresentIntroduction: Bool = false

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    IntroductionView()
                        .frame(height: UIScreen.main.bounds.height)

                    OnboardingSettingsView()
                        .frame(height: UIScreen.main.bounds.height)
                }
            }
            .onScrollPhaseChange { _, _, context in
                if context.geometry.contentOffset.y > UIScreen.main.bounds.height - 64 {
                    withAnimation {
                        backgroundColor = .primaryBlue
                        didPresentIntroduction = true
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollDisabled(didPresentIntroduction)
        }
        .ignoresSafeArea()
    }
}

struct OnboardingPreviews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

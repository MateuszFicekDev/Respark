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
    @State var navigateToHome: Bool = false

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    IntroductionView()
                        .frame(height: UIScreen.main.bounds.height)
                    OnboardingSettingsView()
                        .frame(height: UIScreen.main.bounds.height)
                    AutomationSettingsView()
                        .frame(height: UIScreen.main.bounds.height)
                    BreakSettingsView(navigateToHome: $navigateToHome)
                        .frame(height: UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
            }
            .onScrollPhaseChange { _, _, context in
                withAnimation {
                    if context.geometry.contentOffset.y == 0 {
                        backgroundColor = .primaryOrange

                    } else if context.geometry.contentOffset.y == UIScreen.main.bounds.height {
                        backgroundColor = .primaryBlue

                    } else if context.geometry.contentOffset.y == UIScreen.main.bounds.height * 2 {
                        backgroundColor = .primaryGreen

                    } else if context.geometry.contentOffset.y == UIScreen.main.bounds.height * 3 {
                        backgroundColor = .primaryBackground
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .scrollDisabled(navigateToHome)
        }
        .ignoresSafeArea()
        .navigate(to: HomeView(), when: $navigateToHome)
    }
}

struct OnboardingPreviews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

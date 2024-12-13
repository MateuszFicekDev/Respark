//
//  HomeView.swift
//  Respark
//
//  Created by Mateusz Ficek on 28/11/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var cycleManager = CycleManager()

    var body: some View {
        TabView(selection: $selectedTab) {
            SettingsView(cycleManager: cycleManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(Tab.settings)
            CounterView(cycleManager: cycleManager, tab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(Tab.home)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onChange(of: selectedTab) {}
    }
}

enum Tab {
    case home
    case settings
}

#Preview {
    HomeView()
}

//
//  MainView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        TabView {
            HomeView(viewModel: .init())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            MyPageView(viewModel: .init())
                .tabItem {
                    Label("My", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView(viewModel: .init())
}

//
//  Router.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

class Router: ObservableObject {
    enum Route: Hashable {
        case mainView
        case homeView
        case myPageView
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .mainView:
            MainView(viewModel: .init())
        case .homeView:
            HomeView(viewModel: .init())
        case .myPageView:
            MyPageView(viewModel: .init())
        }
    }
    
    func navigateTo(_ route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

//
//  RouterView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}

//
//  MovieReviewApp.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct MovieReviewApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootFeature.State()) {
                    RootFeature()._printChanges()
                }
            )
        }
    }
}

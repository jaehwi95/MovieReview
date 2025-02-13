//
//  MyPageView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: MyPageFeature.self)
struct MyPageView: View {
    let store: StoreOf<MyPageFeature>
    
    var body: some View {
        Text("Hello, MyPageView!")
    }
}

#Preview {
    MyPageView(store: Store(initialState: MyPageFeature.State(), reducer: {
        MyPageFeature()
    }))
}

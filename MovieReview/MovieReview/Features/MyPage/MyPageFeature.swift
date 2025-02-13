//
//  MyPageFeature.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import ComposableArchitecture

@Reducer
struct MyPageFeature: Reducer {
    @ObservableState
    struct State {
        var isLoading: Bool = false
    }
    
    enum Action: ViewAction {
        case setLoading(Bool)
        case view(View)
        
        @CasePathable
        enum View {
            case onAppear
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setLoading(let isLoading):
                state.isLoading = isLoading
                return .none
            case .view(.onAppear):
                return .none
            }
        }
    }
}

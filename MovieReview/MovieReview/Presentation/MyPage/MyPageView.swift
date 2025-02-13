//
//  MyPageView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        Text("Hello, MyPageView!")
    }
}

#Preview {
    MyPageView(viewModel: .init())
}

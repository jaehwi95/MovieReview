//
//  HomeView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        Text("Hello, HomeView!")
    }
}

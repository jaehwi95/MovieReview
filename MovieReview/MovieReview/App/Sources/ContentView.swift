//
//  ContentView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("pretendardBold45!")
                .font(PrographyFont.pretendardBold45)
            Text("pretendardSemiBold11!")
                .font(PrographyFont.pretendardSemiBold11)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

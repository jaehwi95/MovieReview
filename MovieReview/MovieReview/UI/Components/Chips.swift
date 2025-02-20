//
//  Chips.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/20/25.
//

import SwiftUI

struct Chips: View {
    private let texts: [String]
    
    init(texts: [String]) {
        self.texts = texts
    }
    
    var body: some View {
        HStack(spacing: 5.33) {
            ForEach(texts, id: \.self) { text in
                Chip(text: text)
            }
        }
    }
}

private struct Chip: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(PrographyFont.pretendardSemiBold11)
            .fixedLineHeight(lineHeight: 13, fontSize: 11)
            .foregroundStyle(.prographyOnSurfaceVariant)
            .padding(4)
            .overlay {
                Capsule()
                    .stroke(Color.prographyRed, lineWidth: 1)
            }
    }
}

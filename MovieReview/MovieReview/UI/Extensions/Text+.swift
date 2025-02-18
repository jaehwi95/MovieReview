//
//  Text+.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/18/25.
//

import Foundation
import SwiftUI

private struct FixedLineHeight: ViewModifier {
    var lineHeight: CGFloat
    var fontSize: CGFloat

    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - fontSize) // Maintain line height
            .padding(.vertical, (lineHeight - fontSize) / 2) // Adjust for text baseline
    }
}

extension Text {
    func fixedLineHeight(lineHeight: CGFloat, fontSize: CGFloat) -> some View {
        self.modifier(FixedLineHeight(lineHeight: lineHeight, fontSize: fontSize))
    }
}

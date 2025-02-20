//
//  RatingStars.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import SwiftUI

struct RatingStars: View {
    private let size: CGFloat?
    private let rating: Int
    
    init(size: CGFloat? = 16, rating: Int) {
        self.size = size
        self.rating = rating
    }
    
    var body: some View {
        ForEach(0...4, id: \.self) { number in
            let isSelected = (rating-1) >= number
            if isSelected {
                Image(.prographyStarSelected)
                    .resizable()
                    .frame(width: size, height: size)
            } else {
                Image(.prographyStarGray)
                    .resizable()
                    .frame(width: size, height: size)
            }
        }
    }
}

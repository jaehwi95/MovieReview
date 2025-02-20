//
//  Double+.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/20/25.
//

import Foundation

extension Double? {
    func toRateText() -> String {
        if let self = self {
            return String(format: "%.1f", self)
        } else {
            return "-.-"
        }
    }
}

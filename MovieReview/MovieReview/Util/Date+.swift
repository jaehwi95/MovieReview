//
//  Date+.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import Foundation

extension Date {
    func toDateText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

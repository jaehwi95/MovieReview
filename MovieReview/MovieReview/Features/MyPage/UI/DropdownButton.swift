//
//  DropdownButton.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import SwiftUI

protocol Selectable: Hashable, CaseIterable {
    var rawValue: String { get }
}

struct DropdownButton<T: Selectable>: View where T.AllCases: RandomAccessCollection {
    let options: [T]
    @Binding var selectedOption: T
    @State var showDropdownMenu: Bool = false
    
    var body: some  View {
        VStack(spacing: 0) {
            Button {
                showDropdownMenu.toggle()
            } label: {
                HStack(spacing: 0) {
                    rawValueToView(rawValue: selectedOption.rawValue)
                    Spacer()
                    Image(.prographyMenu)
                }
                .padding(.leading, 16)
                .padding(.trailing, 20)
                .frame(height: 64)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.prographyRed, lineWidth: 1)
            }
            
            if showDropdownMenu {
                dropdownMenu
            }
        }
    }
}

private extension DropdownButton {
    private var dropdownMenu: some View {
        LazyVStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button {
                    selectedOption = option
                    showDropdownMenu.toggle()
                } label: {
                    HStack(alignment: .center, spacing: 0) {
                        rawValueToView(rawValue: option.rawValue)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .padding(.bottom, 8)
        .background(.prographyM3White)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.prographyRed, lineWidth: 1)
        }
    }
    
    func rawValueToView(rawValue: String) -> some View {
        return Group {
            switch rawValue {
            case "All":
                Text("All")
                    .font(PrographyFont.pretendardBold16)
                    .fixedLineHeight(lineHeight: 20, fontSize: 16)
                    .foregroundStyle(.prographyBlack)
            case "Five":
                RatingStars(rating: 5)
            case "Four":
                RatingStars(rating: 4)
            case "Three":
                RatingStars(rating: 3)
            case "Two":
                RatingStars(rating: 2)
            case "One":
                RatingStars(rating: 1)
            case "Zero":
                RatingStars(rating: 0)
            default:
                EmptyView()
            }
        }
        .frame(height: 40)
    }
}

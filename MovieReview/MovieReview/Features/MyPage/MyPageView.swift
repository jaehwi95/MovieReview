//
//  MyPageView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI
import ComposableArchitecture
import NukeUI

@ViewAction(for: MyPageFeature.self)
struct MyPageView: View {
    @Bindable var store: StoreOf<MyPageFeature>
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                DropdownButton(
                    options: MyPageFeature.RatingOption.allCases,
                    selectedOption: $store.selectedOption
                )
                .zIndex(1)
                gridMoviesView(movieList: store.filteredMovies)
                .offset(x: 0, y: 80)
                .zIndex(0)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .padding(.bottom, 100)
        }
        .onAppear {
            send(.onAppear)
        }
    }
}

private extension MyPageView {
    func gridMoviesView(movieList: [LocalMovieData]) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
        return ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                ForEach(movieList, id: \.self) { movie in
                    Button {
                        send(.onMovieTapped(movie))
                    } label: {
                        VStack(spacing: 4) {
                            posterImageView(posterPath: movie.posterPath)
                            VStack(spacing: 0) {
                                Text(movie.title)
                                    .font(PrographyFont.pretendardSemiBold14)
                                    .fixedLineHeight(lineHeight: 20, fontSize: 14)
                                    .foregroundStyle(.prographyOnSurface)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                HStack(spacing: 4) {
                                    RatingStars(rating: movie.starRating)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .animation(.spring, value: movieList)
            }
        }
    }
    
    func posterImageView(posterPath: String?) -> some View {
        LazyImage(url: URL(string: Constant.imageURL + (posterPath ?? ""))) { imageState in
            if let image = imageState.image {
                image
                    .resizable()
            } else if imageState.error != nil {
                Image(systemName: "photo")
                    .resizable()
            } else {
                Color.prographyGray6
            }
        }
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

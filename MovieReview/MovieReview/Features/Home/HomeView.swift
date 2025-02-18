//
//  HomeView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/13/25.
//

import SwiftUI
import ComposableArchitecture
import NukeUI

@ViewAction(for: HomeFeature.self)
struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            carouselView
            topTabBarView
        }
        .onAppear {
            send(.onAppear)
        }
    }
}

private extension HomeView {
    var carouselView: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                ForEach(store.nowPlayingMovies, id: \.self.id) { movieItem in
                    posterImageView(
                        backdropPath: movieItem.backdropPath,
                        title: movieItem.title,
                        overview: movieItem.overview
                    )
                }
            }
            .frame(height: 205)
            .padding(.horizontal, 16)
            .scrollTargetLayout()
            .scrollIndicators(.hidden)
        }
        .scrollTargetBehavior(.viewAligned)
        .padding(.vertical, 8)
    }
    
    func posterImageView(backdropPath: String?, title: String?, overview: String?) -> some View {
        return LazyImage(url: URL(string: Constant.imageURL + (backdropPath ?? ""))) { imageState in
            if let image = imageState.image {
                image
                    .resizable()
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(title ?? "")
                                .font(PrographyFont.pretendardBold16)
                                .fixedLineHeight(lineHeight: 24, fontSize: 16)
                                .foregroundStyle(.prographyM3White)
                            Text(overview ?? "")
                                .font(PrographyFont.pretendardSemiBold11)
                                .fixedLineHeight(lineHeight: 16, fontSize: 11)
                                .foregroundStyle(.prographyM3White)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
            } else if imageState.error != nil {
                Image(systemName: "photo")
                    .resizable()
            } else {
                Color.prographyGray6
            }
        }
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}

private extension HomeView {
    var topTabBarView: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(HomeFeature.Tab.allCases, id: \.self) { tab in
                    Button {
                        send(.selectTab(tab))
                    } label: {
                        Text(tab.rawValue)
                            .font(PrographyFont.pretendardBold14)
                            .fixedLineHeight(lineHeight: 20, fontSize: 14)
                            .foregroundStyle(store.currentTab == tab ? .prographyRed : .prographyOnSurfaceVariant)
                            .padding(.top, 14)
                            .padding(.bottom, 11)
                            .overlay(
                                Rectangle()
                                    .frame(height: 3)
                                    .foregroundStyle(store.currentTab == tab ? Color.prographyRed : Color.clear),
                                alignment: .bottom
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 8)
            
            TabView(selection: Binding(
                get: { store.currentTab },
                set: { send(.selectTab($0)) }
            )) {
                ScrollView {
                    VStack {
                        ForEach(store.nowPlayingMovies, id: \.self.id) { movieItem in
                            movieItemView(
                                posterPath: movieItem.posterPath,
                                title: movieItem.title,
                                overview: movieItem.overview,
                                rate: movieItem.rate,
                                genres: movieItem.genres
                            )
                        }
                    }
                }
                .tag(HomeFeature.Tab.nowPlaying)
                
                ScrollView {
                    VStack {
                        ForEach(store.popularMovies, id: \.self.id) { movieItem in
                            movieItemView(
                                posterPath: movieItem.posterPath,
                                title: movieItem.title,
                                overview: movieItem.overview,
                                rate: movieItem.rate,
                                genres: movieItem.genres
                            )
                        }
                    }
                }
                .tag(HomeFeature.Tab.popular)
                
                ScrollView {
                    VStack {
                        ForEach(store.topRatedMovies, id: \.self.id) { movieItem in
                            movieItemView(
                                posterPath: movieItem.posterPath,
                                title: movieItem.title,
                                overview: movieItem.overview,
                                rate: movieItem.rate,
                                genres: movieItem.genres
                            )
                        }
                    }
                }
                .tag(HomeFeature.Tab.topRated)
            }
            .tint(.prographyRed)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    func movieItemView(posterPath: String?, title: String?, overview: String?, rate: Double?, genres: [Genre]?) -> some View {
        HStack(spacing: 16) {
            posterImageView(posterPath: posterPath)
            VStack(alignment: .leading, spacing: 4) {
                Text(title ?? "")
                    .font(PrographyFont.pretendardBold22)
                    .fixedLineHeight(lineHeight: 28, fontSize: 22)
                    .foregroundStyle(.prographyOnSurface)
                Text(overview ?? "")
                    .font(PrographyFont.pretendardBold16)
                    .fixedLineHeight(lineHeight: 24, fontSize: 16)
                    .foregroundStyle(.prographyOnSurfaceVariant)
                    .lineLimit(2)
                    .truncationMode(.tail)
                if let rate = rate {
                    Text(String(format: "%.1f", rate))
                        .font(PrographyFont.pretendardSemiBold14)
                        .fixedLineHeight(lineHeight: 20, fontSize: 14)
                        .foregroundStyle(.prographyOnSurfaceVariant)
                } else {
                    Text("-.-")
                        .font(PrographyFont.pretendardSemiBold14)
                        .fixedLineHeight(lineHeight: 20, fontSize: 14)
                        .foregroundStyle(.prographyOnSurfaceVariant)
                }
                if let genres = genres {
                    HStack(spacing: 5.33) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre.name)
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
                }
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
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

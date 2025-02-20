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
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                carouselView
                Section {
                    movieListView
                } header: {
                    headerView
                }
            }
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
                    Button {
                        send(.onMovieTapped(movieItem))
                    } label: {
                        backdropImageView(
                            backdropPath: movieItem.backdropPath,
                            title: movieItem.title,
                            overview: movieItem.overview
                        )
                    }
                }
            }
            .frame(height: 205)
            .padding(.horizontal, 16)
        }
        .scrollTargetLayout()
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .padding(.vertical, 8)
    }
    
    func backdropImageView(backdropPath: String?, title: String?, overview: String?) -> some View {
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
    var headerView: some View {
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
            .padding(.vertical, 8)
        }
        .padding(.vertical, 8)
        .background(.prographyM3White)
    }
    
    var movieListView: some View {
        let movieList = switch store.currentTab {
        case .nowPlaying: store.nowPlayingMovies
        case .popular: store.popularMovies
        case .topRated: store.topRatedMovies
        }
        
        return ForEach(Array(zip(movieList.indices, movieList)), id: \.0) { index, movieItem in
            Button {
                send(.onMovieTapped(movieItem))
            } label: {
                movieItemView(
                    posterPath: movieItem.posterPath,
                    title: movieItem.title,
                    overview: movieItem.overview,
                    rate: movieItem.rate,
                    genres: movieItem.genres
                )
            }
            .onAppear {
                if index == movieList.indices.last {
                    send(.onLastMovieViewed)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
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
                Text(rate.toRateText())
                    .font(PrographyFont.pretendardSemiBold14)
                    .fixedLineHeight(lineHeight: 20, fontSize: 14)
                    .foregroundStyle(.prographyOnSurfaceVariant)
                if let genres = genres {
                    Chips(texts: genres.map { $0.name })
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

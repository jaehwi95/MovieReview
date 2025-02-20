//
//  DetailView.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/20/25.
//

import SwiftUI
import ComposableArchitecture
import NukeUI

@ViewAction(for: DetailFeature.self)
struct DetailView: View {
    @Bindable var store: StoreOf<DetailFeature>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                detailPosterView
                starRatingView
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        titleView
                        if let genres = store.movieInformation?.genres {
                            Chips(texts: genres.map { $0.name })
                        }
                        descriptionView
                    }
                    .padding(.vertical, 13.5)
                    commentView
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            }
            .onAppear {
                send(.onAppear)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    send(.onBackButtonTapped)
                } label: {
                    Image(.prographyArrowLeft)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.vertical, 14)
                }
            }
            ToolbarItem(placement: .principal) {
                Image(.prographyLogo)
                    .padding(.vertical, 16)
            }
            ToolbarItem(placement: .topBarTrailing) {
                if store.isStarRated {
                    Menu {
                        Button {
                            send(.onEditTapped)
                        } label: {
                            Text("수정하기")
                        }
                        Button(role: .destructive) {
                            send(.onDeleteTapped)
                        } label: {
                            Text("삭제하기")
                        }
                    } label: {
                        Image(.prographyEllipsis)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.vertical, 12)
                    }
                } else {
                    Button("저장") {
                        send(.onSaveTapped)
                    }
                }
            }
        }
    }
}

private extension DetailView {
    var detailPosterView: some View {
        ZStack(alignment: .center) {
            LinearGradient(
                gradient: Gradient(colors: [.prographyGradientStart, .prographyGradientEnd]),
                startPoint: .top,
                endPoint: .bottom
            )
            posterImageView(posterPath: store.movieInformation?.posterPath)
        }
        .frame(height: 247)
        .padding(.top, 8)
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
    }
}

private extension DetailView {
    var starRatingView: some View {
        HStack(spacing: 4) {
            ForEach(0...4, id: \.self) { number in
                let isSelected = (store.starRating ?? -1) >= number
                let starImage = isSelected ? Image(.prographyStarSelected) : Image(.prographyStarGray)
                
                if store.isStarRated {
                    starImage
                } else {
                    Button {
                        send(.onStarTapped(number))
                    } label: {
                        starImage
                    }
                }
            }
        }
    }
}

private extension DetailView {
    var titleView: some View {
        HStack(alignment: .bottom) {
            Text(store.movieInformation?.title ?? "")
                .font(PrographyFont.pretendardBold45)
                .fixedLineHeight(lineHeight: 52, fontSize: 45)
                .foregroundStyle(.prographyBlack)
            Text("/\(store.movieInformation?.rate.toRateText() ?? "-.-")")
                .font(PrographyFont.pretendardBold16)
                .fixedLineHeight(lineHeight: 24, fontSize: 16)
                .foregroundStyle(.prographyBlack)
        }
    }
    
    var descriptionView: some View {
        Text(store.movieInformation?.overview ?? "")
            .font(PrographyFont.pretendardMedium16)
            .fixedLineHeight(lineHeight: 24, fontSize: 16)
            .foregroundStyle(.prographyOnSurfaceVariant)
    }
}

private extension DetailView {
    var commentView: some View {
        VStack(alignment: .leading ,spacing: 8) {
            Text("Comment")
                .font(PrographyFont.pretendardBold16)
                .fixedLineHeight(lineHeight: 24, fontSize: 16)
                .foregroundStyle(.prographyBlack)
            VStack(alignment: .leading, spacing: 0) {
                TextField("후기를 작성해주세요.", text: $store.commentText, axis: .vertical)
                    .disabled(store.isStarRated)
                if store.isStarRated {
                    Text(store.commentDate ?? "")
                        .font(PrographyFont.pretendardRegular11)
                        .fixedLineHeight(lineHeight: 16, fontSize: 11)
                        .foregroundStyle(.prographyBlack)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                }
            }
            .frame(minHeight: 80, alignment: .topLeading)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(store.isStarRated ? .red.opacity(0.2) : .clear)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                !store.isStarRated ? RoundedRectangle(cornerRadius: 8).stroke(.prographyRed, lineWidth: 1) : nil
            )
        }
    }
}

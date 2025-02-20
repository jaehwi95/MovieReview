//
//  LocalMovieProvider.swift
//  MovieReview
//
//  Created by Jaehwi Kim on 2/21/25.
//

import Foundation

struct LocalMovieProvider {
    private static let key = "movieData"
    
    private static func loadSavedMovies() -> [LocalMovieData] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([LocalMovieData].self, from: data)
        else {
            return []
        }
        return decoded
    }
    
    private static func saveMovies(_ movie: [LocalMovieData]) {
        if let encoded = try? JSONEncoder().encode(movie) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func saveMovie(_ movie: LocalMovieData) {
        var savedMovies = loadSavedMovies()
        if let index = savedMovies.firstIndex(where: { $0.movieID == movie.movieID }) {
            // update existing movie
            savedMovies[index] = movie
        } else {
            // add new movie
            savedMovies.append(movie)
        }
        saveMovies(savedMovies)
    }
    
    static func getMovieByID(movieID: String) -> LocalMovieData? {
        return loadSavedMovies().first {
            $0.movieID == movieID
        }
    }
    
    static func deleteMovieByID(movieID: String) {
        var savedMovies = loadSavedMovies()
        savedMovies.removeAll { $0.movieID == movieID }
        saveMovies(savedMovies)
    }
}

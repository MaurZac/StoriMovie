//
//  MovieInfoViewModel.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit
import Combine

final class MovieInfoViewModel {
    
    let movie: Movie
    @Published var movieTitle: String
    @Published var posterImage: UIImage?
    @Published var overview: String
    @Published var releaseDate: String
    @Published var popularity: Double
    
    // MARK: - Init
    init(movie: Movie) {
        self.movie = movie
        self.movieTitle = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.popularity = movie.popularity
        let baseUrl = "https://image.tmdb.org/t/p/"
        let size = "original"
        if let posterPath = movie.backdropPath {
            let fullImageUrlString = "\(baseUrl)\(size)\(posterPath)"
            loadPosterImage(from: fullImageUrlString)
        }
        
        self.overview = movie.overview
            .components(separatedBy: ", ")
            .joined(separator: "\n")
        
    }
    
    func addMovieToFavorites() {
        
    }
    
    private func loadPosterImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("DEBUG: URL no válida: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("DEBUG: Error al descargar la imagen: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImage = image
                }
            }
        }.resume()
    }
    
}

//
//  HomeViewModel.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var isSearchBarExpanded: Bool = false
    @Published var movies: [Movie] = []
    @Published var nowMovies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    
    private var fetchMovieUseCase: HomeViewUseCase
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    
    private var isLoading: Bool = false
    
    init(fetchMovieUseCase: HomeViewUseCase) {
        self.fetchMovieUseCase = fetchMovieUseCase
        loadMovies()
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchMovies(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadMovies() {
        guard !isLoading else { return }
             isLoading = true

             fetchMovieUseCase.fetchTopRated(page: currentPage)
                 .sink(receiveCompletion: { [weak self] completion in
                     if case let .failure(error) = completion {
                         print("Error fetching popular movies: \(error.localizedDescription)")
                     }
                     self?.isLoading = false
                 }, receiveValue: { [weak self] movies in
                     self?.movies.append(contentsOf: movies)
                     self?.filteredMovies.append(contentsOf: movies)
                     self?.currentPage += 1
                 })
                 .store(in: &cancellables)
    }
    
    func searchMovies(with query: String) {
        if query.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { movie in
                let nameMatches = movie.title.lowercased().contains(query.lowercased())
                let descriptionMatches = movie.title.lowercased().contains(query.lowercased())
                return nameMatches || descriptionMatches
            }
        }
    }
    
    func fetchImage(for movie: Movie, completion: @escaping (UIImage?) -> Void) {
        let imageUrlBase = "https://image.tmdb.org/t/p/"
        let imageSize = "w500"
        let fullImageUrlString = "\(imageUrlBase)\(imageSize)\(movie.backdropPath ?? "")"
        
        if let imageUrl = URL(string: fullImageUrlString) {
            if let cachedImage = ImageCache.shared.getImage(forKey: imageUrl.absoluteString) {
                completion(cachedImage)
            } else {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        ImageCache.shared.save(image: image, forKey: imageUrl.absoluteString)
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    } else {
                        print("DEBUG: error al descargar la imagen desde la URL: \(error?.localizedDescription ?? "error desconocido")")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }.resume()
            }
        } else {
            completion(nil)
        }
    }

}

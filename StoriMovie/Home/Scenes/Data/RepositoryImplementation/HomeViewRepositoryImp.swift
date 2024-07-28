//
//  HomeViewRepositoryImp.swift
//  StoriMovie
//
//  Created by MaurZac on 27/07/24.
//
import Combine
import Foundation

final class HomeViewRepositoryImp: HomeViewRepository {
    
    
    private let apiKey = Config.apiKey
    private let topRatedMoviesURL: URL
    
    init() {
        guard let topRatedMoviesURL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL for top rated movies")
        }
        self.topRatedMoviesURL = topRatedMoviesURL
    }
    
    func fetchTopRated() -> AnyPublisher<[Movie], Error> {
        return URLSession.shared.dataTaskPublisher(for: topRatedMoviesURL)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
    
}


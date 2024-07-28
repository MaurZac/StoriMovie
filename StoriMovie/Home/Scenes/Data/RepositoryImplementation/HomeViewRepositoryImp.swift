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
   
    func fetchTopRated(page: Int) -> AnyPublisher<[Movie], Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=\(page)") else {
            fatalError("Invalid URL for top rated movies")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
    
}


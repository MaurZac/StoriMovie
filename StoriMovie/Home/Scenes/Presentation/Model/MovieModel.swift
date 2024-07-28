//
//  MovieModel.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        
    }
    
    
}


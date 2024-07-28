//
//  HomeViewRepository.swift
//  StoriMovie
//
//  Created by MaurZac on 27/07/24.
//

import Foundation
import Combine

protocol HomeViewRepository {
    func fetchTopRated(page:Int) -> AnyPublisher<[Movie], Error>
}



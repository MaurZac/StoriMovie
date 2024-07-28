//
//  HomeViewUseCase.swift
//  StoriMovie
//
//  Created by MaurZac on 27/07/24.
//

import Combine
import Foundation

final class HomeViewUseCase {
    private let repository: HomeViewRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: HomeViewRepository) {
        self.repository = repository
    }
    
    func fetchTopRated(page: Int) -> AnyPublisher<[Movie], Error> {
        return repository.fetchTopRated(page: page)
    }
    
}

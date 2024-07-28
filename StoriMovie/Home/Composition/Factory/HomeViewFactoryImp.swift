//
//  HomeViewFactoryImp.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import Foundation
import UIKit

protocol HomeViewControllerFactory {
    func makeMovieInfo(movie: Movie) -> MovieInfoView
}

final class HomeViewFactoryImp: HomeViewControllerFactory {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeMovieInfo(movie: Movie) -> MovieInfoView {
        let viewModel = MovieInfoViewModel(movie: movie)
        return MovieInfoView(viewModel: viewModel)
    }
    
}


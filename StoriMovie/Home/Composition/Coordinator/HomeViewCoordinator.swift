//
//  HomeViewCoordinator.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func navigateToMovieInfo(movie: Movie)
    
}

final class HomeViewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var viewControllerFactory: HomeViewControllerFactory
    
    init(navigationController: UINavigationController, viewControllerFactory: HomeViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let homeView = HomeView()
        homeView.coordinator = self
        navigationController.pushViewController(homeView, animated: false)
    }
    
    func navigateToMovieInfo(movie: Movie) {
        let movieInfoViewModel = MovieInfoViewModel(movie: movie)
        let detailViewController = viewControllerFactory.makeMovieInfo(movie: movie)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}

//
//  HomeTabBarCoordinator.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit

final class HomeTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewControllerFactory: HomeTabBarFactory

    init(navigationController: UINavigationController, viewControllerFactory: HomeTabBarFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    func start() {
        let tabBarViewModel = HomeTabBarViewModel()
        let tabBarView = HomeTabBarView(viewModel: tabBarViewModel, coordinator: self, viewControllerFactory: viewControllerFactory)
        navigationController.setViewControllers([tabBarView], animated: false)
    }

    func startHome() {
        let homeViewController = viewControllerFactory.makeHomeViewController(coordinator: self)
        navigationController.pushViewController(homeViewController, animated: false)
    }

    func navigateToMovieInfo(movie: Movie) {
        let movieInfoView = viewControllerFactory.makeMovieInfoViewController(movie: movie)
        navigationController.pushViewController(movieInfoView, animated: true)
    }
    
    func navigateToMovieInfo() {
         let watchlistViewController = viewControllerFactory.makeWatchlistViewController()
         navigationController.pushViewController(watchlistViewController, animated: true)
     }
}



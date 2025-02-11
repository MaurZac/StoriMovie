//
//  HomeTabBarFactory.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit

protocol HomeTabBarFactory {
    func makeHomeViewController(coordinator: Coordinator) -> UIViewController
    func makeMovieInfoViewController(movie: Movie) -> UIViewController
    func makeWatchlistViewController() -> UIViewController
}

final class HomeTabBarFactoryImp: HomeTabBarFactory {
    
    func makeHomeViewController(coordinator: Coordinator) -> UIViewController {
        let homeNavigationController = UINavigationController()
        let homeViewControllerFactory = HomeViewFactoryImp(navigationController: homeNavigationController)
        let homeCoordinator = HomeViewCoordinator(navigationController: homeNavigationController, viewControllerFactory: homeViewControllerFactory)
        homeCoordinator.start()
        let homeVC = homeNavigationController.viewControllers.first!
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "movieclapper"), tag: 0)
        return homeNavigationController
    }

    func makeMovieInfoViewController(movie: Movie) -> UIViewController {
        let homeNavigationController = UINavigationController()
        let factory = HomeTabBarFactoryImp()
        let coordinator = HomeTabBarCoordinator(navigationController: homeNavigationController, viewControllerFactory: factory)
        let movieInfoViewModel = MovieInfoViewModel(movie: movie)
        let movieInfoView = MovieInfoView(viewModel: movieInfoViewModel, coordinator: coordinator)
        return movieInfoView
    }

    func makeWatchlistViewController() -> UIViewController {
        let watchListViewModel = WatchListViewModel()
        let WatchListView = WatchListView(viewModel: watchListViewModel)
        WatchListView.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), tag: 0)
        return WatchListView
    }
       
}


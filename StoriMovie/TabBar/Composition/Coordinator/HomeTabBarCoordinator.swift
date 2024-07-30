//
//  HomeTabBarCoordinator.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit

final class HomeTabBarCoordinator: Coordinator {
    
    func presentCustomAlert(image: UIImage?, title: String, description: String, firstButtonTitle: String?, secondButtonTitle: String?, firstButtonAction: (() -> Void)?, secondButtonAction: (() -> Void)?) {
        let customAlertVC = UIAlertDialog(
                firstButtonTitle: firstButtonTitle,
                secondButtonTitle: secondButtonTitle,
                firstButtonAction: firstButtonAction,
                secondButtonAction: secondButtonAction
            )
            customAlertVC.image = image
            customAlertVC.titleText = title
            customAlertVC.descriptionText = description

            customAlertVC.modalPresentationStyle = .overFullScreen
            customAlertVC.modalTransitionStyle = .crossDissolve
            
            if let viewController = navigationController.visibleViewController {
                viewController.present(customAlertVC, animated: true, completion: nil)
            } else {
                navigationController.topViewController?.present(customAlertVC, animated: true, completion: nil)
            }
        
    }
    
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
        //let movieInfoView = viewControllerFactory.makeMovieInfoViewController(movie: movie)
        let movieInfoView = viewControllerFactory.makeMovieInfoViewController(movie: movie)
              movieInfoView.modalPresentationStyle = .fullScreen // Opcional: configura el estilo de presentación

              if let topViewController = navigationController.topViewController {
                  topViewController.present(movieInfoView, animated: true, completion: nil)
              } else {
                  navigationController.present(movieInfoView, animated: true, completion: nil)
              }

    }
    
    func navigateToMovieInfo() {
         let watchlistViewController = viewControllerFactory.makeWatchlistViewController()
         navigationController.pushViewController(watchlistViewController, animated: true)
     }
}



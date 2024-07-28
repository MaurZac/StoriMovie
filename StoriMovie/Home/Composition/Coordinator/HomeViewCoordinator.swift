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
    func presentCustomAlert(
            image: UIImage?,
            title: String,
            description: String,
            firstButtonTitle: String?,
            secondButtonTitle: String?,
            firstButtonAction: (() -> Void)?,
            secondButtonAction: (() -> Void)?
        )
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
    
}

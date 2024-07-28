//
//  SceneDelegate.swift
//  StoriMovie
//
//  Created by MaurZac on 24/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: HomeTabBarCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: viewController.view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: viewController.view.heightAnchor, multiplier: 0.5)
        ])
        
        performExpandAndFadeInAnimation(for: imageView, in: viewController)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let viewControllerFactory = HomeTabBarFactoryImp()
        coordinator = HomeTabBarCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        coordinator?.start()
    }
    
    func performExpandAndFadeInAnimation(for imageView: UIImageView, in viewController: UIViewController) {
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) // Inicialmente pequeña
        imageView.center = viewController.view.center // Inicialmente centrada
        
        viewController.view.addSubview(imageView)
        
        UIView.animate(withDuration: 1.0, animations: {
            let scaleX: CGFloat = 1.8
            let scaleY: CGFloat = 1.8
            imageView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            imageView.center = viewController.view.center
            imageView.alpha = 1
        })
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
}


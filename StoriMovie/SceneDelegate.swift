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
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
          window = UIWindow(windowScene: windowScene)
          
          let splashViewController = UIViewController()
          splashViewController.view.backgroundColor = .white
          
          let imageView = UIImageView(image: UIImage(named: "Logo"))
          imageView.contentMode = .scaleAspectFit
          imageView.translatesAutoresizingMaskIntoConstraints = false
          splashViewController.view.addSubview(imageView)
          
          NSLayoutConstraint.activate([
              imageView.centerXAnchor.constraint(equalTo: splashViewController.view.centerXAnchor),
              imageView.centerYAnchor.constraint(equalTo: splashViewController.view.centerYAnchor),
              imageView.widthAnchor.constraint(equalTo: splashViewController.view.widthAnchor, multiplier: 0.8),
              imageView.heightAnchor.constraint(equalTo: splashViewController.view.heightAnchor, multiplier: 0.8)
          ])
          
          window?.rootViewController = splashViewController
          window?.makeKeyAndVisible()
          
          performExpandAndFadeInAnimation(for: imageView, on: splashViewController)
      }
      
      private func performExpandAndFadeInAnimation(for imageView: UIImageView, on viewController: UIViewController) {
          imageView.alpha = 0
          imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
          
          UIView.animate(withDuration: 2.0, animations: {
              imageView.transform = CGAffineTransform.identity
              imageView.alpha = 1
          }) { _ in
              self.transitionToMainApp()
          }
      }
      
      private func transitionToMainApp() {
          let navigationController = UINavigationController()
          let viewControllerFactory = HomeTabBarFactoryImp()
          coordinator = HomeTabBarCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
          
          let _: ()? = coordinator?.start()
          window?.rootViewController = navigationController
          window?.makeKeyAndVisible()
      }

    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
    
}


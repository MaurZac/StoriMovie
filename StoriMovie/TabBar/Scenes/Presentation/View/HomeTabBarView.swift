//
//  HomeTabBarView.swift
//  StoriMovie
//
//  Created by MaurZac on 26/07/24.
//

import UIKit
import Combine

final class HomeTabBarView: UITabBarController {
        
        private var viewModel: HomeTabBarViewModel!
        private var cancellables = Set<AnyCancellable>()
        private var coordinator: HomeTabBarCoordinator
        private var viewControllerFactory: HomeTabBarFactory
        
        init(viewModel: HomeTabBarViewModel, coordinator: HomeTabBarCoordinator, viewControllerFactory: HomeTabBarFactory) {
            self.viewModel = viewModel
            self.coordinator = coordinator
            self.viewControllerFactory = viewControllerFactory
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViewControllers()
            setupBindings()
            
            tabBar.tintColor = ColorUtils.mainGreen
            tabBar.unselectedItemTintColor = ColorUtils.GrayGreenTwo
            tabBar.backgroundColor = ColorUtils.white
            
            for item in tabBar.items ?? [] {
                item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            let tabBarHeight: CGFloat = 90
                let safeAreaBottomInset = view.safeAreaInsets.bottom
                let totalHeight = tabBarHeight + safeAreaBottomInset
                let tabBarY = view.bounds.height - totalHeight + 10
                
                tabBar.frame = CGRect(x: 0, y: tabBarY, width: view.bounds.width, height: totalHeight)
                
                let visibleTabBarRect = CGRect(x: 0, y: safeAreaBottomInset, width: tabBar.bounds.width, height: tabBarHeight)
                let maskPath = UIBezierPath(roundedRect: visibleTabBarRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
                let maskLayer = CAShapeLayer()
                maskLayer.path = maskPath.cgPath
                tabBar.layer.mask = maskLayer
                let borderLayer = CAShapeLayer()
                borderLayer.path = maskPath.cgPath
                borderLayer.strokeColor = ColorUtils.Olive.cgColor
                borderLayer.fillColor = UIColor.clear.cgColor
                borderLayer.lineWidth = 1.5
                tabBar.layer.addSublayer(borderLayer)
        }
        
        private func setupViewControllers() {
            let homeVC = viewControllerFactory.makeHomeViewController(coordinator: coordinator)
            let watchList = viewControllerFactory.makeWatchlistViewController()
            viewControllers = [homeVC, watchList]
        }
        
        private func setupBindings() {
            viewModel.$selectedTab
                .sink { [weak self] selectedIndex in
                    self?.selectedIndex = selectedIndex
                }
                .store(in: &cancellables)
        }
    }

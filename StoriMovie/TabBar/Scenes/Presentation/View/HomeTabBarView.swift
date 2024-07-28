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
        
        tabBar.tintColor = ColorUtils.secondaryGreen
        tabBar.unselectedItemTintColor = ColorUtils.GrayGreen
        tabBar.backgroundColor = ColorUtils.white
        
        for item in tabBar.items ?? [] {
            item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        }
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




//
//  TabBarController.swift
//  JackFlix_Codebase
//
//  Created by gnksbm on 6/4/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        setViewControllers(
            TabKind.allCases.map { $0.makeViewController() },
            animated: false
        )
        tabBar.tintColor = .systemBackground
        tabBar.unselectedItemTintColor = .systemGray
    }
}

extension TabBarController {
    enum TabKind: Int, CaseIterable {
        case home, singUp
        
        private var title: String {
            switch self {
            case .home:
                "홈"
            case .singUp:
                "회원가입"
            }
        }
        
        private var imageName: String {
            switch self {
            case .home:
                "house"
            case .singUp:
                "person.badge.plus"
            }
        }
        
        private var tabBarItem: UITabBarItem {
            UITabBarItem(
                title: title,
                image: UIImage(systemName: imageName),
                tag: rawValue
            )
        }
        
        private var viewController: UIViewController {
            switch self {
            case .home:
                HomeViewController()
            case .singUp:
                SignUpViewController()
            }
        }
        
        func makeViewController() -> UIViewController {
            let viewController = viewController
            viewController.tabBarItem = tabBarItem
            return UINavigationController(
                rootViewController: viewController
            )
        }
    }
}

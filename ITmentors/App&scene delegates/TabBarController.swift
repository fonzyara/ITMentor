//
//  File.swift
//  ITmentors
//
//  Created by Vladimir Alecseev on 27.09.2022.
//

import Foundation
import UIKit
fileprivate enum TabBarItem: Int {
    
    case mentors
    case profile
    
    var title: String {
        switch self {
        case .mentors:
            return "Менторы"
        case .profile:
            return "Профиль"
        }
    }
    
    var iconName: String {
        switch self {
        case .mentors:
            return "house"
        case .profile:
            return "person.crop.circle"
        }
    }
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
}

extension TabBarController{
    private func setupTabBar() {
//        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.configureWithTransparentBackground()
//        tabBarAppearance.backgroundColor = .AppPalette.elementsColor
//        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = .AppPalette.thirdElementColor
        UITabBar.appearance().unselectedItemTintColor = .darkGray
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .AppPalette.elementsColor
        UITabBar.appearance().barTintColor = .AppPalette.elementsColor
        
        let dataSource: [TabBarItem] = [.mentors, .profile]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .mentors:
                let feedViewController = MentorsScreenViewController()
                return self.wrappedInNavigationController(with: feedViewController, title: $0.title)
            case .profile:
                let profileViewController = ProfileScreenViewController()
                return self.wrappedInNavigationController(with: profileViewController, title: $0.title)
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: with)
        navController.view.backgroundColor = .AppPalette.elementsColor
        navController.navigationBar.topItem?.title = title as? String
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppPalette.thirdElementColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25) ]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().isTranslucent = false
        
    
        
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}


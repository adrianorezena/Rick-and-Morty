//
//  MainTabBarController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 24/01/21.
//

import UIKit

class MainTabBarController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .red
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: kHomeTabBarTitle, image: UIImage(named: Assets.Icons.tabbar_home), tag: 0)
        let homeNavC = UINavigationController(rootViewController: homeVC)
        
        let favoritesVC = FavoritesViewController.createModule()
        favoritesVC.tabBarItem = UITabBarItem(title: kFavoritesTabBarTitle, image: UIImage(named: Assets.Icons.tabbar_favorites), tag: 1)
        let favoritesNavC = UINavigationController(rootViewController: favoritesVC)
        
        let tabBarList = [homeNavC, favoritesNavC]
        
        viewControllers = tabBarList
    }
    
}

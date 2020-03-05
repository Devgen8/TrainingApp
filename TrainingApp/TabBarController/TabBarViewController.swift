//
//  TabBarViewController.swift
//  TrainingApp
//
//  Created by мак on 13/02/2020.
//  Copyright © 2020 мак. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.rootViewController = self
        //setupTabBarItems()
    }
    
//    func setupTabBarItems() {
//        let homeViewController = UINavigationController(rootViewController: HomeViewController())
//        homeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "house").withRenderingMode(.alwaysOriginal), tag: 0)
//        homeViewController.navigationBar.topItem?.title = "Home"
//
//        let recipesViewController = UINavigationController(rootViewController: RecipesViewController())
//        recipesViewController.tabBarItem = UITabBarItem(title: "", image:  #imageLiteral(resourceName: "recipe").withRenderingMode(.alwaysOriginal), tag: 1)
//        recipesViewController.navigationBar.topItem?.title = "Recipes"
//
//        let shoppingListViewController = UINavigationController(rootViewController: ShoppingListViewController())
//        shoppingListViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "checklist").withRenderingMode(.alwaysOriginal), tag: 2)
//        shoppingListViewController.navigationBar.topItem?.title = "Shopping list"
//
//        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
//        profileViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "user").withRenderingMode(.alwaysOriginal), tag: 3)
//        profileViewController.navigationBar.topItem?.title = "Profile"
//
//        viewControllers = [homeViewController, recipesViewController, shoppingListViewController, profileViewController]
//    }
}

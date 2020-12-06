//
//  MenuTabBarController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var viewControllers = [UIViewController]()
        let searchVC = UIStoryboard(name: "BookSearchViewController", bundle: nil).instantiateViewController(withIdentifier: "BookSearchNavigationController")
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        let myBookListVC = UIStoryboard(name: "MyBookListViewController", bundle: nil).instantiateViewController(withIdentifier: "MyBookListViewController")
        myBookListVC.tabBarItem = UITabBarItem(title: "MyBook", image: UIImage(systemName: "list.bullet.below.rectangle"), tag: 0)

        viewControllers.append(searchVC)
        viewControllers.append(myBookListVC)
        setViewControllers(viewControllers, animated: false)
        selectedViewController = searchVC
        
    }
}

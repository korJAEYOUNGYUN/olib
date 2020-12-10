//
//  MainCoordinator.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/08.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        let viewModel = SignInViewModel(coordinator: self)
        vc.bind(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func signUp() {
        var vc = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        let viewModel = SignUpViewModel(coordinator: self)
        vc.bind(viewModel: viewModel)
        navigationController.present(vc, animated: true)
    }

    func home() {
        let homeTabBarController = UITabBarController()

        var viewControllers = [UIViewController]()
        
        var searchVC = UIStoryboard(name: "BookSearchViewController", bundle: nil).instantiateViewController(withIdentifier: "BookSearchViewController") as! BookSearchViewController
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        let searchVM = BookSearchViewModel(coordinator: self)
        searchVC.bind(viewModel: searchVM)
        
        var myBookListVC = UIStoryboard(name: "MyBookListViewController", bundle: nil).instantiateViewController(withIdentifier: "MyBookListViewController") as! MyBookListViewController
        myBookListVC.tabBarItem = UITabBarItem(title: "MyBook", image: UIImage(systemName: "list.bullet.below.rectangle"), tag: 0)
        let myBookListVM = MyBookListViewModel(coordinator: self)
        myBookListVC.bind(viewModel: myBookListVM)
        
        viewControllers.append(searchVC)
        viewControllers.append(myBookListVC)
        homeTabBarController.setViewControllers(viewControllers, animated: false)
        homeTabBarController.selectedViewController = searchVC
        
        navigationController.pushViewController(homeTabBarController, animated: true)
    }
    
    func searchedBookList(_ queries: [String: String]?) {
        let vc = UIStoryboard(name: "SearchedBooksTableViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchedBooksTableViewController") as! SearchedBooksTableViewController
        vc.queries = queries
            
        navigationController.pushViewController(vc, animated: true)
    }
}

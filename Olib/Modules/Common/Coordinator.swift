//
//  Coordinator.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/07.
//

import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

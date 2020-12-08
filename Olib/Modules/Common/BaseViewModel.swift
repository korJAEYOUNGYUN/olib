//
//  BaseViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/03.
//

import Foundation
import RxSwift
import NSObject_Rx

class BaseViewModel: HasDisposeBag {
    
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}

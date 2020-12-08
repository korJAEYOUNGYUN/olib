//
//  ViewModelBindableType.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/03.
//

import UIKit

protocol ViewModelBindableType {
    
    associatedtype ViewModelType: BaseViewModel
    
    var viewModel: ViewModelType! { get set }
    
    func bindUI()
}

extension ViewModelBindableType where Self: UIViewController {
    
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
    }
}

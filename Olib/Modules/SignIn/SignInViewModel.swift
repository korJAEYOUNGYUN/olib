//
//  SignInViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/03.
//

import Foundation
import RxSwift

class SignInViewModel: BaseViewModel {
    
    let email = BehaviorSubject(value: "")
    let emailValidation = BehaviorSubject(value: false)
    
    override init() {
        super.init()
        
        email
            .map { $0.isValidEmail() }
            .subscribe(emailValidation)
            .disposed(by: disposeBag)
    }
}

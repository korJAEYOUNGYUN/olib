//
//  SignInViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/03.
//

import Foundation
import RxSwift
import RxRelay

class SignInViewModel: BaseViewModel {
    
    let email = PublishRelay<String>()
    let emailValidation = BehaviorRelay(value: false)
    
    let password = PublishRelay<String>()
    let passwordValidation = BehaviorRelay(value: false)
    
    override init() {
        super.init()
        
        email
            .map { $0.isValidEmail() }
            .bind(to: emailValidation)
            .disposed(by: disposeBag)
        
        password
            .map { $0.isValidPassword() }
            .bind(to: passwordValidation)
            .disposed(by: disposeBag)
    }
    
    // TODO: dismiss when authentication success
    func authenticate(with email: String, password: String) {
        AuthManager.shared.rxAuthenticate(with: email, password: password)
            .subscribe { (response) in
                print(response)
            } onError: { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

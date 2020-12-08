//
//  SignUpViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/05.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel: BaseViewModel {
    
    let email = PublishRelay<String>()
    let emailValidation = BehaviorRelay(value: false)
    
    let password = PublishRelay<String>()
    let passwordValidation = BehaviorRelay(value: false)
    
    let password2 = PublishRelay<String>()
    let password2Validation = BehaviorRelay(value: false)
    
    let passwordMatch = BehaviorRelay(value: false)
    
    override init(coordinator: MainCoordinator) {
        super.init(coordinator: coordinator)
        
        email
            .map { $0.isValidEmail() }
            .bind(to: emailValidation)
            .disposed(by: disposeBag)
        
        password
            .map { $0.isValidPassword() }
            .bind(to: passwordValidation)
            .disposed(by: disposeBag)
        
        password2
            .map { $0.isValidPassword() }
            .bind(to: password2Validation)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(passwordValidation, password2Validation, password, password2) { $0 && $1 && $2 == $3 }
            .bind(to: passwordMatch)
            .disposed(by: disposeBag)
    }
    
    func signUp(with email: String, password: String) {
        AuthManager.shared.rxSignUp(with: email, password: password)
            .subscribe { (response) in
                print(response)
            } onError: { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

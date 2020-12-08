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
    }
    
    func authenticate(with email: String, password: String) {
        AuthManager.shared.rxAuthenticate(with: email, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                switch response.statusCode {
                case 200:
                    self?.coordinator?.home()
                case 401:
                    print("no matched user")
                default:
                    print("network error")
                }
            }, onError: { (error) in
                print("error", error)
            })
            .disposed(by: disposeBag)
    }
    
    func goToSignUp() {
        self.coordinator?.signUp()
    }
}

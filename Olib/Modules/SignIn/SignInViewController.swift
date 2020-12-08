//
//  SignInViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: SignInViewModel!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }
    
    func bindUI() {
        getText(from: emailTextField.rx.text)
            .bind(to: viewModel.email)
            .disposed(by: rx.disposeBag)
        
        viewModel.emailValidation
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.emailWarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        getText(from: passwordTextField.rx.text)
            .bind(to: viewModel.password)
            .disposed(by: rx.disposeBag)
        
        viewModel.passwordValidation
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.passwordWarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        Observable.combineLatest(viewModel.emailValidation, viewModel.passwordValidation) { $0 && $1 }
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        signInButton.rx.tap
            .map { [unowned self] _ -> (String, String) in (self.emailTextField.text!, self.passwordTextField.text!) }
            .subscribe(onNext: { [weak self] in
                self?.viewModel.authenticate(with: $0, password: $1)
            })
            .disposed(by: rx.disposeBag)
        
        signUpButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.goToSignUp()
            })
            .disposed(by: rx.disposeBag)
    }
    
    func getText(from text: ControlProperty<String?>) -> Observable<String> {
        text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
}

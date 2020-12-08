//
//  SignUpViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/13.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, ViewModelBindableType {

    var viewModel: SignUpViewModel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var password2WarningLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailWarningLabel.text = String.EMAIL_INVALID
        passwordWarningLabel.text = String.PASSWORD_INVALID
        password2WarningLabel.text = String.PASSWORD_INVALID
        
        bindUI()
    }
    
    func bindUI() {
        getText(from: emailTextField.rx.text)
            .bind(to: viewModel.email)
            .disposed(by: rx.disposeBag)
        
        getText(from: passwordTextField.rx.text)
            .bind(to: viewModel.password)
            .disposed(by: rx.disposeBag)
        
        getText(from: password2TextField.rx.text)
            .bind(to: viewModel.password2)
            .disposed(by: rx.disposeBag)
        
        viewModel.emailValidation
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.emailWarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.passwordValidation
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.passwordWarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        viewModel.password2Validation
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.password2WarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        Observable.combineLatest(viewModel.emailValidation, viewModel.passwordMatch) { $0 && $1 }
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        signUpButton.rx.tap
            .map { [unowned self] _ -> (String, String) in (self.emailTextField.text!, self.passwordTextField.text!) }
            .subscribe(onNext: { [weak self] in
                self?.viewModel.signUp(with: $0, password: $1)
            })
            .disposed(by: rx.disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func getText(from text: ControlProperty<String?>) -> Observable<String> {
        text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
}

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
        
        //FIXME: for test
        viewModel = SignInViewModel()
        bindUI()
    }
    
    func bindUI() {
        emailTextField.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(viewModel.email)
            .disposed(by: rx.disposeBag)
        
        viewModel.emailValidation
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isValid in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.emailWarningLabel.isHidden = isValid
                }
            })
            .disposed(by: rx.disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(viewModel.password)
            .disposed(by: rx.disposeBag)
        
        viewModel.passwordValidation
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isValid in
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
    }
    
    @IBAction func didPresssignInButton(_ sender: UIButton) {
//        let email = emailTextField.text!
//        let password = passwordTextField.text!
//
//    private func authenticate(with email: String, password: String) {
//
//        AuthManager.shared.authenticate(with: email, password: password, completion: handleAuthenticationResponse)
//    }
//
//    func handleAuthenticationResponse(_ response: HTTPURLResponse) {
//
//        switch response.statusCode {
//        case 200:
//            DispatchQueue.main.async {
//                let menuTabController = MenuTabBarController()
//                menuTabController.modalPresentationStyle = .fullScreen
//                self.present(menuTabController, animated: true, completion: nil)
//            }
//        case 401:
//            // alert no account with the given credentials
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Signin Failed", message: "There is no user matched from given credentials.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        default:
//            // server error
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Network error", message: "Please try it later.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        // go further to signupVC
        let signUpVC = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
}

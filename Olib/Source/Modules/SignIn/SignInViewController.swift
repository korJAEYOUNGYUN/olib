//
//  SignInViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/13.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    private let EMAIL_INVALID = "ex) abc@abc.com"
    private let PASSWORD_INVALID = "Password must over 8 letters."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        if sender.text!.isValidEmail() {
            hideWarning(label: emailWarningLabel)
        } else {
            showWarning(label: emailWarningLabel, msg: .EMAIL_INVALID)
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        if sender.text!.isValidPassword() {
            hideWarning(label: passwordWarningLabel)
        } else {
            showWarning(label: passwordWarningLabel, msg: .PASSWORD_INVALID)
        }
    }
    
    @IBAction func didPresssignInButton(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !email.isValidEmail() {
            showWarning(label: emailWarningLabel, msg: .EMAIL_INVALID)
            return
        }
        if !password.isValidPassword() {
            showWarning(label: passwordWarningLabel, msg: .PASSWORD_INVALID)
            return
        }
        
        authenticate(with: email, password: password)
    }
    
    private func authenticate(with email: String, password: String) {
        startLoading()
        
        AuthManager.shared.authenticate(with: email, password: password, completion: handleAuthenticationResponse)
    }
    
    func handleAuthenticationResponse(_ response: HTTPURLResponse) {
        stopLoading()
        
        switch response.statusCode {
        case 200:
            DispatchQueue.main.async {
                let menuTabController = MenuTabBarController()
                menuTabController.modalPresentationStyle = .fullScreen
                self.present(menuTabController, animated: true, completion: nil)
            }
        case 401:
            // alert no account with the given credentials
            return
        default:
            // server error
            return
        }
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        // go further to signupVC
        let signUpVC = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    private func startLoading() {
        
    }
    
    private func stopLoading() {
        
    }
    
    private func hideWarning(label: UILabel) {
        UIView.animate(withDuration: 0.5) {
            label.isHidden = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func showWarning(label: UILabel, msg: String) {
        UIView.animate(withDuration: 0.5) {
            label.text = msg
            label.isHidden = false
            
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
}
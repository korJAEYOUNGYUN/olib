//
//  SignUpViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/13.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var password2WarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
        password2WarningLabel.isHidden = true
    }
    
    @IBAction func didPressSignUpButton(_ sender: Any) {
        guard checkEmailTextField(emailTextField), checkPasswordTextField(passwordTextField), checkPasswordTextField(password2TextField) else {
            return
        }
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let password2 = password2TextField.text!
        if password != password2 {
            return
        }

        signUp(with: email, password: password)
    }
    
    private func signUp(with email: String, password: String) {
        AuthManager.shared.signUp(with: email, password: password, completion: handleSignUpResponse)
    }
    
    private func handleSignUpResponse(_ response: HTTPURLResponse) {
        switch response.statusCode {
        case 201:
            DispatchQueue.main.async {
                let menuTabController = MenuTabBarController()
                menuTabController.modalPresentationStyle = .fullScreen
                self.present(menuTabController, animated: true, completion: nil)
            }
        case 400:
            return
        default:
            return
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        _ = checkEmailTextField(sender)
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        _ = checkPasswordTextField(sender)
    }
    
    private func checkEmailTextField(_ textField: UITextField) -> Bool {
        if textField.text!.isValidEmail() {
            hideWarning(label: emailWarningLabel)
            return true
        } else {
            showWarning(label: emailWarningLabel, msg: .EMAIL_INVALID)
            return false
        }
    }
    
    private func checkPasswordTextField(_ textField: UITextField) -> Bool {
        if textField.text!.isValidPassword() {
            if textField == passwordTextField {
                hideWarning(label: passwordWarningLabel)
            } else {
                hideWarning(label: password2WarningLabel)
            }
            return true
        } else {
            if textField == password2TextField {
                showWarning(label: passwordWarningLabel, msg: .PASSWORD_INVALID)
            } else {
                showWarning(label: password2WarningLabel, msg: .PASSWORD_INVALID)
            }
            return false
        }
    }
}

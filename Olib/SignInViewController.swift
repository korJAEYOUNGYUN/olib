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
        if isValidEmail(sender.text!) {
            hideWarning(label: emailWarningLabel)
        } else {
            showWarning(label: emailWarningLabel, msg: EMAIL_INVALID)
        }
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        if isValidPassword(sender.text!) {
            hideWarning(label: passwordWarningLabel)
        } else {
            showWarning(label: passwordWarningLabel, msg: PASSWORD_INVALID)
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if !isValidEmail(email) {
            showWarning(label: emailWarningLabel, msg: EMAIL_INVALID)
        }
        
        if !isValidPassword(password) {
            showWarning(label: passwordWarningLabel, msg: PASSWORD_INVALID)
        }
        
        // do sign in here
        // valid user credentials and get token
        // go further to menuVC
        
    }
    
    @IBAction func goToJoin(_ sender: Any) {
        // go further to joinVC
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
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
}

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
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        _ = checkEmailTextField(sender)
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        _ = checkPasswordTextField(sender)
    }
    
    @IBAction func didPresssignInButton(_ sender: UIButton) {
        guard checkEmailTextField(emailTextField), checkPasswordTextField(passwordTextField) else {
            return
        }
    
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
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
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Signin Failed", message: "There is no user matched from given credentials.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        default:
            // server error
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Network error", message: "Please try it later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        // go further to signupVC
        let signUpVC = UIStoryboard(name: "SignUpViewController", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    private func startLoading() {
        signInButton.isEnabled = false
        signUpButton.isEnabled = false
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.signInButton.isEnabled = true
            self.signUpButton.isEnabled = true
        }
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
            hideWarning(label: passwordWarningLabel)
            return true
        } else {
            showWarning(label: passwordWarningLabel, msg: .PASSWORD_INVALID)
            return false
        }
    }
}

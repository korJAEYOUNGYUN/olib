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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameWarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailWarningLabel.isHidden = true
        passwordWarningLabel.isHidden = true
        nameWarningLabel.isHidden = true
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        if sender.text!.isValidEmail() {
            hideWarning(label: emailWarningLabel)
        } else {
            showWarning(label: emailWarningLabel, msg: .EMAIL_INVALID)
        }
    }
    
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        if sender.text!.isEmpty {
            showWarning(label: nameWarningLabel, msg: .NAME_REQUIRED)
        } else {
            hideWarning(label: nameWarningLabel)
        }
        
    }
    
    @IBAction func passwordEditingChanged(_ sender: UITextField) {
        if sender.text!.isValidPassword() {
            hideWarning(label: passwordWarningLabel)
        } else {
            showWarning(label: passwordWarningLabel, msg: .PASSWORD_INVALID)
        }
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

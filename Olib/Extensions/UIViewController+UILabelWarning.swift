//
//  UIViewController+UILabelWarning.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/11.
//

import UIKit

extension UIViewController {
    
    func hideWarning(label: UILabel) {
        UIView.animate(withDuration: 0.5) {
            label.isHidden = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    func showWarning(label: UILabel, msg: String) {
        UIView.animate(withDuration: 0.5) {
            label.text = msg
            label.isHidden = false
            
            self.view.layoutIfNeeded()
        }
    }

}

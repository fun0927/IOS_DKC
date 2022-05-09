//
//  UIVIewControllerExtension.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/15.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
}

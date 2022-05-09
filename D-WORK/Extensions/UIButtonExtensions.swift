//
//  UIButtonExtensions.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/30.
//

import Foundation
import UIKit
extension UIButton {
    func setDisable() {
        self.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        self.isEnabled = false
    }
    func setEnable(){
        self.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        self.isEnabled = true
    }
    override public var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                self.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
            } else {
                self.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
            }
        }
    }
}

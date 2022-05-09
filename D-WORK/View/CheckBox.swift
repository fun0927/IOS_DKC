//
//  CheckBox.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import UIKit

class CheckBox: UIButton {
    var name = ""
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    weak var delegate : CheckBoxProtocol? = nil
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .white
        self.setImage(UIImage(named: "uncheck"), for: .normal)
        self.setImage(UIImage(named: "check"), for: .selected)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        self.isSelected = !self.isSelected
        self.delegate?.onSelectChange(name: name, isSelected: self.isSelected)
    }
    
}

protocol CheckBoxProtocol : NSObjectProtocol{
    func onSelectChange(name:String, isSelected: Bool)
}



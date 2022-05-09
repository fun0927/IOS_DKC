//
//  LaunchCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    static let ID = "LaunchCollectionViewCell"
 
    
    let tfAddNm: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let tfAddNum: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let btnMinus: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-minus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 22, bottom: 25, right: 22)
        button.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
//        button.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
//        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.addSubview(btnMinus)
        btnMinus.translatesAutoresizingMaskIntoConstraints = false
        btnMinus.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        btnMinus.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        btnMinus.widthAnchor.constraint(equalToConstant: 59).isActive = true
        btnMinus.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(tfAddNum)
        tfAddNum.translatesAutoresizingMaskIntoConstraints = false
        tfAddNum.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tfAddNum.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tfAddNum.trailingAnchor.constraint(equalTo: btnMinus.leadingAnchor, constant: -8).isActive = true
        tfAddNum.widthAnchor.constraint(equalToConstant: 82).isActive = true
        
        self.addSubview(tfAddNm)
        tfAddNm.translatesAutoresizingMaskIntoConstraints = false
        tfAddNm.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tfAddNm.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tfAddNm.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tfAddNm.trailingAnchor.constraint(equalTo: tfAddNum.leadingAnchor, constant: -8).isActive = true
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

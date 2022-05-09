//
//  AuthUserCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit

class AuthUserCollectionViewCell: UICollectionViewCell {
    static let ID = "AuthUserCollectionViewCell"
    
    let lblLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblLabel)
        lblLabel.translatesAutoresizingMaskIntoConstraints = false
        lblLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        addSubview(lblValue)
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        lblValue.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105).isActive = true
        lblValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        let divider = UIView()
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


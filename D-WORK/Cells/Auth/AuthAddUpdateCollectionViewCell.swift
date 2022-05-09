//
//  AuthAddCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit

class AuthAddUpdateCollectionViewCell: UICollectionViewCell {
    static let ID = "AuthAddUpdateCollectionViewCell"
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "사용자"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
        
     let lblValue: UILabel = {
         let label = UILabel()
         label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
         label.textColor = .black
         return label
     }()
    
    var dropDown = DropDownBtn()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        addSubview(lblValue)
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        lblValue.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 119).isActive = true
        
        
    
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  EditShortCutCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/18.
//

import UIKit

class EditShortCutCollectionViewCell: UICollectionViewCell {
    static let ID = "EditShortCutCollectionViewCell"
    
    let ivIcon = UIImageView()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
//        label.textColor = UIColor.white
        return label
    }()
    
    let cbCheck = CheckBox()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
//        self.backgroundColor = .blue
        
         
        ivIcon.image = UIImage(named: "mainTimer")
        self.addSubview(ivIcon)
        ivIcon.translatesAutoresizingMaskIntoConstraints = false
        ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        ivIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        lblTitle.heightAnchor.constraint(equalToConstant: 18).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: ivIcon.trailingAnchor, constant: 16).isActive = true
        lblTitle.textAlignment = .center
        
        
        self.addSubview(cbCheck)
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cbCheck.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.isUserInteractionEnabled = false
        
       
        
        
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 0.2)
        self.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

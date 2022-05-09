//
//  WaterRegisterInOutCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import UIKit

class WaterRegisterInOutCollectionViewCell: UICollectionViewCell {
    static let ID = "WaterRegisterInOutCollectionViewCell"
 
    let ivIcon = UIImageView()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblTime:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        self.addSubview(lblTime)
        lblTime.translatesAutoresizingMaskIntoConstraints = false
        lblTime.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
     
        
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

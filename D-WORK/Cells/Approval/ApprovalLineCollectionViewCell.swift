//
//  ApprovalLineCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit

class ApprovalLineCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalLineCollectionViewCell"
    
    let lblLine: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblLine)
        lblLine.translatesAutoresizingMaskIntoConstraints = false
        lblLine.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        lblLine.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblName)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
      
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




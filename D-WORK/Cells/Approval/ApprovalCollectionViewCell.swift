//
//  ApprovalCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit

class ApprovalCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalCollectionViewCell"
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
        return label
    }()
    
    let lblContent: UILabel = {
        let label = UILabel()
        label.text = "기간"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblCount: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        return label
    }()
    
  
    let divider = UIView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
     
        addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
//        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        addSubview(lblContent)
        lblContent.translatesAutoresizingMaskIntoConstraints = false
        lblContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        lblContent.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblCount)
        lblCount.translatesAutoresizingMaskIntoConstraints = false
        lblCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        lblCount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblCount.widthAnchor.constraint(equalToConstant: 30).isActive = true
        lblCount.heightAnchor.constraint(equalToConstant: 30).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




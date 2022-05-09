//
//  ApprovalUserCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit

class ApprovalUserCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalUserCollectionViewCell"
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




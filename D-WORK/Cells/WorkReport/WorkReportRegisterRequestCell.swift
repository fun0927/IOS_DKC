//
//  WorkReportRegisterRequestCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import UIKit

class WorkReportRegisterRequestCell: UICollectionViewCell {
    static let ID = "WorkReportRegisterRequestCell"
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblContent: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        addSubview(lblContent)
        lblContent.translatesAutoresizingMaskIntoConstraints = false
        lblContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lblContent.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

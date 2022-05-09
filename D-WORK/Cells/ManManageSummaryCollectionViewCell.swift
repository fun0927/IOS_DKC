//
//  ManManageSummaryCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/20.
//

import UIKit

class ManManageSummaryCollectionViewCell: UICollectionViewCell {
    static let ID = "ManManageSummaryCollectionViewCell"
 
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        addSubview(lblValue)
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        lblValue.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblValue.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lblValue.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

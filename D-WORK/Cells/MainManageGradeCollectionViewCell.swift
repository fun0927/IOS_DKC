//
//  MainManageGradeCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/20.
//

import UIKit

class MainManageGradeCollectionViewCell: UICollectionViewCell {
    static let ID = "MainManageGradeCollectionViewCell"
 
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 23).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        lblTitle.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lblTitle.textAlignment = .center
        
        
        addSubview(lblValue)
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        lblValue.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 2).isActive = true
        lblValue.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblValue.textAlignment = .center
        

      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

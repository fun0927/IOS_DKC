//
//  CardInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit

class CardInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "CardInfoListCollectionViewCell"
    
    let lblreqDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblexPur: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblforeAmtNum: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblstat: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
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
        
        addSubview(lblreqDate)
        lblreqDate.translatesAutoresizingMaskIntoConstraints = false
        lblreqDate.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblreqDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblreqDate.widthAnchor.constraint(equalToConstant: 77).isActive = true
        lblreqDate.numberOfLines = 2
        
        addSubview(lblexPur)
        lblexPur.translatesAutoresizingMaskIntoConstraints = false
        lblexPur.leadingAnchor.constraint(equalTo: lblreqDate.trailingAnchor).isActive = true
        lblexPur.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblexPur.widthAnchor.constraint(equalToConstant: 137).isActive = true
        lblexPur.numberOfLines = 2
        
        addSubview(lblforeAmtNum)
        lblforeAmtNum.translatesAutoresizingMaskIntoConstraints = false
        lblforeAmtNum.leadingAnchor.constraint(equalTo: lblexPur.trailingAnchor).isActive = true
        lblforeAmtNum.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblforeAmtNum.widthAnchor.constraint(equalToConstant: 81).isActive = true
        
        addSubview(lblstat)
        lblstat.translatesAutoresizingMaskIntoConstraints = false
        lblstat.leadingAnchor.constraint(equalTo: lblforeAmtNum.trailingAnchor).isActive = true
        lblstat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        lblstat.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


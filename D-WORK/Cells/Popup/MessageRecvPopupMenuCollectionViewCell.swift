//
//  MessageRecvPopupMenuCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/13.
//

import UIKit

class MessageRecvPopupMenuCollectionViewCell: UICollectionViewCell {
    static let ID = "MessageRecvPopupMenuCollectionViewCell"
    
    let lblMenu: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let divider = UIView()
    let bottomDivider = UIView()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        
        addSubview(bottomDivider)
        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        bottomDivider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomDivider.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomDivider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        
        
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 2).isActive = true
        divider.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        
        addSubview(lblMenu)
        lblMenu.translatesAutoresizingMaskIntoConstraints = false
        lblMenu.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblMenu.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

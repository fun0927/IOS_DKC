//
//  MessageRecvPopupListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/14.
//

import UIKit

class MessageRecvPopupListCollectionViewCell: UICollectionViewCell {
    static let ID = "MessageRecvPopupListCollectionViewCell"
    
    let lblCheck: UILabel = {
        let label = UILabel()
        label.text = "선택"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblDivNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    
    let lblDeptNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let cbCheck = CheckBox()
    let stackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblCheck)
        lblCheck.translatesAutoresizingMaskIntoConstraints = false
        lblCheck.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblCheck.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblCheck.widthAnchor.constraint(equalToConstant: 69).isActive = true
        lblCheck.textAlignment = .center
        
        
        self.addSubview(cbCheck)
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cbCheck.centerXAnchor.constraint(equalTo: lblCheck.centerXAnchor).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.isUserInteractionEnabled = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: lblCheck.trailingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SendHistDetailRecvCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import UIKit

class SendHistDetailRecvCollectionViewCell: UICollectionViewCell {
    static let ID = "SendHistDetailRecvCollectionViewCell"
    let lbldeptNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblprsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        
        addSubview(lbldeptNm)
        lbldeptNm.translatesAutoresizingMaskIntoConstraints = false
        lbldeptNm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        lbldeptNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblprsnNm)
        lblprsnNm.translatesAutoresizingMaskIntoConstraints = false
        lblprsnNm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        lblprsnNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


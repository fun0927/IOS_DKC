//
//  SendHistInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/14.
//

import UIKit

class SendHistInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "SendHistInfoListCollectionViewCell"
    
    let lblTtl: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    let ivUser:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        return imageView
    }()
    let lblsendPrsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblsendDtm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        addSubview(lblTtl)
        lblTtl.translatesAutoresizingMaskIntoConstraints = false
        lblTtl.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblTtl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblTtl.numberOfLines = 2
        
        addSubview(ivUser)
        ivUser.translatesAutoresizingMaskIntoConstraints = false
        ivUser.topAnchor.constraint(equalTo: topAnchor, constant: 59).isActive = true
        ivUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        ivUser.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivUser.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(lblsendDtm)
        lblsendDtm.translatesAutoresizingMaskIntoConstraints = false
        lblsendDtm.centerYAnchor.constraint(equalTo: ivUser.centerYAnchor).isActive = true
        lblsendDtm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(lblsendPrsnNm)
        lblsendPrsnNm.translatesAutoresizingMaskIntoConstraints = false
        lblsendPrsnNm.leadingAnchor.constraint(equalTo: ivUser.trailingAnchor, constant: 16).isActive = true
        lblsendPrsnNm.centerYAnchor.constraint(equalTo: ivUser.centerYAnchor).isActive = true
        lblsendPrsnNm.numberOfLines = 2
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


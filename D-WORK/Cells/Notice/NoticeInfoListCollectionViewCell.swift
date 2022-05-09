//
//  NoticeInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import UIKit

class NoticeInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "NoticeInfoListCollectionViewCell"
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let ivUser: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        return imageView
    }()
    
    let lblprsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let ivView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "view")
        return imageView
    }()
    
    let lblreadCnt: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblregDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
//        layer.borderColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        
        addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        addSubview(ivUser)
        ivUser.translatesAutoresizingMaskIntoConstraints = false
        ivUser.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        ivUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        ivUser.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivUser.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(lblprsnNm)
        lblprsnNm.translatesAutoresizingMaskIntoConstraints = false
        lblprsnNm.leadingAnchor.constraint(equalTo: ivUser.trailingAnchor, constant: 8).isActive = true
        lblprsnNm.centerYAnchor.constraint(equalTo: ivUser.centerYAnchor).isActive = true
        lblprsnNm.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        addSubview(ivView)
        ivView.translatesAutoresizingMaskIntoConstraints = false
        ivView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 52).isActive = true
        ivView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        ivView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(lblreadCnt)
        lblreadCnt.translatesAutoresizingMaskIntoConstraints = false
        lblreadCnt.leadingAnchor.constraint(equalTo: ivView.trailingAnchor, constant: 8).isActive = true
        lblreadCnt.centerYAnchor.constraint(equalTo: ivView.centerYAnchor).isActive = true
        lblreadCnt.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
        
        addSubview(lblregDate)
        lblregDate.translatesAutoresizingMaskIntoConstraints = false
        lblregDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21).isActive = true
        lblregDate.centerYAnchor.constraint(equalTo: ivView.centerYAnchor).isActive = true
        lblregDate.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

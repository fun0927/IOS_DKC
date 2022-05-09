//
//  AuthInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit

class AuthInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "AuthInfoListCollectionViewCell"
    
    let lblpgmNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  .black
        return label
    }()
    let lblactPermission: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  .black
        return label
    }()
    let lbldivPermission: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  .black
        return label
    }()
    let cbCheck = CheckBox()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(cbCheck)
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cbCheck.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        cbCheck.isUserInteractionEnabled = false
       
        addSubview(lblpgmNm)
        lblpgmNm.translatesAutoresizingMaskIntoConstraints = false
        lblpgmNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblpgmNm.leadingAnchor.constraint(equalTo: cbCheck.trailingAnchor, constant: 26).isActive = true
        lblpgmNm.widthAnchor.constraint(equalToConstant: 109).isActive = true
        
        addSubview(lblactPermission)
        lblactPermission.translatesAutoresizingMaskIntoConstraints = false
        lblactPermission.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblactPermission.leadingAnchor.constraint(equalTo: lblpgmNm.trailingAnchor, constant: 19).isActive = true
        lblactPermission.widthAnchor.constraint(equalToConstant: 59).isActive = true
        
        addSubview(lbldivPermission)
        lbldivPermission.translatesAutoresizingMaskIntoConstraints = false
        lbldivPermission.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbldivPermission.leadingAnchor.constraint(equalTo: lblactPermission.trailingAnchor, constant: 5).isActive = true
        lbldivPermission.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


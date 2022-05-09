//
//  WorkNoZCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/26.
//

import UIKit

class WorkNoZCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkNoZCollectionViewCell"
    
    let lblCd: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblNm: UILabel = {
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
        
        addSubview(lblCd)
        lblCd.translatesAutoresizingMaskIntoConstraints = false
        lblCd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblCd.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblCd.widthAnchor.constraint(equalToConstant: 114).isActive = true
        
        addSubview(lblNm)
        lblNm.translatesAutoresizingMaskIntoConstraints = false
        lblNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblNm.leadingAnchor.constraint(equalTo: lblCd.trailingAnchor, constant: 18).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

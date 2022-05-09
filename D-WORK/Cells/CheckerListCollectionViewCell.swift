//
//  CheckerListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit

class CheckerListCollectionViewCell: UICollectionViewCell {
    static let ID = "CheckerListCollectionViewCell"
    
    let lblMakeDate: UILabel = {
        let label = UILabel()
        label.text = "작성일"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "기간"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblDutyCodeNm: UILabel = {
        let label = UILabel()
        label.text = "근태"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblApprStateNm: UILabel = {
        let label = UILabel()
        label.text = "상태"
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
        
        addSubview(lblDutyCodeNm)
        lblDutyCodeNm.translatesAutoresizingMaskIntoConstraints = false
        lblDutyCodeNm.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16).isActive = true
        lblDutyCodeNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        lblDutyCodeNm.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lblMakeDate)
        lblMakeDate.translatesAutoresizingMaskIntoConstraints = false
        lblMakeDate.trailingAnchor.constraint(equalTo: lblDutyCodeNm.leadingAnchor).isActive = true
        lblMakeDate.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblMakeDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblMakeDate.widthAnchor.constraint(equalToConstant: 73).isActive = true
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDate.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(lblApprStateNm)
        lblApprStateNm.translatesAutoresizingMaskIntoConstraints = false
        lblApprStateNm.leadingAnchor.constraint(equalTo: lblDate.trailingAnchor).isActive = true
        lblApprStateNm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        lblApprStateNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        lblApprStateNm.widthAnchor.constraint(equalToConstant: 39).isActive = true
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


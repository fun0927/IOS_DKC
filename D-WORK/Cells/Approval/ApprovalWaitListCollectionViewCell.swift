//
//  ApprovalWaitListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import UIKit

class ApprovalWaitListCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalWaitListCollectionViewCell"
    
    let lbluserType: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lbldraftName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblsubject: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblstatusCd: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
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
       
        let eachWidth = frame.width / 5
        
        addSubview(lbluserType)
        lbluserType.translatesAutoresizingMaskIntoConstraints = false
        lbluserType.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbluserType.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lbluserType.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        lbluserType.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lbldraftName)
        lbldraftName.translatesAutoresizingMaskIntoConstraints = false
        lbldraftName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbldraftName.leadingAnchor.constraint(equalTo: lbluserType.trailingAnchor).isActive = true
        lbldraftName.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        lbldraftName.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
        addSubview(lblsubject)
        lblsubject.translatesAutoresizingMaskIntoConstraints = false
        lblsubject.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblsubject.leadingAnchor.constraint(equalTo: lbldraftName.trailingAnchor).isActive = true
        lblsubject.widthAnchor.constraint(equalToConstant: eachWidth*2).isActive = true
        lblsubject.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
        
        
        addSubview(lblstatusCd)
        lblstatusCd.translatesAutoresizingMaskIntoConstraints = false
        lblstatusCd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblstatusCd.leadingAnchor.constraint(equalTo: lblsubject.trailingAnchor).isActive = true
        lblstatusCd.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lblstatusCd.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
      
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




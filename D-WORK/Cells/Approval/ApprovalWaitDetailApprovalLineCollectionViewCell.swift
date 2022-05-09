//
//  ApprovalWaitDetailApprovalLineCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import UIKit

class ApprovalWaitDetailApprovalLineCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalWaitDetailApprovalLineCollectionViewCell"
    
    let lbluserSeq: UILabel = {
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
    
    let lblprsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblsysDate: UILabel = {
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
        
        let eachWidth = frame.width / 5
        
        addSubview(lbluserSeq)
        lbluserSeq.translatesAutoresizingMaskIntoConstraints = false
        lbluserSeq.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbluserSeq.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lbluserSeq.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        lbluserSeq.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblstatusCd)
        lblstatusCd.translatesAutoresizingMaskIntoConstraints = false
        lblstatusCd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblstatusCd.leadingAnchor.constraint(equalTo: lbluserSeq.trailingAnchor).isActive = true
        lblstatusCd.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        lblstatusCd.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
        addSubview(lblprsnNm)
        lblprsnNm.translatesAutoresizingMaskIntoConstraints = false
        lblprsnNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblprsnNm.leadingAnchor.constraint(equalTo: lblstatusCd.trailingAnchor).isActive = true
        lblprsnNm.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        lblprsnNm.heightAnchor.constraint(equalToConstant: 23).isActive = true
      
        addSubview(lblsysDate)
        lblsysDate.translatesAutoresizingMaskIntoConstraints = false
        lblsysDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblsysDate.leadingAnchor.constraint(equalTo: lblprsnNm.trailingAnchor).isActive = true
        lblsysDate.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lblsysDate.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




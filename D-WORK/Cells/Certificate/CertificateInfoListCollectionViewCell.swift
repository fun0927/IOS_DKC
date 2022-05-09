//
//  CertificateInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit

class CertificateInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "CertificateInfoListCollectionViewCell"
    
    let lblreqDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblcertifiType: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblremark: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblerpStatus: UILabel = {
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
        
        addSubview(lblreqDate)
        lblreqDate.translatesAutoresizingMaskIntoConstraints = false
        lblreqDate.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblreqDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblreqDate.widthAnchor.constraint(equalToConstant: 101).isActive = true
        
        addSubview(lblcertifiType)
        lblcertifiType.translatesAutoresizingMaskIntoConstraints = false
        lblcertifiType.leadingAnchor.constraint(equalTo: lblreqDate.trailingAnchor).isActive = true
        lblcertifiType.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblcertifiType.widthAnchor.constraint(equalToConstant: 49).isActive = true
        
        addSubview(lblremark)
        lblremark.translatesAutoresizingMaskIntoConstraints = false
        lblremark.leadingAnchor.constraint(equalTo: lblcertifiType.trailingAnchor).isActive = true
        lblremark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblremark.widthAnchor.constraint(equalToConstant: 134).isActive = true
        lblremark.numberOfLines = 2
        
        addSubview(lblerpStatus)
        lblerpStatus.translatesAutoresizingMaskIntoConstraints = false
        lblerpStatus.leadingAnchor.constraint(equalTo: lblremark.trailingAnchor).isActive = true
        lblerpStatus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        lblerpStatus.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


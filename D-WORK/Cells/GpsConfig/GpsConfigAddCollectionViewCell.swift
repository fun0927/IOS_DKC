//
//  GpsConfigAddCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import UIKit

class GpsConfigAddCollectionViewCell: UICollectionViewCell {
    static let ID = "GpsConfigAddCollectionViewCell"
    
    let lblPlaceName: UILabel = {
        let label = UILabel()
        label.text = ""
//        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblRoadAddressName: UILabel = {
        let label = UILabel()
        label.text = ""
//        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblAddressName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    
    let lblAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "지번"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
   

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
        
        
        addSubview(lblPlaceName)
        lblPlaceName.translatesAutoresizingMaskIntoConstraints = false
        lblPlaceName.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblPlaceName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        lblPlaceName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblRoadAddressName)
        lblRoadAddressName.translatesAutoresizingMaskIntoConstraints = false
        lblRoadAddressName.topAnchor.constraint(equalTo: topAnchor, constant: 47).isActive = true
        lblRoadAddressName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        lblRoadAddressName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblAddressLabel)
        lblAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        lblAddressLabel.widthAnchor.constraint(equalToConstant: 42).isActive = true
        lblAddressLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        lblAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        lblAddressLabel.topAnchor.constraint(equalTo: topAnchor, constant: 81).isActive = true
        lblAddressLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        lblAddressLabel.layer.borderWidth = 1
        lblAddressLabel.layer.cornerRadius = 8
        
        addSubview(lblAddressName)
        lblAddressName.translatesAutoresizingMaskIntoConstraints = false
        lblAddressName.centerYAnchor.constraint(equalTo: lblAddressLabel.centerYAnchor).isActive = true
        lblAddressName.leadingAnchor.constraint(equalTo: lblAddressLabel.trailingAnchor, constant: 8).isActive = true
        lblAddressName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21).isActive = true

        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  GpsConfigCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import UIKit

class GpsConfigCollectionViewCell: UICollectionViewCell {
    static let ID = "GpsConfigCollectionViewCell"
    
    let lblareaNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lbllttd: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lbllngt: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblrange: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lbluseYn: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let cbUesYn = CheckBox()
    

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblareaNm)
        lblareaNm.translatesAutoresizingMaskIntoConstraints = false
        lblareaNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblareaNm.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblareaNm.widthAnchor.constraint(equalToConstant: 121).isActive = true
        
        addSubview(lbluseYn)
        lbluseYn.translatesAutoresizingMaskIntoConstraints = false
        lbluseYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbluseYn.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lbluseYn.widthAnchor.constraint(equalToConstant: 68).isActive = true
        
      
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: lblareaNm.trailingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: lbluseYn.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(lbllttd)
        stackView.addArrangedSubview(lbllngt)
        stackView.addArrangedSubview(lblrange)
        
        addSubview(cbUesYn)
        cbUesYn.translatesAutoresizingMaskIntoConstraints = false
        cbUesYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cbUesYn.centerXAnchor.constraint(equalTo: lbluseYn.centerXAnchor).isActive = true
        cbUesYn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbUesYn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let divider = UIView()
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


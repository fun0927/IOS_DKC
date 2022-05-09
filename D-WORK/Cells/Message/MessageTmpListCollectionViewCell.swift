//
//  MessageTmpListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/19.
//

import UIKit

class MessageTmpListCollectionViewCell: UICollectionViewCell {
    static let ID = "MessageTmpListCollectionViewCell"
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "날짜".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  .black
        return label
    }()
   
    let lblttlkr: UILabel = {
        let label = UILabel()
        label.text = "한국어 제목".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblttlkrValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  .black
        return label
    }()
   
    let lblbdkr: UILabel = {
        let label = UILabel()
        label.text = "한국어 내용".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblbdkrValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  .black
        return label
    }()
    
    let lblttljpn: UILabel = {
        let label = UILabel()
        label.text = "일본어 제목".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblttljpnValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  .black
        return label
    }()
    
    let lblbdjpn: UILabel = {
        let label = UILabel()
        label.text = "일본어 내용".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblbdjpnValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor =  .black
        return label
    }()
   
    let btnDelete: UIButton = {
        let button = UIButton()
        button.setTitle("삭제".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.topAnchor.constraint(equalTo: topAnchor,constant: 24).isActive = true
        lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblDate.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblDateValue)
        lblDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblDateValue.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 8).isActive = true
        lblDateValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblDateValue.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblttlkr)
        lblttlkr.translatesAutoresizingMaskIntoConstraints = false
        lblttlkr.topAnchor.constraint(equalTo: lblDateValue.bottomAnchor, constant: 16).isActive = true
        lblttlkr.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblttlkr.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblttlkrValue)
        lblttlkrValue.translatesAutoresizingMaskIntoConstraints = false
        lblttlkrValue.topAnchor.constraint(equalTo: lblttlkr.bottomAnchor, constant: 8).isActive = true
        lblttlkrValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblttlkrValue.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblbdkr)
        lblbdkr.translatesAutoresizingMaskIntoConstraints = false
        lblbdkr.topAnchor.constraint(equalTo: lblttlkrValue.bottomAnchor, constant: 16).isActive = true
        lblbdkr.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblbdkr.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblbdkrValue)
        lblbdkrValue.translatesAutoresizingMaskIntoConstraints = false
        lblbdkrValue.topAnchor.constraint(equalTo: lblbdkr.bottomAnchor, constant: 8).isActive = true
        lblbdkrValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblbdkrValue.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblttljpn)
        lblttljpn.translatesAutoresizingMaskIntoConstraints = false
        lblttljpn.topAnchor.constraint(equalTo: lblbdkrValue.bottomAnchor, constant: 16).isActive = true
        lblttljpn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblttljpn.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblttljpnValue)
        lblttljpnValue.translatesAutoresizingMaskIntoConstraints = false
        lblttljpnValue.topAnchor.constraint(equalTo: lblttljpn.bottomAnchor, constant: 8).isActive = true
        lblttljpnValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblttljpnValue.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblbdjpn)
        lblbdjpn.translatesAutoresizingMaskIntoConstraints = false
        lblbdjpn.topAnchor.constraint(equalTo: lblttljpnValue.bottomAnchor, constant: 16).isActive = true
        lblbdjpn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblbdjpn.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(lblbdjpnValue)
        lblbdjpnValue.translatesAutoresizingMaskIntoConstraints = false
        lblbdjpnValue.topAnchor.constraint(equalTo: lblbdjpn.bottomAnchor, constant: 8).isActive = true
        lblbdjpnValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblbdjpnValue.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
       addSubview(btnDelete)
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        btnDelete.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnDelete.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDelete.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16).isActive = true
        btnDelete.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


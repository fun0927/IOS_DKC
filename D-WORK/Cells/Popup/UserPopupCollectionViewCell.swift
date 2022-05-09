//
//  UserPopupCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit

class UserPopupCollectionViewCell: UICollectionViewCell {
    static let ID = "UserPopupCollectionViewCell"
    
    let lblName: UILabel = {
        let label = UILabel()
        label.text = "성명"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblPrsnCd: UILabel = {
        let label = UILabel()
        label.text = "사번"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lbldeptNm: UILabel = {
        let label = UILabel()
        label.text = "부서"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblpostNm: UILabel = {
        let label = UILabel()
        label.text = "직위"
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
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(lblName)
        stackView.addArrangedSubview(lblPrsnCd)
        stackView.addArrangedSubview(lbldeptNm)
        stackView.addArrangedSubview(lblpostNm)
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

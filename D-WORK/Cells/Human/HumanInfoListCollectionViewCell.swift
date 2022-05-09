//
//  HumanInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/29.
//

import UIKit

class HumanInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "HumanInfoListCollectionViewCell"
    let ivCheck = UIImageView()
    let cbCheck = CheckBox()
    let lblDivNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines =  2
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lbldtfr04: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblcdbr04: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblprsnNm: UILabel = {
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
        
        addSubview(cbCheck)
//        ivCheck.image = UIImage(named: "uncheck")
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cbCheck.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.isUserInteractionEnabled = false
        
        addSubview(lblDivNm)
        lblDivNm.translatesAutoresizingMaskIntoConstraints = false
        lblDivNm.leadingAnchor.constraint(equalTo: cbCheck.trailingAnchor, constant: 10).isActive = true
        lblDivNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDivNm.widthAnchor.constraint(equalToConstant: 84).isActive = true
        
        addSubview(lbldtfr04)
        lbldtfr04.translatesAutoresizingMaskIntoConstraints = false
        lbldtfr04.leadingAnchor.constraint(equalTo: lblDivNm.trailingAnchor).isActive = true
        lbldtfr04.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbldtfr04.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(lblprsnNm)
        lblprsnNm.translatesAutoresizingMaskIntoConstraints = false
//        lblprsnNm.leadingAnchor.constraint(equalTo: lblcdbr04.trailingAnchor).isActive = true
        lblprsnNm.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lblprsnNm.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lblprsnNm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblcdbr04)
        lblcdbr04.translatesAutoresizingMaskIntoConstraints = false
        lblcdbr04.leadingAnchor.constraint(equalTo: lbldtfr04.trailingAnchor).isActive = true
        lblcdbr04.trailingAnchor.constraint(equalTo: lblprsnNm.leadingAnchor).isActive = true
//        lblcdbr04.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lblcdbr04.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

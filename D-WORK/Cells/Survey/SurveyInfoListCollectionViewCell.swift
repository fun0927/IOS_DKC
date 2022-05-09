//
//  SurveyInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/07.
//

import UIKit

class SurveyInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "SurveyInfoListCollectionViewCell"
    
    let lblSubject: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let lblSys_Date: UILabel = {
        let label = UILabel()
        label.text = "등록일"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblSys_DateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblStart_Date: UILabel = {
        let label = UILabel()
        label.text = "기간"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblStart_DateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let lblDue_DateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
   
    let divider = UIView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        
        addSubview(lblSubject)
        lblSubject.translatesAutoresizingMaskIntoConstraints = false
        lblSubject.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblSubject.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lblSubject.numberOfLines = 2
        
        addSubview(lblSys_Date)
        lblSys_Date.translatesAutoresizingMaskIntoConstraints = false
        lblSys_Date.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        lblSys_Date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        
        addSubview(lblSys_DateValue)
        lblSys_DateValue.translatesAutoresizingMaskIntoConstraints = false
        lblSys_DateValue.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        lblSys_DateValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
        
        addSubview(lblStart_Date)
        lblStart_Date.translatesAutoresizingMaskIntoConstraints = false
        lblStart_Date.topAnchor.constraint(equalTo: topAnchor, constant: 86).isActive = true
        lblStart_Date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        
        addSubview(lblStart_DateValue)
        lblStart_DateValue.translatesAutoresizingMaskIntoConstraints = false
        lblStart_DateValue.topAnchor.constraint(equalTo: topAnchor, constant: 86).isActive = true
        lblStart_DateValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
        addSubview(lblDue_DateValue)
        lblDue_DateValue.translatesAutoresizingMaskIntoConstraints = false
        lblDue_DateValue.topAnchor.constraint(equalTo: lblStart_DateValue.bottomAnchor, constant: 0).isActive = true
        lblDue_DateValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


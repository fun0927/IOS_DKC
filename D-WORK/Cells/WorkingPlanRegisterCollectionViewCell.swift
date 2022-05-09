//
//  WorkingPlanRegisterCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit

class WorkingPlanRegisterCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkingPlanRegisterCollectionViewCell"
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "일자"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblTime: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblWorkingHour: UILabel = {
        let label = UILabel()
        label.text = "근무시간"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblCdat: UILabel = {
        let label = UILabel()
        label.text = "근태"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lblDelete: UILabel = {
        let label = UILabel()
        label.text = "삭제"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    
    let divider = UIView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lblWorkingHour)
        lblWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingHour.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblWorkingHour.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblWorkingHour.widthAnchor.constraint(equalToConstant: 104).isActive = true
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDate.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lblTime)
        lblTime.translatesAutoresizingMaskIntoConstraints = false
        lblTime.leadingAnchor.constraint(equalTo: lblDate.trailingAnchor).isActive = true
        lblTime.trailingAnchor.constraint(equalTo: lblWorkingHour.leadingAnchor).isActive = true
        lblTime.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblDelete)
        lblDelete.translatesAutoresizingMaskIntoConstraints = false
        lblDelete.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        lblDelete.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDelete.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lblDelete.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        addSubview(lblCdat)
        lblCdat.translatesAutoresizingMaskIntoConstraints = false
        lblCdat.leadingAnchor.constraint(equalTo: lblWorkingHour.trailingAnchor).isActive = true
        lblCdat.trailingAnchor.constraint(equalTo: lblDelete.leadingAnchor).isActive = true
        lblCdat.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


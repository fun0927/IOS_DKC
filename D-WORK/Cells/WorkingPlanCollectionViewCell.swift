//
//  WorkingPlanCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import UIKit

class WorkingPlanCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkingPlanCollectionViewCell"
    
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
    let lblStat: UILabel = {
        let label = UILabel()
        label.text = "상태"
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
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDate.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lblTime)
        lblTime.translatesAutoresizingMaskIntoConstraints = false
        lblTime.leadingAnchor.constraint(equalTo: lblDate.trailingAnchor).isActive = true
//        lblTime.trailingAnchor.constraint(equalTo: lblWorkingHour.leadingAnchor).isActive = true
        lblTime.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblTime.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(lblWorkingHour)
        lblWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingHour.leadingAnchor.constraint(equalTo: lblTime.trailingAnchor).isActive = true
//        lblWorkingHour.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblWorkingHour.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblWorkingHour.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        addSubview(lblStat)
        lblStat.translatesAutoresizingMaskIntoConstraints = false
//        lblStat.leadingAnchor.constraint(equalTo: lblTime.trailingAnchor).isActive = true
        lblStat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblStat.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblStat.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(lblCdat)
        lblCdat.translatesAutoresizingMaskIntoConstraints = false
        lblCdat.leadingAnchor.constraint(equalTo: lblWorkingHour.trailingAnchor).isActive = true
        lblCdat.trailingAnchor.constraint(equalTo: lblStat.leadingAnchor).isActive = true
        lblCdat.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
////        stackView.distribution = .fillEqually
////        stackView.spacing = 7
//        addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//        stackView.addArrangedSubview(lblDate)
//        stackView.addArrangedSubview(lblTime)
//        stackView.addArrangedSubview(lblWorkingHour)
////        lblWorkingHour.translatesAutoresizingMaskIntoConstraints = false
////        lblWorkingHour.widthAnchor.constraint(equalToConstant: 95).isActive = true
//        stackView.addArrangedSubview(lblCdat)
//        stackView.addArrangedSubview(lblStat)
        
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


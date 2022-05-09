//
//  WorkPlanResultCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/16.
//

import UIKit

class WorkPlanResultCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkPlanResultCollectionViewCell"
    
    let lblprsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblmaxWorkingHour: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblworkPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblworkTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lbloverWorkTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblworkingGrade: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    
  
    let ivCheck = UIImageView()
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
        
        stackView.addArrangedSubview(lblprsnNm)
        stackView.addArrangedSubview(lblmaxWorkingHour)
        stackView.addArrangedSubview(lblworkPlan)
        stackView.addArrangedSubview(lblworkTime)
        stackView.addArrangedSubview(lbloverWorkTime)
        stackView.addArrangedSubview(lblworkingGrade)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

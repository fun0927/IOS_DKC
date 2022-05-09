//
//  WorkPlanReportCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/14.
//

import UIKit

class WorkPlanReportCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkPlanReportCollectionViewCell"
    
    let lblprsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblwPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblbreakPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lbltripPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lbletcPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblsaveYn: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    
    let lblchkYn: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
//    let ivCheck = UIImageView()
    let cbCheck = CheckBox()
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
        stackView.addArrangedSubview(lblwPlan)
        stackView.addArrangedSubview(lblbreakPlan)
        stackView.addArrangedSubview(lbltripPlan)
        stackView.addArrangedSubview(lbletcPlan)
        stackView.addArrangedSubview(lblsaveYn)
        stackView.addArrangedSubview(lblchkYn)
        
        addSubview(cbCheck)
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cbCheck.centerXAnchor.constraint(equalTo: lblchkYn.centerXAnchor).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

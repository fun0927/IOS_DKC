//
//  WorkPlanResultDetailCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/17.
//

import UIKit

class WorkPlanResultDetailCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkPlanResultDetailCollectionViewCell"
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let lblWorkPlan: UILabel = {
        let label = UILabel()
        label.text = "계획근로".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let lblWorkPlanCome: UILabel = {
        let label = UILabel()
        label.text = "출퇴근시간".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkPlanComeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let lblWorkPlanLeaveValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWorkPlanWorkTime: UILabel = {
        let label = UILabel()
        label.text = "근로시간".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkPlanWorkTimeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
//        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkPlanCdat: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkPlanCdatValue1: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let lblWorkPlanCdatValue2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWork: UILabel = {
        let label = UILabel()
        label.text = "실근로".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
   
    
    let lblWorkCome: UILabel = {
        let label = UILabel()
        label.text = "출퇴근시간".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let lblWorkComeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let lblWorkLeaveValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    let lblWorkWorkTime: UILabel = {
        let label = UILabel()
        label.text = "근로시간".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkWorkTimeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
//        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblWorkCdat: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkCdatValue1: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let lblWorkCdatValue2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
  
    let ivCheck = UIImageView()
    let divider = UIView()
    let verticalDivider = UIView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        addSubview(verticalDivider)
        verticalDivider.translatesAutoresizingMaskIntoConstraints = false
        verticalDivider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalDivider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 78).isActive = true
        verticalDivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        verticalDivider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblDate.trailingAnchor.constraint(equalTo: verticalDivider.leadingAnchor).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDate.text = "01\n(일)"
        
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
      
        addSubview(lblWorkPlan)
        lblWorkPlan.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlan.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        lblWorkPlan.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 16).isActive = true
        
        addSubview(lblWorkPlanCome)
        lblWorkPlanCome.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanCome.leadingAnchor.constraint(equalTo: lblWorkPlan.leadingAnchor).isActive = true
        lblWorkPlanCome.topAnchor.constraint(equalTo: lblWorkPlan.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkPlanComeValue)
        lblWorkPlanComeValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanComeValue.leadingAnchor.constraint(equalTo: lblWorkPlan.leadingAnchor).isActive = true
        lblWorkPlanComeValue.topAnchor.constraint(equalTo: lblWorkPlanCome.bottomAnchor, constant: 2).isActive = true
        
        addSubview(lblWorkPlanLeaveValue)
        lblWorkPlanLeaveValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanLeaveValue.leadingAnchor.constraint(equalTo: lblWorkPlan.leadingAnchor).isActive = true
        lblWorkPlanLeaveValue.topAnchor.constraint(equalTo: lblWorkPlanComeValue.bottomAnchor, constant: 2).isActive = true
        
        
        addSubview(lblWorkPlanWorkTime)
        lblWorkPlanWorkTime.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanWorkTime.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 97).isActive = true
        lblWorkPlanWorkTime.topAnchor.constraint(equalTo: lblWorkPlan.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkPlanWorkTimeValue)
        lblWorkPlanWorkTimeValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanWorkTimeValue.leadingAnchor.constraint(equalTo: lblWorkPlanWorkTime.leadingAnchor).isActive = true
        lblWorkPlanWorkTimeValue.topAnchor.constraint(equalTo: lblWorkPlanWorkTime.bottomAnchor, constant: 2).isActive = true
        
        addSubview(lblWorkPlanWorkTime)
        lblWorkPlanWorkTime.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanWorkTime.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 97).isActive = true
        lblWorkPlanWorkTime.topAnchor.constraint(equalTo: lblWorkPlan.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkPlanCdat)
        lblWorkPlanCdat.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanCdat.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 163).isActive = true
        lblWorkPlanCdat.topAnchor.constraint(equalTo: lblWorkPlan.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkPlanCdatValue1)
        lblWorkPlanCdatValue1.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanCdatValue1.leadingAnchor.constraint(equalTo: lblWorkPlanCdat.leadingAnchor).isActive = true
        lblWorkPlanCdatValue1.topAnchor.constraint(equalTo: lblWorkPlanCdat.bottomAnchor, constant: 2).isActive = true
        
        
        addSubview(lblWorkPlanCdatValue2)
        lblWorkPlanCdatValue2.translatesAutoresizingMaskIntoConstraints = false
        lblWorkPlanCdatValue2.leadingAnchor.constraint(equalTo: lblWorkPlanCdat.leadingAnchor).isActive = true
        lblWorkPlanCdatValue2.topAnchor.constraint(equalTo: lblWorkPlanCdatValue1.bottomAnchor, constant: 2).isActive = true
        
    
        // 실근로
        addSubview(lblWork)
        lblWork.translatesAutoresizingMaskIntoConstraints = false
        lblWork.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16).isActive = true
        lblWork.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 16).isActive = true
        
        // 실근로 출퇴근
        addSubview(lblWorkCome)
        lblWorkCome.translatesAutoresizingMaskIntoConstraints = false
        lblWorkCome.leadingAnchor.constraint(equalTo: lblWork.leadingAnchor).isActive = true
        lblWorkCome.topAnchor.constraint(equalTo: lblWork.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkComeValue)
        lblWorkComeValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkComeValue.leadingAnchor.constraint(equalTo: lblWorkCome.leadingAnchor).isActive = true
        lblWorkComeValue.topAnchor.constraint(equalTo: lblWorkCome.bottomAnchor, constant: 2).isActive = true
        
        addSubview(lblWorkLeaveValue)
        lblWorkLeaveValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkLeaveValue.leadingAnchor.constraint(equalTo: lblWork.leadingAnchor).isActive = true
        lblWorkLeaveValue.topAnchor.constraint(equalTo: lblWorkComeValue.bottomAnchor, constant: 2).isActive = true
        
        // 실근로 근로시간
        addSubview(lblWorkWorkTime)
        lblWorkWorkTime.translatesAutoresizingMaskIntoConstraints = false
        lblWorkWorkTime.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 97).isActive = true
        lblWorkWorkTime.topAnchor.constraint(equalTo: lblWork.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkWorkTimeValue)
        lblWorkWorkTimeValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkWorkTimeValue.leadingAnchor.constraint(equalTo: lblWorkWorkTime.leadingAnchor).isActive = true
        lblWorkWorkTimeValue.topAnchor.constraint(equalTo: lblWorkWorkTime.bottomAnchor, constant: 2).isActive = true
        
        // 실근로 근태
        addSubview(lblWorkCdat)
        lblWorkCdat.translatesAutoresizingMaskIntoConstraints = false
        lblWorkCdat.leadingAnchor.constraint(equalTo: verticalDivider.trailingAnchor, constant: 163).isActive = true
        lblWorkCdat.topAnchor.constraint(equalTo: lblWork.bottomAnchor, constant: 8).isActive = true
        
        addSubview(lblWorkCdatValue1)
        lblWorkCdatValue1.translatesAutoresizingMaskIntoConstraints = false
        lblWorkCdatValue1.leadingAnchor.constraint(equalTo: lblWorkCdat.leadingAnchor).isActive = true
        lblWorkCdatValue1.topAnchor.constraint(equalTo: lblWorkCdat.bottomAnchor, constant: 2).isActive = true
        
        
        addSubview(lblWorkCdatValue2)
        lblWorkCdatValue2.translatesAutoresizingMaskIntoConstraints = false
        lblWorkCdatValue2.leadingAnchor.constraint(equalTo: lblWorkCdat.leadingAnchor).isActive = true
        lblWorkCdatValue2.topAnchor.constraint(equalTo: lblWorkCdatValue1.bottomAnchor, constant: 2).isActive = true
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

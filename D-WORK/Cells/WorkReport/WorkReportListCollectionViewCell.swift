//
//  WorkReportListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import UIKit

class WorkReportListCollectionViewCell: UICollectionViewCell {
    static let ID = "WorkReportListCollectionViewCell"
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "일자"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblcomeTime: UILabel = {
        let label = UILabel()
        label.text = "출근"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblleaveTime: UILabel = {
        let label = UILabel()
        label.text = "퇴근"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblafsta3Nm: UILabel = {
        let label = UILabel()
        label.text = "상태"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lblcdat21Nm: UILabel = {
        let label = UILabel()
        label.text = "근태"
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
        
        let eachWidth = frame.width / 5
        addSubview(lblleaveTime)
        lblleaveTime.translatesAutoresizingMaskIntoConstraints = false
        lblleaveTime.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblleaveTime.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblleaveTime.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        
        addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        lblDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblDate.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        
        addSubview(lblcomeTime)
        lblcomeTime.translatesAutoresizingMaskIntoConstraints = false
        lblcomeTime.leadingAnchor.constraint(equalTo: lblDate.trailingAnchor).isActive = true
        lblcomeTime.trailingAnchor.constraint(equalTo: lblleaveTime.leadingAnchor).isActive = true
        lblcomeTime.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(lblcdat21Nm)
        lblcdat21Nm.translatesAutoresizingMaskIntoConstraints = false
        lblcdat21Nm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        lblcdat21Nm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblcdat21Nm.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
        
        addSubview(lblafsta3Nm)
        lblafsta3Nm.translatesAutoresizingMaskIntoConstraints = false
        lblafsta3Nm.leadingAnchor.constraint(equalTo: lblleaveTime.trailingAnchor).isActive = true
        lblafsta3Nm.trailingAnchor.constraint(equalTo: lblcdat21Nm.leadingAnchor).isActive = true
        lblafsta3Nm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

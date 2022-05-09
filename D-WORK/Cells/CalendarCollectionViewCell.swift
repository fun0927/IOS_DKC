//
//  CalendarCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let ID = "CalendarCollectionViewCell"
 
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
  
    let divider = UIView()
    
    let lblDayValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lblcdat21: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.608, green: 0.318, blue: 0.878, alpha: 1)
        return label
    }()
    let lblwPlan: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
        return label
    }()
    let lbluphma3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 10)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.992, green: 0.451, blue: 0.4, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: topAnchor).isActive = true
        divider.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        
        self.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        dayLabel.textAlignment = .center
        
        
        // 날짜 화면
        addSubview(lblDayValue)
        lblDayValue.translatesAutoresizingMaskIntoConstraints = false
        lblDayValue.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        lblDayValue.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblDayValue.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblDayValue.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lblDayValue.textAlignment = .center
        
        addSubview(lblcdat21)
        lblcdat21.translatesAutoresizingMaskIntoConstraints = false
        lblcdat21.topAnchor.constraint(equalTo: lblDayValue.bottomAnchor, constant: 8).isActive = true
        lblcdat21.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblcdat21.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lblcdat21.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(lblwPlan)
        lblwPlan.translatesAutoresizingMaskIntoConstraints = false
        lblwPlan.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblwPlan.topAnchor.constraint(equalTo: lblcdat21.bottomAnchor, constant: 2).isActive = true
        lblwPlan.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lblwPlan.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(lbluphma3)
        lbluphma3.translatesAutoresizingMaskIntoConstraints = false
        lbluphma3.topAnchor.constraint(equalTo: lblwPlan.bottomAnchor, constant: 2).isActive = true
        lbluphma3.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbluphma3.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lbluphma3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        

      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


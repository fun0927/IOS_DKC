//
//  MonthWorkInfoListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/09.
//

import UIKit

class MonthWorkInfoListCollectionViewCell: UICollectionViewCell {
    static let ID = "MonthWorkInfoListCollectionViewCell"
    
    let lbldd: UILabel = {
        let label = UILabel()
        label.text = "일자"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblsthm21: UILabel = {
        let label = UILabel()
        label.text = "출근"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblenhm21: UILabel = {
        let label = UILabel()
        label.text = "퇴근"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblcdat1: UILabel = {
        let label = UILabel()
        label.text = "상태"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    let lblcdat2: UILabel = {
        let label = UILabel()
        label.text = "근태"
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        return label
    }()
    
    let lblcdat3: UILabel = {
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
        addSubview(lbldd)
        lbldd.translatesAutoresizingMaskIntoConstraints = false
//        lbldd.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lbldd.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lbldd.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbldd.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 46/343).isActive = true
        
        addSubview(lblsthm21)
        lblsthm21.translatesAutoresizingMaskIntoConstraints = false
        lblsthm21.leadingAnchor.constraint(equalTo: lbldd.trailingAnchor, constant: 0).isActive = true
        lblsthm21.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblsthm21.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 48/343).isActive = true
        
        addSubview(lblenhm21)
        lblenhm21.translatesAutoresizingMaskIntoConstraints = false
        lblenhm21.leadingAnchor.constraint(equalTo: lblsthm21.trailingAnchor, constant: 0).isActive = true
        lblenhm21.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblenhm21.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 48/343).isActive = true
        
        addSubview(lblcdat1)
        lblcdat1.translatesAutoresizingMaskIntoConstraints = false
        lblcdat1.leadingAnchor.constraint(equalTo: lblenhm21.trailingAnchor, constant: 0).isActive = true
        lblcdat1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblcdat1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 66/343).isActive = true
        lblcdat1.numberOfLines = 2
        
        addSubview(lblcdat2)
        lblcdat2.translatesAutoresizingMaskIntoConstraints = false
        lblcdat2.leadingAnchor.constraint(equalTo: lblcdat1.trailingAnchor, constant: 0).isActive = true
        lblcdat2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblcdat2.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 66/343).isActive = true
        lblcdat2.numberOfLines = 2
        
        addSubview(lblcdat3)
        lblcdat3.translatesAutoresizingMaskIntoConstraints = false
        lblcdat3.leadingAnchor.constraint(equalTo: lblcdat2.trailingAnchor, constant: 0).isActive = true
        lblcdat3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblcdat3.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 66/343).isActive = true
        lblcdat3.numberOfLines = 2
        
        
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

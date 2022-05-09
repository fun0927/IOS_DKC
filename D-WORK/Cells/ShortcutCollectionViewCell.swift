//
//  ShortcutCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/18.
//

import UIKit

class ShortcutCollectionViewCell: UICollectionViewCell {
    static let ID = "ShortcutCollectionViewCell"
    let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 19
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 191.0/255, green: 191.0/255, blue: 191.0/255, alpha: 1.0)
        return view
    }()
    
    let ivIcon = UIImageView()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backView.layer.cornerRadius = 8
        backView.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        
        ivIcon.image = UIImage(named: "mainTimer")
        self.addSubview(ivIcon)
        ivIcon.translatesAutoresizingMaskIntoConstraints = false
        ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        ivIcon.widthAnchor.constraint(equalToConstant: 21).isActive = true
        ivIcon.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        self.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        lblTitle.heightAnchor.constraint(equalToConstant: 18).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: ivIcon.trailingAnchor, constant: 3).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        lblTitle.textAlignment = .center
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

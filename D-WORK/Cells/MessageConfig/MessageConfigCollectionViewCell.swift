//
//  MessageConfigCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import UIKit

class MessageConfigCollectionViewCell: UICollectionViewCell {
    static let ID = "MessageConfigCollectionViewCell"
    
    let lblpshDiv: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblpshTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblsndDt: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblsndTm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblhlYn: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let cbHlYn = CheckBox()
    
    let lbluseYn: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let cbUesYn = CheckBox()
    
    var pshDivYAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(lbluseYn)
        lbluseYn.translatesAutoresizingMaskIntoConstraints = false
        lbluseYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbluseYn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        lbluseYn.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        addSubview(lblhlYn)
        lblhlYn.translatesAutoresizingMaskIntoConstraints = false
        lblhlYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblhlYn.trailingAnchor.constraint(equalTo: lbluseYn.leadingAnchor, constant: 0).isActive = true
        lblhlYn.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        addSubview(lblsndTm)
        lblsndTm.translatesAutoresizingMaskIntoConstraints = false
        lblsndTm.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblsndTm.trailingAnchor.constraint(equalTo: lblhlYn.leadingAnchor, constant: 0).isActive = true
        lblsndTm.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        addSubview(lblsndDt)
        lblsndDt.translatesAutoresizingMaskIntoConstraints = false
        lblsndDt.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblsndDt.trailingAnchor.constraint(equalTo: lblsndTm.leadingAnchor, constant: 0).isActive = true
        lblsndDt.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        addSubview(lblpshDiv)
        lblpshDiv.translatesAutoresizingMaskIntoConstraints = false
//        lblpshDiv.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        pshDivYAnchor = lblpshDiv.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -13)
        pshDivYAnchor?.isActive = true
        lblpshDiv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblpshDiv.trailingAnchor.constraint(equalTo: lblsndDt.leadingAnchor).isActive = true
        
        addSubview(lblpshTitle)
        lblpshTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblpshTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        lblpshTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 13).isActive = true
        lblpshTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblpshTitle.trailingAnchor.constraint(equalTo: lblsndDt.leadingAnchor).isActive = true
        
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
////        stackView.distribution = .fillEqually
//        addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: lblsndDt.trailingAnchor, constant: 0).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        stackView.spacing = 0
//
//        stackView.addArrangedSubview(lblsndTm)
//        stackView.addArrangedSubview(lblhlYn)
//        stackView.addArrangedSubview(lbluseYn)
        
        addSubview(cbHlYn)
        cbHlYn.translatesAutoresizingMaskIntoConstraints = false
        cbHlYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cbHlYn.centerXAnchor.constraint(equalTo: lblhlYn.centerXAnchor).isActive = true
        cbHlYn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbHlYn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(cbUesYn)
        cbUesYn.translatesAutoresizingMaskIntoConstraints = false
        cbUesYn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cbUesYn.centerXAnchor.constraint(equalTo: lbluseYn.centerXAnchor).isActive = true
        cbUesYn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbUesYn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let divider = UIView()
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


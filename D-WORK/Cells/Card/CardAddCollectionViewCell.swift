//
//  CardAddCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit

class CardAddCollectionViewCell: UICollectionViewCell {
    static let ID = "CardAddCollectionViewCell"
    
    let lblAmount: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    
    let lbl1: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    let view1:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    
    let lbl2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    
    let view2:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    
    let lbl3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    
    let view3:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        view.layer.cornerRadius = 7
        return view
    }()
    let lbl4: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 12)
        return label
    }()
    let view4:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        view.layer.cornerRadius = 7
        return view
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
        
        addSubview(lblAmount)
        lblAmount.translatesAutoresizingMaskIntoConstraints = false
        lblAmount.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lblAmount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        lblAmount.widthAnchor.constraint(equalToConstant: 77).isActive = true
//        lblAmount.numberOfLines = 2
        
        
        addSubview(lbl1)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        lbl1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 115).isActive = true
        lbl1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbl1.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        addSubview(view1)
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.widthAnchor.constraint(equalToConstant: 14).isActive = true
        view1.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view1.centerXAnchor.constraint(equalTo: lbl1.centerXAnchor).isActive = true
        
        addSubview(lbl2)
        lbl2.translatesAutoresizingMaskIntoConstraints = false
        lbl2.leadingAnchor.constraint(equalTo: lbl1.trailingAnchor, constant: 10).isActive = true
        lbl2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbl2.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        addSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.widthAnchor.constraint(equalToConstant: 14).isActive = true
        view2.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view2.centerXAnchor.constraint(equalTo: lbl2.centerXAnchor).isActive = true
        
        addSubview(lbl3)
        lbl3.translatesAutoresizingMaskIntoConstraints = false
        lbl3.leadingAnchor.constraint(equalTo: lbl2.trailingAnchor, constant: 10).isActive = true
        lbl3.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lbl3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(view3)
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.widthAnchor.constraint(equalToConstant: 14).isActive = true
        view3.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view3.centerXAnchor.constraint(equalTo: lbl3.centerXAnchor).isActive = true
        
        addSubview(lbl4)
        lbl4.translatesAutoresizingMaskIntoConstraints = false
        lbl4.leadingAnchor.constraint(equalTo: lbl3.trailingAnchor, constant: 5).isActive = true
        lbl4.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lbl4.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(view4)
        view4.translatesAutoresizingMaskIntoConstraints = false
        view4.widthAnchor.constraint(equalToConstant: 14).isActive = true
        view4.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view4.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view4.centerXAnchor.constraint(equalTo: lbl4.centerXAnchor).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


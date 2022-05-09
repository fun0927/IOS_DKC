//
//  SurveyExmCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/12.
//

import UIKit

class SurveyExmCollectionViewCell: UICollectionViewCell {
    static let ID = "SurveyExmCollectionViewCell"
    let lblExm_Title: UILabel = {
        let label = UILabel()
        label.text = ""
//        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    let ivExm:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    
    let ivCheck = UIImageView()
    let tvAnswer: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .white
//        textView.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        textView.text = "내용을 입력해주세요".localized
        return textView
    }()
    
    let tfAnswer: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    let tfRMAnswer: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
//        layer.borderWidth = 1
//        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
//        layer.cornerRadius = 8
        
        
        addSubview(ivExm)
        ivExm.translatesAutoresizingMaskIntoConstraints = false
        ivExm.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ivExm.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivExm.widthAnchor.constraint(equalToConstant: 24).isActive  = true
        ivExm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        
        addSubview(lblExm_Title)
        lblExm_Title.translatesAutoresizingMaskIntoConstraints = false
        lblExm_Title.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblExm_Title.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        lblExm_Title.centerYAnchor.constraint(equalTo: centerYAnchor, constant:0).isActive = true
        lblExm_Title.leadingAnchor.constraint(equalTo: ivExm.trailingAnchor, constant: 10).isActive = true
        lblExm_Title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

        addSubview(ivCheck)
        ivCheck.image = UIImage(named: "uncheck")
        ivCheck.translatesAutoresizingMaskIntoConstraints = false
        ivCheck.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ivCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivCheck.widthAnchor.constraint(equalToConstant: 24).isActive  = true
        ivCheck.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        ivCheck.isHidden = true
        
        addSubview(tvAnswer)
        tvAnswer.translatesAutoresizingMaskIntoConstraints = false
        tvAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        tvAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        tvAnswer.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        tvAnswer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0).isActive = true
        
        addSubview(tfAnswer)
        tfAnswer.translatesAutoresizingMaskIntoConstraints = false
        tfAnswer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        tfAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        tfAnswer.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        tvAnswer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0).isActive = true
        addSubview(tfRMAnswer)
        tfRMAnswer.translatesAutoresizingMaskIntoConstraints = false
        tfRMAnswer.leadingAnchor.constraint(equalTo: lblExm_Title.leadingAnchor).isActive = true
        tfRMAnswer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        tfRMAnswer.topAnchor.constraint(equalTo: lblExm_Title.bottomAnchor, constant: 2).isActive = true
        tfRMAnswer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0).isActive = true
       
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


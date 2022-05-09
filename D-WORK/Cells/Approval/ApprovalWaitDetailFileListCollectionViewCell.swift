//
//  ApprovalWaitDetailFileListCollectionViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import UIKit

class ApprovalWaitDetailFileListCollectionViewCell: UICollectionViewCell {
    static let ID = "ApprovalWaitDetailFileListCollectionViewCell"
    
    let lblfileName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let ivDownload:UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "download")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        addSubview(lblfileName)
        lblfileName.translatesAutoresizingMaskIntoConstraints = false
        lblfileName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblfileName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        lblfileName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        addSubview(ivDownload)
        ivDownload.translatesAutoresizingMaskIntoConstraints = false
        ivDownload.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ivDownload.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivDownload.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivDownload.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
      
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




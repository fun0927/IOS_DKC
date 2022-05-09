//
//  MenuTableViewCell.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/21.
//

import UIKit

protocol HeaderViewDelegate {
    func toggleSection(section: Int)
}


class MenuTableViewCell: UITableViewCell {
    static let ID = "MenuTableViewCell"
    
    var isHeader = true
    var section: Int?
    var row:Int?
    var delegate: HeaderViewDelegate?
    
    let lblUpper: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
  
    let lblContent: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lastBottomSectionView = UIView()
    let leftView = UIView()
    
    let rightView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
//        let touchView = UIView()
//        addSubview(touchView)
//        touchView.translatesAutoresizingMaskIntoConstraints = false
//        touchView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        touchView.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
//        addGestureRecognizer(UITapGestureRecognizer(target: rightImageView, action: #selector(didTapHeader)))
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.lblUpper)
        self.addSubview(self.rightImageView)
        addSubview(lblContent)
        
        addSubview(lastBottomSectionView)
        lastBottomSectionView.isHidden = true
        lastBottomSectionView.translatesAutoresizingMaskIntoConstraints = false
        lastBottomSectionView.topAnchor.constraint(equalTo: topAnchor, constant: -1).isActive = true
        lastBottomSectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lastBottomSectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        lastBottomSectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lastBottomSectionView.clipsToBounds = true
        lastBottomSectionView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        lastBottomSectionView.layer.borderWidth = 1
        lastBottomSectionView.layer.cornerRadius = 8
        lastBottomSectionView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        leftView.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        leftView.isHidden = true
        
        addSubview(rightView)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        rightView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        rightView.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        rightView.isHidden = true
        
        lblUpper.translatesAutoresizingMaskIntoConstraints = false
        lblUpper.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4).isActive = true
        lblUpper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21).isActive = true
        
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.centerYAnchor.constraint(equalTo: lblUpper.centerYAnchor).isActive = true
        rightImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        rightImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21).isActive = true
        
        lblContent.translatesAutoresizingMaskIntoConstraints = false
        lblContent.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lblContent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21).isActive = true
        lblContent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        lblContent.isHidden = true
      
//        print("section : \(section)")
//        print("row : \(row)")
    }
    
    
    
    @objc func didTapHeader() {
        if let section = self.section {
            delegate?.toggleSection(section: section)
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        self.questionLabel.text = nil
////        self.rightImageView.image = nil
//    }
}

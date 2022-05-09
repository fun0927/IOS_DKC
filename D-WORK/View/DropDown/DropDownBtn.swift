//
//  DropDownBtn.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation
import UIKit


protocol dropDownProtocol {
    func dropDownPressed(string : String)
}

class DropDownBtn: UIView, dropDownProtocol {
    var name = ""
    var stTitle = ""
    var dropView = DropDownListView()
    
    var height = NSLayoutConstraint()
    
    var delegate : DropDownViewProtocol!
    
    let btnDown: UIButton = {
        let button = UIButton()
        //        button.setTitle("빽",for: .normal)
        //        button.titleLabel?.font = UIFont(name: "SpoqaHanSans", size: 16)
        //        button.setTitleColor(UIColor(red: 143/255.0, green: 202/255.0, blue: 217/255.0, alpha: 1), for: .normal)
        button.setImage(UIImage(named: "arrow-down"), for: .normal)
        return button
    }()
    
    
    let lblTitle: UILabel = {
        let label = UILabel()
        //        label.text = stTitle
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    func dropDownPressed(string: String) {
        //        print("dropDownPressed : \(string)")
        stTitle = string
        //        self.setTitle(string, for: .normal)
        lblTitle.text = string
        
        delegate.dropDownPressed(name:name, string: string)
        self.dismissDropDown()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        dropView = DropDownListView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        self.layer.cornerRadius = 8
        
        addSubview(btnDown)
        btnDown.translatesAutoresizingMaskIntoConstraints = false
        btnDown.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        btnDown.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17).isActive = true
        btnDown.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        btnDown.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        
        addSubview(lblTitle)
        lblTitle.text = stTitle
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //        lblTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: btnDown.leadingAnchor, constant: 10).isActive = true
        
        
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override func didMoveToSuperview() {
        //        print("didMoveToSuperview")
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        openListViewHandler()
    }
    
    @objc func btnBackClicked() {
        //        print("btnBackClicked inside view")
        //        self.delegate?.btnBackClicked()
        openListViewHandler()
    }
    
    func openListViewHandler(){
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 250 {
                self.height.constant = 250
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
                self.superview?.bringSubviewToFront(self.dropView)
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol DropDownViewProtocol : NSObjectProtocol{
    func dropDownPressed(name:String, string: String)
}

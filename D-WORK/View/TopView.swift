//
//  TopView.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import UIKit

class TopView: UIView {
    
    weak var menuDelegate : TopViewMenuProtocol? = nil
    weak var backDelegate : TopViewBackProtocol? = nil
    weak var titleDelegate : TopViewTitleProtocol? = nil
    
    var isShowBtnMenu = false
    var isShowBtnPush = false
    var isShowBtnBack = false
    var isShowBtnLocation = false
    var isShowNoti = false {
        didSet {
            if isShowNoti {
                getNotice()
            }
        }
    }
    var isShowPush = true
    let ivTitle = UIImageView()
    
    let btnMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "hamburger"), for: .normal)
        return button
    }()
    
    let btnBack: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
        return button
    }()
    
    let lblNotiLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor = UIColor.black
        return label
    }()
    let lblNoti: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let btnPush: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "push"), for: .normal)
        return button
    }()
    let viewCircle: UIView = {
        let view = UIView()
        return view
    }()
    let lblPushLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 8)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        if isShowPush {
            getPushCount()
        }
        if isShowNoti {
            getNotice()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var showList :[commonNoticeListResponseData] = []
    var currentIndex = 0
    var pushCount = 0
    
    override func layoutSubviews() {
        print("topview layoutSubviews")
        self.backgroundColor = .white
        self.addSubview(btnMenu)
        self.addSubview(btnBack)
        addSubview(lblNotiLabel)
        addSubview(lblNoti)
        
        self.addSubview(ivTitle)
        ivTitle.image = UIImage(named: "title")
        ivTitle.translatesAutoresizingMaskIntoConstraints = false
        ivTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        //        ivTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 27).isActive = true
        ivTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ivTitle.widthAnchor.constraint(equalToConstant: 94).isActive = true
        ivTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ivTitle.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivTitleClicked))
        ivTitle.addGestureRecognizer(tap)
        
        if(isShowBtnMenu){
            btnMenu.translatesAutoresizingMaskIntoConstraints = false
            btnMenu.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            btnMenu.centerYAnchor.constraint(equalTo: ivTitle.centerYAnchor).isActive = true
            btnMenu.widthAnchor.constraint(equalToConstant: 32).isActive = true
            btnMenu.heightAnchor.constraint(equalToConstant: 32).isActive = true
            btnMenu.addTarget(self, action: #selector(btnMenuClicked), for: .touchUpInside)
        } else if(isShowBtnBack){
            btnBack.translatesAutoresizingMaskIntoConstraints = false
            btnBack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            btnBack.centerYAnchor.constraint(equalTo: ivTitle.centerYAnchor).isActive = true
            btnBack.widthAnchor.constraint(equalToConstant: 32).isActive = true
            btnBack.heightAnchor.constraint(equalToConstant: 32).isActive = true
            btnBack.addTarget(self, action: #selector(btnBackClicked), for: .touchUpInside)
        }
        
        if isShowNoti {
            lblNotiLabel.translatesAutoresizingMaskIntoConstraints = false
            lblNotiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            lblNotiLabel.topAnchor.constraint(equalTo: topAnchor, constant: 41).isActive = true
            lblNotiLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
            lblNoti.translatesAutoresizingMaskIntoConstraints = false
            lblNoti.centerYAnchor.constraint(equalTo: lblNotiLabel.centerYAnchor).isActive = true
            lblNoti.leadingAnchor.constraint(equalTo: lblNotiLabel.trailingAnchor, constant: 8).isActive = true
            lblNoti.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        }
        
        if isShowPush {
            self.addSubview(btnPush)
            btnPush.translatesAutoresizingMaskIntoConstraints = false
            btnPush.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            btnPush.centerYAnchor.constraint(equalTo: ivTitle.centerYAnchor).isActive = true
            btnPush.widthAnchor.constraint(equalToConstant: 26).isActive = true
            btnPush.heightAnchor.constraint(equalToConstant: 20).isActive = true
            btnPush.addTarget(self, action: #selector(btnPushClicked), for: .touchUpInside)
            
            self.addSubview(viewCircle)
            viewCircle.translatesAutoresizingMaskIntoConstraints = false
            viewCircle.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
            viewCircle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
            viewCircle.centerYAnchor.constraint(equalTo: ivTitle.centerYAnchor, constant: 10).isActive = true
            viewCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
            viewCircle.heightAnchor.constraint(equalToConstant: 16).isActive = true
            viewCircle.layer.cornerRadius = 8
            
            self.addSubview(lblPushLabel)
            lblPushLabel.translatesAutoresizingMaskIntoConstraints = false
            lblPushLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
            lblPushLabel.centerYAnchor.constraint(equalTo: ivTitle.centerYAnchor, constant: 9).isActive = true
            lblPushLabel.widthAnchor.constraint(equalToConstant: 16).isActive = true
            lblPushLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            self.lblPushLabel.text = String(self.pushCount)
        }
    }
    
    func getNotice(){
        ApiService.request(router: CommonApi.noticeList, success: { (response: ApiResponse<commonNoticeListResponse>) in
            if let result = response.value {
                if let list = result.data {
                    self.showList = list
                    self.currentIndex = 0
                    self.showNotice()
                }
            }
        }) { (error) in
            
        }
    }
    
    func showNotice(){
        if  currentIndex < showList.count {
            if let dispSec = showList[currentIndex].dispSec {
                if showList[currentIndex].dvs == "1" {
                    self.lblNoti.text = "<사내> ".localized + (showList[currentIndex].title ?? "")
                }else {
                    self.lblNoti.text = "<안전> ".localized + (showList[currentIndex].title ?? "")
                }
                self.lblNoti.isUserInteractionEnabled = true
                let lblNotiTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(noticeOpen))
                lblNoti.addGestureRecognizer(lblNotiTap)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(dispSec)!), execute: {
                    self.currentIndex += 1
                    if self.currentIndex > self.showList.count-1 {
                        self.currentIndex = 0
                    }
                    self.showNotice()
                })
            }
        }
    }
    
    @objc func noticeOpen(){
        let vc = NoticeListViewController()
        vc.dvs = String(showList[currentIndex].dvs ?? "1")
        vc.directDataNo = showList[currentIndex].dataNo
        NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
    }
    
    func getPushCount() {
        ApiService.request(router: CommonApi.pushCount, success: { (response: ApiResponse<commonPushCountResponseData>) in
            if let result = response.value {
                if let data = result.data {
                    self.pushCount = data.cnt ?? 0
                    self.lblPushLabel.text = String(self.pushCount)
                }
            }
        }) { (error) in
            
        }
    }
    
    @objc func btnMenuClicked() {
        print("btnMenuClicked inside view")
        self.menuDelegate?.btnMenuClicked()
    }
    @objc func btnBackClicked() {
        print("btnBackClicked inside view")
        self.backDelegate?.btnBackClicked()
    }
    @objc func ivTitleClicked(){
        print("ivTitleClicked inside view")
        self.titleDelegate?.ivTitleClicked()
    }
    @objc func btnPushClicked() {
        print("btnPushClicked inside view")
        let vc = RecvHistViewController()
        NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: vc)
    }
}

protocol TopViewMenuProtocol : NSObjectProtocol{
    func btnMenuClicked()
}

protocol TopViewBackProtocol : NSObjectProtocol{
    func btnBackClicked()
}

protocol TopViewTitleProtocol : NSObjectProtocol{
    func ivTitleClicked()
}

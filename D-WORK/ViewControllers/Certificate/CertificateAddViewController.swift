//
//  CertificateAddViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit
import JGProgressHUD
class CertificateAddViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, DropDownViewProtocol {
    
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let hud = JGProgressHUD()
    let util = Util()
    
    var erpStatus = ""
    var certifiCd = ""
    var certificateInfo:CertificateInfoListData?
    
    let cvApproval = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var cvApproveHeightAnchor:NSLayoutConstraint?
    var cvApprovalHeightAnchor:NSLayoutConstraint?
    
    let lblApproveTitle: UILabel = {
        let label = UILabel()
        label.text = "승인자 정보".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    let btnApprovalList: UIButton = {
        let button = UIButton()
        button.setTitle("사용자 결재선".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnDraft: UIButton = {
        let button = UIButton()
        button.setTitle("상신".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    var approveList:[UserListDetailResponse] = [] // 실제 화면에 보여지는 리스트
    let cvApprove = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let btnEdit: UIButton = {
        let button = UIButton()
        button.setTitle("수정결재".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnDelete: UIButton = {
        let button = UIButton()
        button.setTitle("삭제".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let lblRequestTitle: UILabel = {
        let label = UILabel()
        label.text = "신청 정보".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    let lblRequester: UILabel = {
        let label = UILabel()
        label.text = "작성자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblRequesterValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblDivName: UILabel = {
        let label = UILabel()
        label.text = "사업부문".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblDivNameValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblCertificateType: UILabel = {
        let label = UILabel()
        label.text = "신청구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let idNumList = ["포함".localized, "미포함".localized]
    let lblIdNumber: UILabel = {
        let label = UILabel()
        label.text = "주민번호구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var idDropDown = DropDownBtn()
    
    let langList = ["한글".localized, "영어".localized]
    let lblLang: UILabel = {
        let label = UILabel()
        label.text = "언어구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var langDropDown = DropDownBtn()
    
    let scrollView = UIScrollView()
        
    var certificateDropDown = DropDownBtn()
    var cdatList:[String] = []
    var getCdatList:[CodeListDetailResponse] = []
    
    let lblremark: UILabel = {
        let label = UILabel()
        label.text = "용도".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfremmark: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "내용을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblIssueQty: UILabel = {
        let label = UILabel()
        label.text = "발행수량".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfIssueQty: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        //        textField.placeholder = "내용을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("저장".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnClose: UIButton = {
        let button = UIButton()
        button.setTitle("닫기".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var selectedCertifiType = ""
    var selectedRepreType = ""
    var selectedLangType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 72))
        topView.backDelegate = self
        topView.titleDelegate = self
        topView.isShowBtnBack = true
        topView.titleDelegate = self
        topView.isShowNoti = true
        view.addSubview(topView)
        //        view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let cvApprovalLayout = UICollectionViewFlowLayout()
        cvApprovalLayout.minimumLineSpacing = 0
        cvApprovalLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvApproval.collectionViewLayout = cvApprovalLayout
        
//        cvApproval.delegate = self
//        cvApproval.dataSource = self
        scrollView.addSubview(cvApproval)
        cvApproval.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cvApproval.translatesAutoresizingMaskIntoConstraints = false
        cvApproval.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        cvApproval.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        cvApproval.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(270))
        cvApprovalHeightAnchor?.isActive = true
        cvApproval.register(WaterRegisterInOutCollectionViewCell.self, forCellWithReuseIdentifier: WaterRegisterInOutCollectionViewCell.ID)
        cvApproval.isScrollEnabled = false
        
        cvApproval.addSubview(lblApproveTitle)
        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
        lblApproveTitle.topAnchor.constraint(equalTo: cvApproval.topAnchor, constant: 24).isActive = true
        lblApproveTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        cvApprove.collectionViewLayout = cvLayout
        
        cvApprove.delegate = self
        cvApprove.dataSource = self
        cvApprove.backgroundColor = .white
        cvApproval.addSubview(cvApprove)
        cvApprove.translatesAutoresizingMaskIntoConstraints = false
        cvApprove.topAnchor.constraint(equalTo: lblApproveTitle.bottomAnchor, constant: 16).isActive = true
        cvApprove.leadingAnchor.constraint(equalTo: cvApproval.leadingAnchor, constant: 16).isActive = true
        cvApprove.widthAnchor.constraint(equalToConstant: 159).isActive = true
        cvApproveHeightAnchor = cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(120))
        cvApproveHeightAnchor?.isActive = true
        cvApprove.layer.borderWidth = 1
        cvApprove.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        cvApprove.layer.cornerRadius = 8
        
        cvApprove.register(ApprovalUserCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalUserCollectionViewCell.ID)
        cvApprove.isScrollEnabled = false
        
        cvApproval.addSubview(btnApprovalList)
        btnApprovalList.translatesAutoresizingMaskIntoConstraints = false
        btnApprovalList.topAnchor.constraint(equalTo: cvApprove.topAnchor).isActive = true
        btnApprovalList.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnApprovalList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnApprovalList.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnApprovalList.addTarget(self, action: #selector(btnApprovalListClicked), for: .touchUpInside)
        
        cvApproval.addSubview(btnDraft)
        btnDraft.translatesAutoresizingMaskIntoConstraints = false
        btnDraft.topAnchor.constraint(equalTo: btnApprovalList.bottomAnchor, constant: 16).isActive = true
        btnDraft.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnDraft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnDraft.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDraft.addTarget(self, action: #selector(btnDraftClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
        btnDraft.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        btnDraft.addTarget(self, action: #selector(btnDraftClicked), for: .touchUpInside)
        
//        scrollView.addSubview(lblApproveTitle)
//        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblApproveTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
//        lblApproveTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
//
//        let cvLayout = UICollectionViewFlowLayout()
//        cvLayout.minimumLineSpacing = 16
//        cvLayout.minimumInteritemSpacing = 0
//        cvLayout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
//        cvApprove.collectionViewLayout = cvLayout
//
//        cvApprove.delegate = self
//        cvApprove.dataSource = self
//        cvApprove.backgroundColor = .white
//        scrollView.addSubview(cvApprove)
//        cvApprove.translatesAutoresizingMaskIntoConstraints = false
//        cvApprove.topAnchor.constraint(equalTo: lblApproveTitle.bottomAnchor, constant: 16).isActive = true
//        cvApprove.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
//        cvApprove.widthAnchor.constraint(equalToConstant: 159).isActive = true
//        cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(191)).isActive = true
//        cvApprove.layer.borderWidth = 1
//        cvApprove.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
//        cvApprove.layer.cornerRadius = 8
//
//        cvApprove.register(ApprovalUserCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalUserCollectionViewCell.ID)
//        cvApprove.isScrollEnabled = false
//
//        scrollView.addSubview(btnApprovalList)
//        btnApprovalList.translatesAutoresizingMaskIntoConstraints = false
//        btnApprovalList.topAnchor.constraint(equalTo: cvApprove.topAnchor).isActive = true
//        btnApprovalList.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
//        btnApprovalList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        btnApprovalList.heightAnchor.constraint(equalToConstant: 51).isActive = true
//        btnApprovalList.addTarget(self, action: #selector(btnApprovalListClicked), for: .touchUpInside)
//
//        scrollView.addSubview(btnDraft)
//        btnDraft.translatesAutoresizingMaskIntoConstraints = false
//        btnDraft.topAnchor.constraint(equalTo: btnApprovalList.bottomAnchor, constant: 16).isActive = true
//        btnDraft.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
//        btnDraft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        btnDraft.heightAnchor.constraint(equalToConstant: 51).isActive = true
//        btnDraft.addTarget(self, action: #selector(btnDraftClicked), for: .touchUpInside)
//        // Do any additional setup after loading the view.
//        btnDraft.isEnabled = false
//        btnDraft.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
//        //        print("erpStatus : \(erpStatus)")
////        if erpStatus == "" || erpStatus == "반려" {
////            btnSave.isEnabled = true
////            btnDraft.isEnabled = true
////
////            btnApprovalList.isEnabled = true
////            btnDraft.isEnabled = true
////            btnDraft.setEnable()
////
//////            btnDraft.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
////            //            print("btnDraft is enabled")
////        }else {
////            btnSave.isEnabled = false
////            btnDraft.isEnabled = false
////
////            btnApprovalList.isEnabled = false
////            btnDraft.isEnabled = false
////            btnDraft.setEnable()
////        }
//        //
//        //        scrollView.addSubview(btnEdit)
//        //        btnEdit.translatesAutoresizingMaskIntoConstraints = false
//        //        btnEdit.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16).isActive = true
//        //        btnEdit.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
//        //        btnEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        //        btnEdit.heightAnchor.constraint(equalToConstant: 51).isActive = true
//        //        btnEdit.isHidden = true
//        //
//        //        if erpStatus == "" || erpStatus == "반려" {
//        //            btnEdit.isHidden = false
//        //        }
//        btnDraft.addTarget(self, action: #selector(btnDraftClicked), for: .touchUpInside)
        
        cvApproval.addSubview(btnDelete)
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        var btnDeleteTopAnchor = btnDelete.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16)
        btnDeleteTopAnchor.isActive = true
        btnDelete.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnDelete.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDelete.isEnabled = false
        btnDelete.setDisable()
        btnDelete.addTarget(self, action: #selector(btnDeleteCliceked), for: .touchUpInside)
        
        scrollView.addSubview(lblRequestTitle)
        lblRequestTitle.translatesAutoresizingMaskIntoConstraints = false
        lblRequestTitle.topAnchor.constraint(equalTo: cvApproval.bottomAnchor, constant: 32).isActive = true
        lblRequestTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblRequester)
        lblRequester.translatesAutoresizingMaskIntoConstraints = false
        lblRequester.topAnchor.constraint(equalTo: lblRequestTitle.bottomAnchor, constant: 24).isActive = true
        lblRequester.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblRequester.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblRequesterValue)
        lblRequesterValue.translatesAutoresizingMaskIntoConstraints = false
        lblRequesterValue.centerYAnchor.constraint(equalTo: lblRequester.centerYAnchor).isActive = true
        lblRequesterValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 134).isActive = true
        lblRequesterValue.text = Environment.USER_NAME
        
        scrollView.addSubview(lblDivName)
        lblDivName.translatesAutoresizingMaskIntoConstraints = false
        lblDivName.topAnchor.constraint(equalTo: lblRequester.bottomAnchor, constant: 43).isActive = true
        lblDivName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblDivName.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblDivNameValue)
        lblDivNameValue.translatesAutoresizingMaskIntoConstraints = false
        lblDivNameValue.centerYAnchor.constraint(equalTo: lblDivName.centerYAnchor).isActive = true
        lblDivNameValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 134).isActive = true
        lblDivNameValue.text = Environment.USER_DIV_NAME
        
        scrollView.addSubview(lblCertificateType)
        lblCertificateType.translatesAutoresizingMaskIntoConstraints = false
        lblCertificateType.topAnchor.constraint(equalTo: lblDivName.bottomAnchor, constant: 43).isActive = true
        lblCertificateType.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblCertificateType.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblIdNumber)
        lblIdNumber.translatesAutoresizingMaskIntoConstraints = false
        lblIdNumber.topAnchor.constraint(equalTo: lblCertificateType.bottomAnchor, constant: 43).isActive = true
        lblIdNumber.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblIdNumber.heightAnchor.constraint(equalToConstant: 16).isActive = true
        updateIdDropDown()
        
        scrollView.addSubview(lblLang)
        lblLang.translatesAutoresizingMaskIntoConstraints = false
        lblLang.topAnchor.constraint(equalTo: lblIdNumber.bottomAnchor, constant: 43).isActive = true
        lblLang.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblLang.heightAnchor.constraint(equalToConstant: 16).isActive = true
        updateLangDropDown()
        
        // Do any additional setup after loading the view.
        getCdatCode()
        
        scrollView.addSubview(lblremark)
        lblremark.translatesAutoresizingMaskIntoConstraints = false
        lblremark.topAnchor.constraint(equalTo: lblLang.bottomAnchor, constant: 43).isActive = true
        lblremark.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblremark.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        scrollView.addSubview(tfremmark)
        tfremmark.translatesAutoresizingMaskIntoConstraints = false
        tfremmark.centerYAnchor.constraint(equalTo: lblremark.centerYAnchor).isActive = true
        tfremmark.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfremmark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfremmark.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        scrollView.addSubview(lblIssueQty)
        lblIssueQty.translatesAutoresizingMaskIntoConstraints = false
        lblIssueQty.topAnchor.constraint(equalTo: lblremark.bottomAnchor, constant: 43).isActive = true
        lblIssueQty.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblIssueQty.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        scrollView.addSubview(tfIssueQty)
        tfIssueQty.translatesAutoresizingMaskIntoConstraints = false
        tfIssueQty.centerYAnchor.constraint(equalTo: lblIssueQty.centerYAnchor).isActive = true
        tfIssueQty.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfIssueQty.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfIssueQty.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfIssueQty.text = "1"
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: lblIssueQty.bottomAnchor, constant:33).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -102).isActive = true
        
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnClose)
        btnSave.addTarget(self, action: #selector(btnSaveCliceked), for: .touchUpInside)
        btnClose.addTarget(self, action: #selector(btnCloseClicked), for: .touchUpInside)
        
        if let certificateInfo = certificateInfo {
            tfremmark.text = certificateInfo.remark
            tfIssueQty.text = certificateInfo.issueQty
        }
        
        hideKeyboardWhenTappedAround()
        setView()
    }
    
    func setView() {
        if(!certifiCd.isEmpty) {
            if let msgCd = certificateInfo?.msgCd {
                getApprovalLine(msgCd: msgCd)
            }
            
            if erpStatus == "" || erpStatus == "반려".localized {
                btnSave.isEnabled = true

                btnApprovalList.isEnabled = true
                btnDraft.isEnabled = true
                btnDraft.setEnable()

            }else {
                btnSave.isEnabled = false
                btnSave.setDisable()

                btnApprovalList.isEnabled = false
                btnApprovalList.setDisable()
                btnApprovalList.isHidden = true
                
                btnDraft.isEnabled = false
                btnDraft.setDisable()
                btnDraft.isHidden = true
                
                btnDelete.isHidden = true
                
                certificateDropDown.isUserInteractionEnabled = false
                idDropDown.isUserInteractionEnabled = false
                langDropDown.isUserInteractionEnabled = false
                tfremmark.isEnabled = false
                tfIssueQty.isEnabled = false
            }
        }else {
            cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
            
//            certificateDropDown.isUserInteractionEnabled = false
//            idDropDown.isUserInteractionEnabled = false
//            langDropDown.isUserInteractionEnabled = false
//            tfremmark.isEnabled = false
//            tfIssueQty.isEnabled = false
        }
    }
    
    func getApprovalLine(msgCd: String) {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.approvalLineList(param: ApprovalLineListRequest(msgCd: msgCd)), success: { (response: ApiResponse<ApprovalLineListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    for item in list {
                        self.approveList.append(UserListDetailResponse(prsnCd: item.prsnCd ?? "", prsnNm: item.prsnNm ?? "", deptCd: "", deptNm: "", postCd: "", postNm: "", divCd: "", divNm: "", gwUserId: item.gwUserId, isSelected: false))
                    }
                    self.cvApprove.reloadData()
                    self.setApprovalHeight()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func setApprovalHeight() {
        let innerH = 16 + ([(approveList.count * 40), 40].max() ?? 40)
        
        var outerH = 130
        if !btnApprovalList.isHidden {
            outerH += Int(btnApprovalList.intrinsicContentSize.height)
        }
        if !btnDraft.isHidden {
            outerH += Int(btnDraft.intrinsicContentSize.height)
            outerH += 16
        }
        if !btnDelete.isHidden {
            outerH += Int(btnDelete.intrinsicContentSize.height)
            outerH += 16
        }
        
        let height = CGFloat([outerH, innerH].max() ?? 0)
        
        cvApproveHeightAnchor?.isActive = false
        cvApproveHeightAnchor = cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(innerH))
        cvApproveHeightAnchor?.isActive = true
        
        cvApprovalHeightAnchor?.isActive = false
        cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(height))
        cvApprovalHeightAnchor?.isActive = true
    }
//    func setApprovalHeight() {
//        let innerH = 50 + (approveList.count * 30)
//        cvApproveHeightAnchor?.isActive = false
//        cvApproveHeightAnchor = cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(innerH))
//        cvApproveHeightAnchor?.isActive = true
//
//        var outerH = 120 + (approveList.count * 30)
//        if(!btnApprovalList.isHidden && !btnDraft.isHidden && !btnDelete.isHidden) {
//            outerH = max(outerH, 270)
//        }
//        cvApprovalHeightAnchor?.isActive = false
//        cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(outerH))
//        cvApprovalHeightAnchor?.isActive = true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        cvApprove.reloadData()
        setApprovalHeight()
    }
    
    func getCdatCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 구분 목록
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HH033")), success: { (response: ApiResponse<CodeListResponse>) in
            //            print("response : \(response)")
            self.cdatList.removeAll()
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getCdatList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getCdatList.indices {
                            self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                        }
                    }
                    for item in self.getCdatList {
                        self.cdatList.append(item.subNm ?? "")
                    }
                    self.updateDropDown()
                }
                
            }
            
        }) { (error) in
            self.hud.dismiss()
            
        }
    }
    func updateDropDown(){
        let isUIE = certificateDropDown.isUserInteractionEnabled
        certificateDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        certificateDropDown.name = "certificateDropDown"
        certificateDropDown.stTitle = "내용을 선택하세요".localized
        if let certifiType = certificateInfo?.certifiType {
            for item in getCdatList {
                if item.subCd == certifiType {
                    certificateDropDown.stTitle = item.subNm ?? ""
                }
            }
            selectedCertifiType = certifiType
        }
        
        certificateDropDown.delegate = self
        certificateDropDown.dropView.dropDownOptions = self.cdatList
        scrollView.addSubview(certificateDropDown)
        certificateDropDown.translatesAutoresizingMaskIntoConstraints = false
        certificateDropDown.centerYAnchor.constraint(equalTo: lblCertificateType.centerYAnchor).isActive = true
        certificateDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        certificateDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        certificateDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        certificateDropDown.isUserInteractionEnabled = isUIE
    }
    
    func updateIdDropDown(){
        idDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        idDropDown.name = "idDropDown"
        idDropDown.stTitle = "내용을 선택하세요".localized
        if let repreType = certificateInfo?.repreType {
            switch repreType {
            case "1":
                idDropDown.stTitle = "포함".localized
            default:
                idDropDown.stTitle = "미포함".localized
            }
            selectedRepreType = repreType
        }
        
        idDropDown.delegate = self
        idDropDown.dropView.dropDownOptions = idNumList
        scrollView.addSubview(idDropDown)
        idDropDown.translatesAutoresizingMaskIntoConstraints = false
        idDropDown.centerYAnchor.constraint(equalTo: lblIdNumber.centerYAnchor).isActive = true
        idDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        idDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        idDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func updateLangDropDown(){
        langDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        langDropDown.name = "langDropDown"
        langDropDown.stTitle = "내용을 선택하세요".localized
        if let langType = certificateInfo?.langType {
            switch langType {
            case "K":
                langDropDown.stTitle = "한글".localized
            default:
                langDropDown.stTitle = "영어".localized
            }
            selectedLangType = langType
        }
        langDropDown.delegate = self
        langDropDown.dropView.dropDownOptions = langList
        scrollView.addSubview(langDropDown)
        langDropDown.translatesAutoresizingMaskIntoConstraints = false
        langDropDown.centerYAnchor.constraint(equalTo: lblLang.centerYAnchor).isActive = true
        langDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        langDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        langDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "certificateDropDown" {
            for item in getCdatList {
                if item.subNm == string {
                    selectedCertifiType = item.subCd ?? ""
                    
                }
            }
        }
        if name == "idDropDown"{
            if string == "포함".localized {
                selectedRepreType = "1"
            } else {
                selectedRepreType = "2"
            }
            print("selectedRepreType : \(selectedRepreType)")
        }
        
        if name == "langDropDown"{
            if string == "한글".localized {
                selectedLangType = "K"
            } else if string == "영어".localized{
                selectedLangType = "E"
            }
            print("selectedLangType : \(selectedLangType)")
        }
    }
    
    @objc func btnDraftClicked(){
        var approvalId = ""
        for (index, item) in approveList.enumerated() {
            if index == 0 {
                approvalId += item.gwUserId ?? ""
            } else {
                approvalId += ","
                approvalId += item.gwUserId ?? ""
            }
        }
        
        if approvalId.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CertificateApi.draft(
            param: CertificateDraftRequest(
                certifiCd: self.certifiCd.isEmpty ? nil : self.certifiCd,
                approvalId: approvalId
            )), success: { (response: ApiResponse<CheckerDetailInfoResponse>) in
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "상신 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert  = UIAlertController(title: "알림".localized, message: "장애가 발생하였습니다. 전산실로 문의하여 주십시오".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    @objc func btnDeleteCliceked(){
        approveList = approveList.filter({
            (value: UserListDetailResponse) -> Bool in return !(value.isSelected ?? false)
        })
        cvApprove.reloadData()
        setApprovalHeight()
        btnDelete.setDisable()
    }
    
    @objc func btnSaveCliceked(){
        if selectedCertifiType.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "신청구분을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if selectedRepreType.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "주민번호구분을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if selectedLangType.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "언어를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if tfremmark.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "용도를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if tfIssueQty.text!.isEmpty || tfIssueQty.text == "0" {
            let alert  = UIAlertController(title: "알림".localized, message: "발행수량 최소값은 1입니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CertificateApi.infoUpdate(
            param: CertificateInfoUpdateRequest(
                certifiCd: certifiCd.isEmpty ? nil : certifiCd,
                certifiType: selectedCertifiType,
                remark: tfremmark.text ?? "",
                repreType: selectedRepreType,
                langType: selectedLangType,
                issueQty: tfIssueQty.text ?? ""
            )), success: { (response: ApiResponse<CertificateInfoUpdateResponse>) in
            self.hud.dismiss()
            print("response \(response)")
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert  = UIAlertController(title: "알림".localized, message: "장애가 발생하였습니다. 전산실로 문의하여 주십시오".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    @objc func btnCloseClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    func getApproveList(approveList:[UserListDetailResponse]){
        self.approveList = approveList
        cvApprove.reloadData()
        setApprovalHeight()
    }
    
    @objc func btnApprovalListClicked(){
        //        let vc = ApprovalListViewController()
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true, completion: nil)
        
        if let getVc = util.getViewControllerFromText(label: "사용자 결재선".localized) {
            if let getVc2 = getVc as? ApprovalListViewController {
                getVc2.previousViewController = self
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
                //                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension CertificateAddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return approveList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalUserCollectionViewCell.ID, for: indexPath) as! ApprovalUserCollectionViewCell
        cell.lblTitle.text = approveList[indexPath.row].prsnNm ?? ""
        if let selected = approveList[indexPath.row].isSelected {
            if selected {
                cell.backgroundColor = .lightGray
            } else {
                cell.backgroundColor = .white
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvApprove {
            if(approveList[indexPath.row].isSelected ?? false) {
                approveList[indexPath.row].isSelected = false
                btnDelete.isEnabled = false
                btnDelete.setDisable()
            }else {
                for (index, _) in approveList.enumerated() {
                    approveList[index].isSelected = false
                    btnDelete.isEnabled = false
                    btnDelete.setDisable()
                }
                if erpStatus == "" || erpStatus == "반려".localized {
                    approveList[indexPath.row].isSelected = true
                    btnDelete.isEnabled = true
                    btnDelete.setEnable()
                }
            }
            cvApprove.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("collectionView : \(collectionView)")
        if collectionView == cvApprove {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 40)
        } else {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 86)
        }
    }
}

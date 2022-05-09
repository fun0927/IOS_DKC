//
//  CardAddViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit
import JGProgressHUD
class CardAddViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, DropDownViewProtocol {
    let hud = JGProgressHUD()
    let util = Util()
    
    var cardInfo: CardInfoListData?
    
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
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
        
    let lblReqDiv: UILabel = {
        let label = UILabel()
        label.text = "신청구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var reqDivDropDown = DropDownBtn()
    var reqDivList:[String] = []
    var getReqDivList:[CodeListDetailResponse] = []
    
    var summaryList = ["~ 30만원 미만".localized,"30 ~ 100만원 미만".localized,"100 ~ 200만원 미만".localized,"200만원 이상".localized]
    let cvSummary = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    var selectedUseDate = Date()
    
    let lblUseDate: UILabel = {
        let label = UILabel()
        label.text = "사용일자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblUseDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblattPer: UILabel = {
        let label = UILabel()
        label.text = "참석인원".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfattPer: UITextField = {
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
    
    let lblusePlace: UILabel = {
        let label = UILabel()
        label.text = "사용장소".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfusePlace: UITextField = {
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
    
    let lblexPur: UILabel = {
        let label = UILabel()
        label.text = "지출목적".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfexPur: UITextField = {
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
    
    let lblforeAmtNum: UILabel = {
        let label = UILabel()
        label.text = "예상금액".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfforeAmtNum: UITextField = {
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
    
    
    
    var selectedReturnDate = Date()
    
    let lblReturnDate: UILabel = {
        let label = UILabel()
        label.text = "반납예정일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblReturnDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblcustNm : UILabel = {
        let label = UILabel()
        label.text = "거래처명".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfcustNm: UITextField = {
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
    
    let stackView = UIStackView()
    var stackViewTopAnchor:NSLayoutConstraint?
    
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
    
    let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("닫기".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let scrollView = UIScrollView()
    var stat = ""
    var statCd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        cvApproveHeightAnchor = cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(80))
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
        
        //        scrollView.addSubview(lblApproveTitle)
        //        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
        //        lblApproveTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        //        lblApproveTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        //
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
        //        if stat == "" && stat == "작성" {
        //            btnDraft.isEnabled = true
        //            btnDraft.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        //            print("btnDraft is enabled")
        //        }
        ////
        //        scrollView.addSubview(btnEdit)
        //        btnEdit.translatesAutoresizingMaskIntoConstraints = false
        //        btnEdit.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16).isActive = true
        //        btnEdit.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        //        btnEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        btnEdit.heightAnchor.constraint(equalToConstant: 51).isActive = true
        //        btnEdit.isHidden = true
        ////
        //        if stat == "" && stat == "작성" {
        //            btnEdit.isHidden = false
        //        }
        //        btnEdit.addTarget(self, action: #selector(btnEditClicked), for: .touchUpInside)
        
        //        scrollView.addSubview(btnDelete)
        //        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        //        var btnDeleteTopAnchor =  btnDelete.topAnchor.constraint(equalTo: btnEdit.bottomAnchor, constant: 16)
        //        btnDeleteTopAnchor.isActive = true //
        //        btnDelete.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        //        btnDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        btnDelete.isHidden = true
        //        if statCd == "110" || statCd == "130" || statCd == "310" || statCd == "330"{
        //            btnDelete.isHidden = true
        //        }
        //        if !btnEdit.isHidden && !btnDelete.isHidden {
        //            btnDeleteTopAnchor.isActive = false
        //            btnDeleteTopAnchor =  btnDelete.topAnchor.constraint(equalTo: btnEdit.bottomAnchor, constant: 83)
        //            btnDeleteTopAnchor.isActive = true
        //        }
        
        scrollView.addSubview(lblRequestTitle)
        lblRequestTitle.translatesAutoresizingMaskIntoConstraints = false
        lblRequestTitle.topAnchor.constraint(equalTo: cvApproval.bottomAnchor, constant: 32).isActive = true
        lblRequestTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblReqDiv)
        lblReqDiv.translatesAutoresizingMaskIntoConstraints = false
        lblReqDiv.topAnchor.constraint(equalTo: lblRequestTitle.bottomAnchor, constant: 30).isActive = true
        lblReqDiv.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblReqDiv.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let divider = UIView()
        scrollView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: lblReqDiv.bottomAnchor, constant: 30).isActive = true
        divider.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        let cvSumLayout = UICollectionViewFlowLayout()
        cvSumLayout.minimumInteritemSpacing = 0
        cvSumLayout.minimumLineSpacing = 0
        cvSumLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvSummary.collectionViewLayout = cvSumLayout
        cvSummary.delegate = self
        cvSummary.dataSource = self
        cvSummary.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.addSubview(cvSummary)
        cvSummary.translatesAutoresizingMaskIntoConstraints = false
        cvSummary.topAnchor.constraint(equalTo: lblReqDiv.bottomAnchor, constant: 31).isActive = true
        cvSummary.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvSummary.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvSummary.heightAnchor.constraint(equalToConstant: CGFloat(256)).isActive = true
        //        cvSummary.layer.borderWidth = 1
        //        cvSummary.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        //        cvSummary.layer.cornerRadius = 8
        
        cvSummary.register(CardAddCollectionViewCell.self, forCellWithReuseIdentifier: CardAddCollectionViewCell.ID)
        cvSummary.isScrollEnabled = false
        
        
        scrollView.addSubview(lblRequester)
        lblRequester.translatesAutoresizingMaskIntoConstraints = false
        lblRequester.topAnchor.constraint(equalTo: lblRequestTitle.bottomAnchor, constant: 371).isActive = true
        lblRequester.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblRequester.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblRequesterValue)
        lblRequesterValue.translatesAutoresizingMaskIntoConstraints = false
        lblRequesterValue.centerYAnchor.constraint(equalTo: lblRequester.centerYAnchor).isActive = true
        lblRequesterValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 134).isActive = true
        lblRequesterValue.text = Environment.USER_NAME
        
        scrollView.addSubview(lblUseDate)
        lblUseDate.translatesAutoresizingMaskIntoConstraints = false
        lblUseDate.topAnchor.constraint(equalTo: lblRequester.bottomAnchor, constant: 41).isActive = true
        lblUseDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblUseDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let startDateView = UIView()
        scrollView.addSubview(startDateView)
        startDateView.translatesAutoresizingMaskIntoConstraints = false
        startDateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        startDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        startDateView.centerYAnchor.constraint(equalTo: lblUseDate.centerYAnchor).isActive = true
        startDateView.backgroundColor = .white
        startDateView.layer.borderWidth = 1
        startDateView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        startDateView.layer.cornerRadius = 8
        startDateView.isUserInteractionEnabled = true
        let startDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startDateViewClicked))
        startDateView.addGestureRecognizer(startDateViewTap)
        
        scrollView.addSubview(lblUseDateValue)
        lblUseDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblUseDateValue.centerYAnchor.constraint(equalTo: lblUseDate.centerYAnchor).isActive = true
        lblUseDateValue.leadingAnchor.constraint(equalTo: startDateView.leadingAnchor, constant: 15).isActive = true
        //        let formatter2 = DateFormatter()
        //        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        lblStartDateValue.text = formatter2.string(from: self.selectedStartDate)
        lblUseDateValue.text = "날짜를 선택하세요".localized
        lblUseDateValue.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        
        scrollView.addSubview(lblattPer)
        lblattPer.translatesAutoresizingMaskIntoConstraints = false
        lblattPer.topAnchor.constraint(equalTo: lblUseDate.bottomAnchor, constant: 43).isActive = true
        lblattPer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblattPer.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfattPer)
        tfattPer.translatesAutoresizingMaskIntoConstraints = false
        tfattPer.centerYAnchor.constraint(equalTo: lblattPer.centerYAnchor).isActive = true
        tfattPer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfattPer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfattPer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblusePlace)
        lblusePlace.translatesAutoresizingMaskIntoConstraints = false
        lblusePlace.topAnchor.constraint(equalTo: lblattPer.bottomAnchor, constant: 43).isActive = true
        lblusePlace.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblusePlace.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfusePlace)
        tfusePlace.translatesAutoresizingMaskIntoConstraints = false
        tfusePlace.centerYAnchor.constraint(equalTo: lblusePlace.centerYAnchor).isActive = true
        tfusePlace.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfusePlace.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfusePlace.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblexPur)
        lblexPur.translatesAutoresizingMaskIntoConstraints = false
        lblexPur.topAnchor.constraint(equalTo: lblusePlace.bottomAnchor, constant: 43).isActive = true
        lblexPur.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblexPur.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfexPur)
        tfexPur.translatesAutoresizingMaskIntoConstraints = false
        tfexPur.centerYAnchor.constraint(equalTo: lblexPur.centerYAnchor).isActive = true
        tfexPur.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfexPur.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfexPur.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        scrollView.addSubview(lblforeAmtNum)
        lblforeAmtNum.translatesAutoresizingMaskIntoConstraints = false
        lblforeAmtNum.topAnchor.constraint(equalTo: lblexPur.bottomAnchor, constant: 43).isActive = true
        lblforeAmtNum.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblforeAmtNum.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfforeAmtNum)
        tfforeAmtNum.translatesAutoresizingMaskIntoConstraints = false
        tfforeAmtNum.centerYAnchor.constraint(equalTo: lblforeAmtNum.centerYAnchor).isActive = true
        tfforeAmtNum.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfforeAmtNum.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfforeAmtNum.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblReturnDate)
        lblReturnDate.translatesAutoresizingMaskIntoConstraints = false
        lblReturnDate.topAnchor.constraint(equalTo: lblforeAmtNum.bottomAnchor, constant: 41).isActive = true
        lblReturnDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblReturnDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let returnDateView = UIView()
        scrollView.addSubview(returnDateView)
        returnDateView.translatesAutoresizingMaskIntoConstraints = false
        returnDateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        returnDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        returnDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        returnDateView.centerYAnchor.constraint(equalTo: lblReturnDate.centerYAnchor).isActive = true
        returnDateView.backgroundColor = .white
        returnDateView.layer.borderWidth = 1
        returnDateView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        returnDateView.layer.cornerRadius = 8
        returnDateView.isUserInteractionEnabled = true
        let returnDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(returnDateViewClicked))
        returnDateView.addGestureRecognizer(returnDateViewTap)
        
        scrollView.addSubview(lblReturnDateValue)
        lblReturnDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblReturnDateValue.centerYAnchor.constraint(equalTo: lblReturnDate.centerYAnchor).isActive = true
        lblReturnDateValue.leadingAnchor.constraint(equalTo: startDateView.leadingAnchor, constant: 15).isActive = true
        lblReturnDateValue.text = "날짜를 선택하세요".localized
        lblReturnDateValue.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        scrollView.addSubview(lblcustNm)
        lblcustNm.translatesAutoresizingMaskIntoConstraints = false
        lblcustNm.topAnchor.constraint(equalTo: lblReturnDate.bottomAnchor, constant: 43).isActive = true
        lblcustNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblcustNm.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfcustNm)
        tfcustNm.translatesAutoresizingMaskIntoConstraints = false
        tfcustNm.centerYAnchor.constraint(equalTo: lblcustNm.centerYAnchor).isActive = true
        tfcustNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfcustNm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfcustNm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tfcustNm.isHidden = true
        lblcustNm.isHidden = true
        
        lblcustNm.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -120).isActive = true
        
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewTopAnchor = stackView.topAnchor.constraint(equalTo: lblReturnDate.bottomAnchor, constant:33)
        stackViewTopAnchor?.isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnCancel)
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyyMMdd"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        
        if let cardInfo = cardInfo {
            let reqDate:String = cardInfo.reqDate ?? ""
            lblUseDateValue.text = dateFormatter2.string(from: dateFormatter1.date(from: reqDate)!)
            lblUseDateValue.textColor = .black
            tfattPer.text = cardInfo.attPer
            tfusePlace.text = cardInfo.usePlace
            tfexPur.text = cardInfo.exPur
            tfforeAmtNum.text = cardInfo.foreAmtNum
            let returnDate:String = cardInfo.returnDate ?? ""
            lblReturnDateValue.text = dateFormatter2.string(from: dateFormatter1.date(from: returnDate)!)
            lblReturnDateValue.textColor = .black
            tfcustNm.text = cardInfo.custNm
        }
        
        hideKeyboardWhenTappedAround()
        
        getReqDivCode()
        setView()
    }
    
    var isDraft = false
    var isDraftCancel = false
    var isApprovalCancel = false
    
    func setView() {
        if(cardInfo != nil) {
            if let msgCd = cardInfo?.msgCd {
                getApprovalLine(msgCd: msgCd)
            }
            
            if stat == "작성".localized {
                btnApprovalList.setEnable()
                btnDraft.setEnable()
                isDraft = true
                
                btnSave.setEnable()
            }else {
                btnApprovalList.setDisable()
                btnDraft.setDisable()
                
                btnSave.setDisable()
            }
            if (statCd == "100" || statCd == "300") && stat == "진행".localized {
                btnApprovalList.setDisable()
                
                btnDraft.setTitle("상신취소".localized, for: .normal)
                btnDraft.setEnable()
                isDraftCancel = true
                
                btnSave.setDisable()
            }
            if statCd == "130" && stat != "임시상신".localized && cardInfo?.appYn == ""{
                btnApprovalList.setDisable()
                
                btnDraft.setTitle("결재취소".localized, for: .normal)
                btnDraft.setEnable()
                isApprovalCancel = true
                
                btnSave.setDisable()
            }
        }else {
            cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
            cardInfo = CardInfoListData()
            cardInfo?.divCd = Environment.USER_DIV_CD
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
    
    @objc func btnSaveClicked() {
        if (self.cardInfo?.reqDiv ?? "").isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "신청구분을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if lblUseDateValue.text!.contains("선택"){
            let alert  = UIAlertController(title: "알림".localized, message: "사용일자를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if tfattPer.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "참석인원을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if tfusePlace.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "사용장소를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if tfexPur.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "지출목적을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if tfforeAmtNum.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "예상금액을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if lblReturnDateValue.text!.contains("선택".localized){
            let alert  = UIAlertController(title: "알림".localized, message: "반납예정일를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        
        guard let useD = dateFormatter1.date(from: lblUseDateValue.text ?? "") else { return }
        guard let retD = dateFormatter1.date(from: lblReturnDateValue.text ?? "") else { return }
        
        if useD.compare(retD) == .orderedDescending {
            let alert  = UIAlertController(title: "알림".localized, message: "사용일보다 반납일이 빠를 수 없습니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyyMMdd"
        
        let useDate = dateFormatter2.string(from: useD)
        let returnDate = dateFormatter2.string(from: retD)
        
        ApiService.request(
            router: CardApi.infoUpdate(
                param: CardInfoUpdateRequest(
                    divCdParam: cardInfo?.divCd,
                    reqDate: cardInfo?.reqDate,
                    seq: cardInfo?.seq,
                    reqDiv: cardInfo?.reqDiv,
                    useDate: useDate,
                    attPer: tfattPer.text,
                    usePlace: tfusePlace.text,
                    exPur: tfexPur.text,
                    foreAmtNum: tfforeAmtNum.text,
                    returnDate: returnDate,
                    custNm: tfcustNm.text
                    )),
            success: { (response: ApiResponse<CardInfoUpdateResponse>) in
                if let result = response.value {
                    if result.status ?? false {
                        let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                            NotificationCenter.default.post(name: Notification.Name("callReload"), object: nil)
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
            print("error : \(error)")
        }
    }
    
    @objc func btnCancelClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    func setApprovalHeight() {
        let innerH = 16 + ([(approveList.count * 40), 40].max() ?? 40)
        
        var outerH = 120
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
    @objc func btnDeleteCliceked(){
        approveList = approveList.filter({
            (value: UserListDetailResponse) -> Bool in return !(value.isSelected ?? false)
        })
        cvApprove.reloadData()
        self.setApprovalHeight()
        btnDelete.setDisable()
    }
    
    @objc func startDateViewClicked(){
        let timePicker = UIDatePicker()
        timePicker.setDate(self.selectedUseDate, animated: false)
        //        timePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.datePickerMode = .date
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        //        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            //            formatter1.dateFormat = "yyyyMMdd"
            self.lblUseDateValue.text = formatter1.string(from: self.selectedUseDate)
            //            self.calculateDudyDays()
            self.lblUseDateValue.textColor = .black
            
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
        })
        timePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        selectedUseDate = sender.date
    }
    
    @objc func returnDateViewClicked(){
        let timePicker = UIDatePicker()
        timePicker.setDate(self.selectedReturnDate, animated: false)
        //        timePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.datePickerMode = .date
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            //            formatter1.dateFormat = "yyyyMMdd"
            self.lblReturnDateValue.text = formatter1.string(from: self.selectedReturnDate)
            self.lblReturnDateValue.textColor = .black
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
        })
        timePicker.addTarget(self, action: #selector(returnTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func returnTimeDiveChanged(sender: UIDatePicker) {
        selectedReturnDate = sender.date
    }
    
    func getReqDivCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "EXA011")), success: { (response: ApiResponse<CodeListResponse>) in
            self.reqDivList.removeAll()
            self.reqDivList.append("내용을 선택하세요".localized)
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getReqDivList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getReqDivList.indices {
                            self.getReqDivList[index].subNm = self.getReqDivList[index].jpnSubNm
                        }
                    }
                    for item in self.getReqDivList {
                        self.reqDivList.append(item.subNm ?? "")
                    }
                    self.updateDropDown()
                }
                
            }
            
        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
        }
    }
    
    func updateDropDown(){
        reqDivDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        reqDivDropDown.name = "reqDivDropDown"
        reqDivDropDown.stTitle = "내용을 선택하세요".localized
        
        if (self.cardInfo?.reqDiv ?? "") != "" {
            for item in getReqDivList {
                if let subCd = item.subCd {
                    if(subCd == self.cardInfo?.reqDiv) {
                        reqDivDropDown.stTitle = item.subNm!
                        if(subCd == "1") {
                            lblcustNm.isHidden = true
                            tfcustNm.isHidden = true
                            stackViewTopAnchor?.isActive = false
                            stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: lblReturnDate.bottomAnchor, constant:33)
                            stackViewTopAnchor?.isActive = true
                        }else {
                            lblcustNm.isHidden = false
                            tfcustNm.isHidden = false
                            stackViewTopAnchor?.isActive = false
                            stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: lblcustNm.bottomAnchor, constant:33)
                            stackViewTopAnchor?.isActive = true
                        }
                    }
                }
            }
        }else {
            reqDivDropDown.stTitle = reqDivList[0]
            reqDivDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        reqDivDropDown.delegate = self
        reqDivDropDown.dropView.dropDownOptions = self.reqDivList
        scrollView.addSubview(reqDivDropDown)
        reqDivDropDown.translatesAutoresizingMaskIntoConstraints = false
        reqDivDropDown.centerYAnchor.constraint(equalTo: lblReqDiv.centerYAnchor).isActive = true
        reqDivDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 95).isActive = true
        reqDivDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        reqDivDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        let vc = CardAddViewAgreementController()
        cardInfo?.reqDiv = ""
        reqDivDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        for item in getReqDivList {
            if item.subNm == string {
                print("item.subCd : \(item.subCd)")
                cardInfo?.reqDiv = item.subCd
                print("cardInfo?.reqDiv : \(cardInfo?.reqDiv)")
                
                vc.subCd = item.subCd ?? ""
                vc.subNm = item.subNm ?? ""
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                reqDivDropDown.lblTitle.textColor = .black
                
                if(item.subCd == "1") {
                    lblcustNm.isHidden = true
                    tfcustNm.isHidden = true
                    stackViewTopAnchor?.isActive = false
                    stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: lblReturnDate.bottomAnchor, constant:33)
                    stackViewTopAnchor?.isActive = true
                }else {
                    lblcustNm.isHidden = false
                    tfcustNm.isHidden = false
                    stackViewTopAnchor?.isActive = false
                    stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: lblcustNm.bottomAnchor, constant:33)
                    stackViewTopAnchor?.isActive = true
                }
                return
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cvApprove.reloadData()
        setApprovalHeight()
    }
    
    @objc func btnApprovalListClicked(){
        if let getVc = util.getViewControllerFromText(label: "사용자 결재선".localized) {
            if let getVc2 = getVc as? ApprovalListViewController {
                getVc2.previousViewController = self
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
            }
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
        
        var title = ""
        var router:CardApi?
        if isDraft {
            if approvalId.isEmpty {
                let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            title = "상신 되었습니다".localized
            router = CardApi.draft(param: CardDraftRequest(
                divCdParam: cardInfo?.divCd,
                reqDate: cardInfo?.reqDate,
                seq: cardInfo?.seq,
                approvalId: approvalId
            ))
        }else if isDraftCancel {
            title = "상신취소 되었습니다".localized
            router = CardApi.draftCancel(param: CardDraftCancelRequest(
                msgCd: self.cardInfo?.msgCd ?? ""
            ))
        }else if isApprovalCancel {
            if approvalId.isEmpty {
                let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            title = "결재취소 상신 되었습니다".localized
            router = CardApi.approvalCancel(param: CardApprovalCancelRequest(
                divCdParam: cardInfo?.divCd,
                reqDate: cardInfo?.reqDate,
                seq: cardInfo?.seq,
                approvalId: approvalId
            ))
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if let rot = router {
            ApiService.request(router: rot, success: { (response: ApiResponse<CardInfoUpdateResponse>) in
                self.hud.dismiss()
                if let result = response.value {
                    if result.status ?? false {
                        let alert  = UIAlertController(title: "알림".localized, message: title, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                            NotificationCenter.default.post(name: Notification.Name("callReload"), object: nil)
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
    }
    
    @objc func btnApprovalDeleteClicked() {
        approveList = approveList.filter({
            (value: UserListDetailResponse) -> Bool in return !(value.isSelected ?? false)
        })
        cvApprove.reloadData()
        setApprovalHeight()
        btnDelete.setDisable()
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


extension CardAddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvApprove {
            return approveList.count
        } else {
            let count = summaryList.count + 1
            print("summaryList count : \(count)")
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvApprove {
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardAddCollectionViewCell.ID, for: indexPath) as! CardAddCollectionViewCell
            if indexPath.row == 0 {
                cell.lblAmount.text = "사용금액".localized
                cell.lbl1.text = "본부장".localized
                cell.lbl2.text = "부문장".localized
                cell.lbl3.text = "사장(부사장)".localized
                cell.lbl4.text = "대표이사".localized
                cell.lbl1.isHidden = false
                cell.lbl2.isHidden = false
                cell.lbl3.isHidden = false
                cell.lbl4.isHidden = false
                cell.view1.isHidden = true
                cell.view2.isHidden = true
                cell.view3.isHidden = true
                cell.view4.isHidden = true
            } else {
                if indexPath.row-1 < summaryList.count {
                    cell.lblAmount.text = summaryList[indexPath.row-1]
                }
                
                cell.lbl1.isHidden = true
                cell.lbl2.isHidden = true
                cell.lbl3.isHidden = true
                cell.lbl4.isHidden = true
                switch indexPath.row {
                case 1:
                    cell.view1.isHidden = false
                    cell.view2.isHidden = true
                    cell.view3.isHidden = true
                    cell.view4.isHidden = true
                case 2:
                    cell.view1.isHidden = false
                    cell.view2.isHidden = false
                    cell.view3.isHidden = true
                    cell.view4.isHidden = true
                case 3:
                    cell.view1.isHidden = false
                    cell.view2.isHidden = false
                    cell.view3.isHidden = false
                    cell.view4.isHidden = true
                default:
                    cell.view1.isHidden = false
                    cell.view2.isHidden = false
                    cell.view3.isHidden = false
                    cell.view4.isHidden = false
                }
            }
            return cell
        }
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
                if btnApprovalList.isEnabled {
                    approveList[indexPath.row].isSelected = true
                    btnDelete.isEnabled = true
                    btnDelete.setEnable()
                }
            }
            cvApprove.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvApprove {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 40)
        } else {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 51)
        }
    }
}

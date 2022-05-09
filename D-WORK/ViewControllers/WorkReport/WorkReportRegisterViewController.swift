//
//  WorkReportRegisterViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import UIKit
import JGProgressHUD
class WorkReportRegisterViewController: UIViewController, DropDownViewProtocol, TopViewBackProtocol, TopViewTitleProtocol {
    
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
        
    let scrollView = UIScrollView()
    var reportData:WorkReportListDetailResponse?
    var isClose = false
    var yyyymmdd = ""
    var comeTime = ""
    var cdat21Nm1 = ""
    var cdat21Nm2 = ""
    var cdat21Nm3 = ""
    var cdat21Nm4 = ""
    var cdat21Nm5 = ""
    var cdat21Nm6 = ""
    
    let hud = JGProgressHUD()
    let util = Util()
    
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
    
    let btnApprovalDelete: UIButton = {
        let button = UIButton()
        button.setTitle("삭제".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var approveList:[UserListDetailResponse] = [] // 실제 화면에 보여지는 리스트
    let cvApprove = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let lblRequestTitle: UILabel = {
        let label = UILabel()
        label.text = "신청 정보".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let lbldivNm: UILabel = {
        let label = UILabel()
        label.text = "사업부문".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var divNmDropDown = DropDownBtn()
    var divNmList:[String] = []
    var getdivNmList:[WorkReportReqInfoListDetailResponse] = []
    
    let cvRequest = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvRequestTitleArray = ["작성자".localized,"출근일자".localized,"출근시간".localized,"퇴근일자".localized,"퇴근시간".localized,"근무시간".localized]
    var cvRequestValueArray:[String] = []
    
    let lblupcda4: UILabel = {
        let label = UILabel()
        label.text = "구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var upcda4DropDown = DropDownBtn()
    var upcda4List:[String] = []
    var getupcda4List:[CodeListDetailResponse] = []
    var getCdatList:[CodeListDetailResponse] = []
    
    var isBtnEnable = true
    
    let lblnpnoa4: UILabel = {
        let label = UILabel()
        label.text = "작업번호".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblnpnoa4Value: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let lblcdaca4: UILabel = {
        let label = UILabel()
        label.text = "관리코드".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblcdaca4Value: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    
    let lblremka4: UILabel = {
        let label = UILabel()
        label.text = "업무내용".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfremka4: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "업무내용을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lbluphma4: UILabel = {
        let label = UILabel()
        label.text = "업무시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfuphma4: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.placeholder = "업무시간을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblRegisterTitle: UILabel = {
        let label = UILabel()
        label.text = "등록".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let btnAdd: UIButton = {
        let button = UIButton()
        button.setTitle("추가".localized,for: .normal)
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
    
    var selectedUpcda4 = "" // 구분
    var selectedDivcd4 = ""
    
    var updateList:[WorkReportUpdateList] = []
    let cvReport = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvReportHeightAnchor:NSLayoutConstraint?
    //    var workReportUpdateList:[WorkReportUpdateList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("reportData :\(reportData!)")
        cvRequestValueArray.append(Environment.USER_NAME)
        if let comeDay = reportData?.comeDay {
            let editYear = String(comeDay.prefix(4))
            
            let start = comeDay.index(comeDay.startIndex, offsetBy: 4)
            let end = comeDay.index(comeDay.endIndex, offsetBy: -2)
            let range = start..<end
            let editMonth = comeDay[range]
            print("editMonth : \(editMonth)")
            
            let editDay = (comeDay.suffix(2))
            
            cvRequestValueArray.append("\(editYear)-\(editMonth)-\(editDay)")
        }else {
            cvRequestValueArray.append("")
        }
        
        if let comeTime = reportData?.comeTime{
            let editComeStart = String(comeTime.prefix(2))
            let editComeEnd = (comeTime.suffix(2))
            cvRequestValueArray.append("\(editComeStart):\(editComeEnd)")
        }else {
            cvRequestValueArray.append("")
        }
        if let leaveDay = reportData?.leaveDay {
            let editYear = String(leaveDay.prefix(4))
            
            let start = leaveDay.index(leaveDay.startIndex, offsetBy: 4)
            let end = leaveDay.index(leaveDay.endIndex, offsetBy: -2)
            let range = start..<end
            let editMonth = leaveDay[range]
            print("editMonth : \(editMonth)")
            
            let editDay = (leaveDay.suffix(2))
            
            cvRequestValueArray.append("\(editYear)-\(editMonth)-\(editDay)")
        }else {
            cvRequestValueArray.append("")
        }
        
        if let leaveTime = reportData?.leaveTime {
            let editLeaveStart = String(leaveTime.prefix(2))
            let editLeaveEnd = String(leaveTime.suffix(2))
            cvRequestValueArray.append("\(editLeaveStart):\(editLeaveEnd)")
        }else {
            cvRequestValueArray.append("")
        }
        
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
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let cvApprovalLayout = UICollectionViewFlowLayout()
        cvApprovalLayout.minimumLineSpacing = 0
        cvApprovalLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvApproval.collectionViewLayout = cvApprovalLayout
        
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
        cvApprove.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
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
        
        cvApproval.addSubview(btnApprovalDelete)
        btnApprovalDelete.translatesAutoresizingMaskIntoConstraints = false
        btnApprovalDelete.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16).isActive = true
        btnApprovalDelete.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnApprovalDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnApprovalDelete.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnApprovalDelete.addTarget(self, action: #selector(btnApprovalDeleteClicked), for: .touchUpInside)
        btnApprovalDelete.setDisable()
        
        scrollView.addSubview(lblRequestTitle)
        lblRequestTitle.translatesAutoresizingMaskIntoConstraints = false
        lblRequestTitle.topAnchor.constraint(equalTo: cvApproval.bottomAnchor, constant: 16).isActive = true
        lblRequestTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lbldivNm)
        lbldivNm.translatesAutoresizingMaskIntoConstraints = false
        lbldivNm.topAnchor.constraint(equalTo: lblRequestTitle.bottomAnchor, constant: 30).isActive = true
        lbldivNm.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lbldivNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        
        let cvRequestLayout = UICollectionViewFlowLayout()
        cvRequestLayout.minimumLineSpacing = 24
        cvRequestLayout.minimumInteritemSpacing = 0
        cvRequestLayout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        cvRequest.collectionViewLayout = cvRequestLayout
        
        cvRequest.delegate = self
        cvRequest.dataSource = self
        cvRequest.backgroundColor = .white
        scrollView.addSubview(cvRequest)
        cvRequest.translatesAutoresizingMaskIntoConstraints = false
        cvRequest.topAnchor.constraint(equalTo: lbldivNm.bottomAnchor, constant: 30).isActive = true
        cvRequest.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvRequest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvRequest.heightAnchor.constraint(equalToConstant: CGFloat(311)).isActive = true
        cvRequest.layer.borderWidth = 1
        cvRequest.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        cvRequest.layer.cornerRadius = 8
        
        cvRequest.register(WorkReportRegisterRequestCell.self, forCellWithReuseIdentifier: WorkReportRegisterRequestCell.ID)
        cvRequest.isScrollEnabled = false
        
        scrollView.addSubview(lblRegisterTitle)
        lblRegisterTitle.translatesAutoresizingMaskIntoConstraints = false
        lblRegisterTitle.topAnchor.constraint(equalTo: cvRequest.bottomAnchor, constant: 32).isActive = true
        lblRegisterTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblupcda4)
        lblupcda4.translatesAutoresizingMaskIntoConstraints = false
        lblupcda4.topAnchor.constraint(equalTo: lblRegisterTitle.bottomAnchor, constant: 30).isActive = true
        lblupcda4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lblupcda4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        
        scrollView.addSubview(lblnpnoa4)
        lblnpnoa4.translatesAutoresizingMaskIntoConstraints = false
        lblnpnoa4.topAnchor.constraint(equalTo: lblupcda4.bottomAnchor, constant: 34).isActive = true
        lblnpnoa4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lblnpnoa4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        
        let npnoa4View = UIView()
        scrollView.addSubview(npnoa4View)
        npnoa4View.translatesAutoresizingMaskIntoConstraints = false
        npnoa4View.centerYAnchor.constraint(equalTo: lblnpnoa4.centerYAnchor).isActive = true
        npnoa4View.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        npnoa4View.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        npnoa4View.heightAnchor.constraint(equalToConstant: 51).isActive = true
        npnoa4View.backgroundColor = .white
        npnoa4View.layer.borderWidth = 1
        npnoa4View.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        npnoa4View.layer.cornerRadius = 8
        let npnoa4ViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(npnoa4ViewClicked)) // show 작업번호 popup
        npnoa4View.addGestureRecognizer(npnoa4ViewTap)
        
        scrollView.addSubview(lblnpnoa4Value)
        lblnpnoa4Value.translatesAutoresizingMaskIntoConstraints = false
        lblnpnoa4Value.centerYAnchor.constraint(equalTo: npnoa4View.centerYAnchor).isActive = true
        lblnpnoa4Value.leadingAnchor.constraint(equalTo: npnoa4View.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblcdaca4)
        lblcdaca4.translatesAutoresizingMaskIntoConstraints = false
        lblcdaca4.topAnchor.constraint(equalTo: lblnpnoa4.bottomAnchor, constant: 34).isActive = true
        lblcdaca4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lblcdaca4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        
        let cdaca4View = UIView()
        scrollView.addSubview(cdaca4View)
        cdaca4View.translatesAutoresizingMaskIntoConstraints = false
        cdaca4View.centerYAnchor.constraint(equalTo: lblcdaca4.centerYAnchor).isActive = true
        cdaca4View.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        cdaca4View.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdaca4View.heightAnchor.constraint(equalToConstant: 51).isActive = true
        cdaca4View.backgroundColor = .white
        cdaca4View.layer.borderWidth = 1
        cdaca4View.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        cdaca4View.layer.cornerRadius = 8
        let cdaca4ViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cdaca4ViewClicked)) // show 관리코드 popup
        cdaca4View.addGestureRecognizer(cdaca4ViewTap)
        
        scrollView.addSubview(lblcdaca4Value)
        lblcdaca4Value.translatesAutoresizingMaskIntoConstraints = false
        lblcdaca4Value.centerYAnchor.constraint(equalTo: cdaca4View.centerYAnchor).isActive = true
        lblcdaca4Value.leadingAnchor.constraint(equalTo: cdaca4View.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblremka4)
        lblremka4.translatesAutoresizingMaskIntoConstraints = false
        lblremka4.topAnchor.constraint(equalTo: lblcdaca4.bottomAnchor, constant: 34).isActive = true
        lblremka4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lblremka4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        scrollView.addSubview(tfremka4)
        tfremka4.translatesAutoresizingMaskIntoConstraints = false
        tfremka4.centerYAnchor.constraint(equalTo: lblremka4.centerYAnchor).isActive = true
        tfremka4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfremka4.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfremka4.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        scrollView.addSubview(lbluphma4)
        lbluphma4.translatesAutoresizingMaskIntoConstraints = false
        lbluphma4.topAnchor.constraint(equalTo: lblremka4.bottomAnchor, constant: 34).isActive = true
        lbluphma4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        lbluphma4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        scrollView.addSubview(tfuphma4)
        tfuphma4.translatesAutoresizingMaskIntoConstraints = false
        tfuphma4.centerYAnchor.constraint(equalTo: lbluphma4.centerYAnchor).isActive = true
        tfuphma4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfuphma4.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfuphma4.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: lbluphma4.bottomAnchor, constant:29).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnAdd)
        stackView.addArrangedSubview(btnDelete)
        stackView.addArrangedSubview(btnSave)
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        btnSave.addTarget(self, action: #selector(btnSaveCliceked), for: .touchUpInside)
        btnDelete.setDisable()
        
        let cvReportLayout = UICollectionViewFlowLayout()
        cvReportLayout.minimumLineSpacing = 0
        cvReportLayout.minimumInteritemSpacing = 0
        cvReportLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvReport.collectionViewLayout = cvReportLayout
        
        cvReport.delegate = self
        cvReport.dataSource = self
        cvReport.backgroundColor = .white
        scrollView.addSubview(cvReport)
        cvReport.translatesAutoresizingMaskIntoConstraints = false
        cvReport.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        cvReport.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvReport.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvReportHeightAnchor = cvReport.heightAnchor.constraint(equalToConstant: 51)
        cvReportHeightAnchor?.isActive = true
        cvReport.register(WorkReportUpdateCollectionViewCell.self, forCellWithReuseIdentifier: WorkReportUpdateCollectionViewCell.ID)
        cvReport.isScrollEnabled = false
        cvReport.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        
        checkSpg()
        getRestTime()
        getCodeList(mainCd: "P74")
        getReqInfoList()
        getCdatCode()
        
        hideKeyboardWhenTappedAround()
        
        setView()
    }
    
    func setView() {
        if let reportData = reportData {
            getApprovalLine(msgCd:reportData.msgCd ?? "")
            
            if self.isClose {
                isBtnEnable = false
                btnDraft.setDisable()
                btnApprovalList.setDisable()
                btnAdd.setDisable()
                btnDelete.setDisable()
                btnSave.setDisable()
                
                lblupcda4.isUserInteractionEnabled = false
                lblupcda4.isEnabled = false
                lblnpnoa4Value.isEnabled = false
                lblcdaca4Value.isEnabled = false
                tfremka4.isEnabled = false
                tfuphma4.isEnabled = false
                
            }else {
                if let afsta3 = reportData.afsta3 {
                    if afsta3 == "" {
                        btnDraft.setTitle("상신".localized, for: .normal)
                        cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive = true
                    }else if afsta3 == "000" {
                        btnDraft.setTitle("상신".localized, for: .normal)
                    }else if afsta3 == "120" || afsta3 == "330" {
                        btnDraft.setTitle("재상신".localized, for: .normal)
                    }else if afsta3 == "100" {
                        btnApprovalList.setDisable()
                        btnDraft.setTitle("상신취소".localized, for: .normal)
                        btnApprovalDelete.isHidden = true
                    }else if afsta3 == "130" {
                        btnDraft.setTitle("결재취소".localized, for: .normal)
                    }else if afsta3 == "300" {
                        btnApprovalList.isHidden = true
                        btnDraft.isHidden = true
                        btnApprovalDelete.isHidden = true
                        
                        isBtnEnable = false
                        btnAdd.setDisable()
                        btnDelete.setDisable()
                        btnSave.setDisable()
                        
                        lblupcda4.isUserInteractionEnabled = false
                        lblupcda4.isEnabled = false
                        lblnpnoa4Value.isEnabled = false
                        lblcdaca4Value.isEnabled = false
                        tfremka4.isEnabled = false
                        tfuphma4.isEnabled = false
                    }
                }
                
                if let afsta3Nm = reportData.afsta3Nm {
                    if afsta3Nm == "결재완료".localized || afsta3Nm == "상신".localized {
                        isBtnEnable = false
                        btnAdd.setDisable()
                        btnDelete.setDisable()
                        btnSave.setDisable()
                        
                        lblupcda4.isUserInteractionEnabled = false
                        lblupcda4.isEnabled = false
                        lblnpnoa4Value.isEnabled = false
                        lblcdaca4Value.isEnabled = false
                        tfremka4.isEnabled = false
                        tfuphma4.isEnabled = false
                    }
                }
                
                if (reportData.comeTime ?? "") == "" || (reportData.leaveTime ?? "") == "" {
                    isBtnEnable = false
                    btnAdd.setDisable()
                    btnDelete.setDisable()
                    btnSave.setDisable()
                    
                    lblupcda4.isUserInteractionEnabled = false
                    lblupcda4.isEnabled = false
                    lblnpnoa4Value.isEnabled = false
                    lblcdaca4Value.isEnabled = false
                    tfremka4.isEnabled = false
                    tfuphma4.isEnabled = false
                }
            }
        }
        setApprovalHeight()
        
        if updateList.count > 0 {
            btnSave.setEnable()
        }else {
            btnSave.setDisable()
        }
    }
    
    var sPg = false
    var timeArray:[String] = []
    var totalWorkedHour = ""
    func checkSpg() {
        if cdatSpgCheck(getCdatName: cdat21Nm1) || cdatSpgCheck(getCdatName: cdat21Nm2) ||  cdatSpgCheck(getCdatName: cdat21Nm3) || cdatSpgCheck(getCdatName: cdat21Nm4) || cdatSpgCheck(getCdatName: cdat21Nm5) || cdatSpgCheck(getCdatName: cdat21Nm6) {
            sPg = true
        }
    }
    func setRest(rt: WorkReportRestReadDetailResponse) {
        let cd:String = reportData?.comeDay ?? ""
        let ct:String = reportData?.comeTime ?? ""
        let ld:String = reportData?.leaveDay ?? ""
        let lt:String = reportData?.leaveTime ?? ""
        let format = DateFormatter()
        format.dateFormat = "yyyyMMddHHmm"
        
        if cd != "" && ld != "" {
            if let cCal = format.date(from: cd+ct), let lCal = format.date(from: ld+lt) {
                let minDiff = Int(lCal.timeIntervalSince(cCal) / 60)
                let dayDiff:Int = Int(minDiff / 1440)
                let isSameDay = cd == ld
                
                self.timeArray.removeAll()
                if(self.sPg) {
                    timeArray = [
                        rt.stTLs1!,
                        rt.stTLe1!,
                        rt.stTDs1!,
                        rt.stTDe1!,
                        rt.stTBs1!,
                        rt.stTBe1!,
                        rt.stTNs1!,
                        rt.stTNe1!,
                        rt.stTMs1!,
                        rt.stTMe1!
                    ]
                }else {
                    timeArray = [
                        rt.stTLs!,
                        rt.stTLe!,
                        rt.stTDs!,
                        rt.stTDe!,
                        rt.stTBs!,
                        rt.stTBe!,
                        rt.stTNs!,
                        rt.stTNe!,
                        rt.stTMs!,
                        rt.stTMe!
                    ]
                }
                
                let min = calcWorkTime(originMin: minDiff, ct: ct, lt: lt, dayDiff: dayDiff, isSameDay: isSameDay, times: timeArray)
                let wH = min / 60
                var wM = min % 60
                wM = wM - (wM%10)
                totalWorkedHour = String(format: "%02d:%02d", wH, wM)
                self.cvRequestValueArray.append(totalWorkedHour)
                self.cvRequest.reloadData()
            }
        }else {
            totalWorkedHour = ""
            self.cvRequestValueArray.append(totalWorkedHour)
            self.cvRequest.reloadData()
        }
    }
    
    func calcWorkTime(originMin: Int, ct: String, lt: String, dayDiff: Int, isSameDay: Bool, times: [String]) -> Int {
        var min = originMin

        let timeSt = util.fnCalcFureHHMM2Min(time: ct)
        let timeEn = util.fnCalcFureHHMM2Min(time: lt)

        let lunchTime = times[0]
        let dinnerTime = times[2]
        let restTime1 = times[4]
        let restTime2 = times[6]
        let restTime3 = times[8]

        let mealTime = [lunchTime, dinnerTime]
        if (isSameDay) {
            for item in mealTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 60
//                if s in timeSt..timeEn {
                if timeSt <= s && s <= timeEn {
                    if (timeSt < s) {  // 출근시간이 식사시작시간 전 (기본)
                        if (timeEn <= e) {  //퇴근시간이 식사종료시간 이전
                            min = min - (timeEn - s)
                        } else { //퇴근 시간이 식사종료시간 이후
                            min = min - 60  //식사 시간 제외
                        }
                    } else {    //출근시간이 식사시작시간 이후
                        if (timeSt < e) { // 출근시간이 식사종료시간 이전
                            min = min - (e - timeSt)
                        } else { //출근시간이 식사종료시간 이후 (기본)

                        }
                    }
                }
            }
        } else { // 퇴근시간이 다른 날짜로 넘어가는 경우 출근 시간 ~ 00:00, 00:00 ~ 퇴근시간까지 계산
            let timeEn2 = 1440
            for item in mealTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 60
//                if (s != 0) in timeSt..timeEn2 {
                if timeSt <= s && s <= timeEn2 {
                    if (timeSt < s) {  // 출근시간이 식사시작시간 전 (기본)
                        if (timeEn2 <= e) {  //퇴근시간이 식사종료시간 이전
                            min = min - (timeEn2 - s)
                        } else { //퇴근 시간이 식사종료시간 이후
                            min = min - 60  //식사 시간 제외
                        }
                    } else {    //출근시간이 식사시작시간 이후
                        if (timeSt < e) { // 출근시간이 식사종료시간 이전
                            min = min - (e - timeSt)
                        } else { //출근시간이 식사종료시간 이후 (기본)

                        }
                    }
                }
            }
            let timeSt2 = 0
            for item in mealTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 60
//                if s in timeSt2..timeEn {
                if timeSt2 <= s && s <= timeEn {
                    if (timeSt2 < s) {  // 출근시간이 식사시작시간 전 (기본)
                        if (timeEn <= e) {  //퇴근시간이 식사종료시간 이전
                            min = min - (timeEn - s)
                        } else { //퇴근 시간이 식사종료시간 이후
                            min = min - 60  //식사 시간 제외
                        }
                    } else {    //출근시간이 식사시작시간 이후
                        if (timeSt2 < e) { // 출근시간이 식사종료시간 이전
                            min = min - (e - timeSt2)
                        } else { //출근시간이 식사종료시간 이후 (기본)

                        }
                    }
                }
            }
        }

        let restTime = [restTime1, restTime2, restTime3]
        if (!isSameDay) {   // 퇴근시간이 다른 날짜로 넘어가는 경우 출근 시간 ~ 00:00, 00:00 ~ 퇴근시간까지 계산
            let timeEn2 = 1440
            for item in restTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 30
//                if s in timeSt..timeEn2 {
                if timeSt <= s && s <= timeEn2 {
                    if (timeSt < s) {  // 출근시간이 휴게시작시간 전
                        if (timeEn2 <= e) {  //퇴근시간이 휴게종료시간 이전
                            min = min - (timeEn2 - s)
                        } else { //퇴근 시간이 휴게종료시간 이후
                            min = min - 30  //휴게 시간 제외
                        }
                    } else {    //출근시간이 휴게시작시간 이후
                        if (timeSt < e) { // 출근시간이 휴게종료시간 이전
                            min = min - (e - timeSt)
                        } else { //출근시간이 휴게종료시간 이후 (기본)

                        }
                    }
                }
            }
            let timeSt2 = 0
            for item in restTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 30
//                if s in timeSt2..timeEn {
                if timeSt2 <= s && s <= timeEn {
                    if (timeSt2 < s) {  // 출근시간이 휴게시작시간 전
                        if (timeEn <= e) {  //퇴근시간이 휴게종료시간 이전
                            min = min - (timeEn - s)
                        } else { //퇴근 시간이 휴게종료시간 이후
                            min = min - 30  //휴게 시간 제외
                        }
                    } else {    //출근시간이 휴게시작시간 이후
                        if (timeSt2 < e) { // 출근시간이 휴게종료시간 이전
                            min = min - (e - timeSt2)
                        } else { //출근시간이 휴게종료시간 이후 (기본)

                        }
                    }
                }
            }
        } else {
            for item in restTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 30
//                if s in timeSt..timeEn {
                if timeSt <= s && s <= timeEn {
                    if (timeSt < s) {  // 출근시간이 휴게시작시간 전
                        if (timeEn <= e) {  //퇴근시간이 휴게종료시간 이전
                            min = min - (timeEn - s)
                        } else { //퇴근 시간이 휴게종료시간 이후
                            min = min - 30  //휴게 시간 제외
                        }
                    } else {    //출근시간이 휴게시작시간 이후
                        if (timeSt < e) { // 출근시간이 휴게종료시간 이전
                            min = min - (e - timeSt)
                        } else { //출근시간이 휴게종료시간 이후 (기본)

                        }
                    }
                }
            }
        }

        if (!isSameDay && dayDiff != 0) {
            min += 1230 * dayDiff   //24시간 이상 근무하였을 경우 처리 (확인 필요)
        }

        return min
    }
    
    func getRestTime(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkReportApi.restRead(param: WorkReportDetailRequest(yyyymmdd: self.yyyymmdd)),
                           success: { (response: ApiResponse<WorkReportRestReadResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let rt = result.data {
                    self.setRest(rt: rt[0])
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getApprovalLine(msgCd:String){
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
    
    //작업번호
    @objc func npnoa4ViewClicked(){
        switch selectedUpcda4 {
        case "a":
            if(isBtnEnable) {
                let vc = WorkNoAViewController()
                vc.previousViewController = self
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        case "c":
            if(isBtnEnable) {
                let vc = WorkNoCViewController()
                vc.previousViewController = self
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        case "z":
            if(isBtnEnable) {
                let vc = WorkNoZViewController()
                vc.previousViewController = self
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    //관리코드
    @objc func cdaca4ViewClicked(){
        switch selectedUpcda4 {
        case "z":
            break
        default:
            if(isBtnEnable) {
                let vc = BudgetListViewController()
                vc.previousViewController = self
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func getDetailList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkReportApi.detailList(param: WorkReportDetailRequest(yyyymmdd: self.yyyymmdd)) ,
                           success: { (response: ApiResponse<WorkReportDetailListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    var totaluphma4 = 0
                    for item in list {
                        var newItem = item
                        if let uphma4 = item.uphma4 {
                            totaluphma4 += self.util.fnCalcFureHHMM2Min(time: uphma4)
                        }
                        newItem.isSelected = false
                        self.updateList.append(newItem)
                    }
                    if list.count > 0 {
                        if let divcd4 = list[0].divcd4  {
                            for item in self.getdivNmList {
                                if item.divCd == divcd4 {
                                    self.selectedDivcd4 = divcd4
                                    self.divNmDropDown.stTitle = item.divNm ?? ""
//                                    self.divNmDropDown.lblTitle.text = item.divNm
                                }
                            }
                        }
                    }
                    
                    //                    self.updateList = list
//                    var stTotalUphma4 = self.util.fnCalcMin2HHMM(getMin: totaluphma4)
                    //                    stTotalUphma4 = stTotalUphma4.count < 4 ? "0\(stTotalUphma4)" : stTotalUphma4
//                    let stIndex = stTotalUphma4.index(stTotalUphma4.startIndex, offsetBy: 2)
//                    stTotalUphma4.insert(":", at: stIndex)
//                    self.cvRequestValueArray.append(stTotalUphma4)
//                    self.cvRequest.reloadData()
                    
                    self.cvReportHeightAnchor?.isActive = false
                    let cvReportHeight = 51 * self.updateList.count + 51
                    self.cvReportHeightAnchor = self.cvReport.heightAnchor.constraint(equalToConstant: CGFloat(cvReportHeight))
                    self.cvReportHeightAnchor?.isActive = true
                    self.cvReport.reloadData()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getReqInfoList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkReportApi.reqInfoList , success: { (response: ApiResponse<WorkReportReqInfoListResponse>) in
            self.hud.dismiss()
            //            print("response : \(response)")
            if let result = response.value {
                //                print("getReqInfoList result : \(result)")
                self.divNmList.removeAll()
                self.hud.dismiss()
                if let defaultDivCd = result.data?.defaultDivCd, let list = result.data?.list {
                    self.getdivNmList = list
                    for item in list {
                        self.divNmList.append(item.divNm ?? "")
                    }
                    self.updateDivDropDown()
                    for item in self.getdivNmList {
                        if item.divCd == defaultDivCd {
                            self.selectedDivcd4 = defaultDivCd
                            self.divNmDropDown.stTitle = item.divNm ?? ""
                        }
                    }
                    self.getDetailList()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func updateDivDropDown(){
        divNmDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divNmDropDown.name = "divNmDropDown"
        divNmDropDown.stTitle = "내용을 선택하세요".localized
        divNmDropDown.delegate = self
        self.divNmDropDown.dropView.dropDownOptions = self.divNmList
        scrollView.addSubview(divNmDropDown)
        divNmDropDown.translatesAutoresizingMaskIntoConstraints = false
        divNmDropDown.centerYAnchor.constraint(equalTo: lbldivNm.centerYAnchor).isActive = true
        divNmDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        divNmDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divNmDropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    func getCodeList(mainCd:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: mainCd)), success: { (response: ApiResponse<CodeListResponse>) in
            print("response : \(response)")
            self.hud.dismiss()
            self.upcda4List.removeAll()
            if let result = response.value {
                if let list = result.data {
                    self.getupcda4List = list // 구분 from code
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getupcda4List.indices {
                            self.getupcda4List[index].subNm = self.getupcda4List[index].jpnSubNm
                        }
                    }
                    for item in self.getupcda4List {
                        self.upcda4List.append(item.subNm ?? "")
                    }
                    self.updateupcda4DropDown()
                }
            }
            
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getCdatCode() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 근태코드
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HT016_ATS")), success: { (response: ApiResponse<CodeListResponse>) in
            //            print("response : \(response)")
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getCdatList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getCdatList.indices {
                            self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                        }
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func updateupcda4DropDown(){
        print("self.upcda4List : \(self.upcda4List)")
        upcda4DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        upcda4DropDown.name = "upcda4DropDown"
        upcda4DropDown.stTitle = "내용을 선택하세요".localized
        upcda4DropDown.delegate = self
        self.upcda4DropDown.dropView.dropDownOptions = self.upcda4List
        upcda4DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        scrollView.addSubview(upcda4DropDown)
        upcda4DropDown.translatesAutoresizingMaskIntoConstraints = false
        upcda4DropDown.centerYAnchor.constraint(equalTo: lblupcda4.centerYAnchor).isActive = true
        upcda4DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        upcda4DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        upcda4DropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "upcda4DropDown" {
            for item in getupcda4List {
                if item.subNm == string {
                    self.selectedUpcda4 = item.subCd ?? ""
                    upcda4DropDown.lblTitle.textColor = .black
                    switch string {
                    case "기타".localized:
                        self.lblnpnoa4Value.text = "사내 업무".localized
                        self.lblcdaca4Value.text = ""
                    default:
                        print("item : \(item)")
                        self.lblnpnoa4Value.text = ""
                    }
                }
            }
        } else if name ==  "divNmDropDown" {
            for item in getdivNmList {
                if item.divNm == string {
                    self.selectedDivcd4 = item.divCd ?? ""
                    
                }
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
        print("approvalId :\(approvalId)" )
        
        if let afsta3 = reportData?.afsta3 {
            if(afsta3 == "000" || afsta3 == "120" || afsta3 == "330" || afsta3 == "130") {
                if approvalId.isEmpty {
                    let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
        
        var title = ""
//        var router = WorkReportApi.draft(param: WorkReportDraftRequest(yyyymmdd: yyyymmdd, approvalId: approvalId))
        var router:WorkReportApi?
        if let afsta3 = reportData?.afsta3 {
            if(afsta3 == "100") {
                title = "상신취소 되었습니다".localized
                router = WorkReportApi.draftCancel(param: WorkReportDraftCancelRequest(msgCd: self.reportData?.msgCd ?? ""))
            }else if(afsta3 == "000" || afsta3 == "120" || afsta3 == "330") {
                title = "상신 되었습니다".localized
                router = WorkReportApi.draft(param: WorkReportDraftRequest(yyyymmdd: yyyymmdd, approvalId: approvalId))
            }else if(afsta3 == "130") {
                title = "결재취소 상신 되었습니다".localized
                router = WorkReportApi.approvalCancel(param: WorkReportDraftRequest(yyyymmdd: yyyymmdd, approvalId: approvalId))
            }
        }
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        if let rot = router {
            ApiService.request(router: rot, success: { (response: ApiResponse<CodeListResponse>) in
                self.hud.dismiss()
                
                if let result = response.value {
                    if result.status ?? false {
                        //                    let alert  = UIAlertController(title: "알림".localized, message: "상신 되었습니다".localized, preferredStyle: .alert)
                        //                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        //                        if let getVc = self.util.getViewControllerFromText(label: "업무 일지 등록".localized) {
                        //                            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
                        //                        }
                        //                    }))
                        //                    self.present(alert, animated: true, completion: nil)
                        // 기존 화면전환에서 스택 형태로 구조 변경
                        let alert  = UIAlertController(title: "알림".localized, message: title, preferredStyle: .alert)
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
        if !btnApprovalDelete.isHidden {
            outerH += Int(btnApprovalDelete.intrinsicContentSize.height)
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
//        if(!btnApprovalList.isHidden && !btnDraft.isHidden && !btnApprovalDelete.isHidden) {
//            outerH = max(outerH, 270)
//        }
//        cvApprovalHeightAnchor?.isActive = false
//        cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(outerH))
//        cvApprovalHeightAnchor?.isActive = true
//    }
    
    @objc func btnApprovalDeleteClicked() {
        approveList = approveList.filter({
            (value: UserListDetailResponse) -> Bool in return !(value.isSelected ?? false)
        })
        cvApprove.reloadData()
        setApprovalHeight()
        btnApprovalDelete.setDisable()
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear approveList : \(approveList)")
        cvApprove.reloadData()
        setApprovalHeight()
    }
    
    func getwWrkNoAListFromPopup(workNoAListItem:WorkReportworkNoAListDetailResponse){
        self.lblnpnoa4Value.text = workNoAListItem.csNum
    }
    
    func getwWrkNoCListFromPopup(workNoAListItem:WorkReportworkNoAListDetailResponse){
        self.lblnpnoa4Value.text = workNoAListItem.orderNum
    }
    
    func getwWrkNoZListFromPopup(workNoZListItem:WorkReportworkNoZListDetailResponse){
        self.lblnpnoa4Value.text = workNoZListItem.vlNm
    }
    
    func getwBudgetCodeFromPopup(budgetItem:BudgetListDetailResponse){
        self.lblcdaca4Value.text = budgetItem.bgCd
    }
    
    func cdatSpgCheck(getCdatName:String) -> Bool{
        var getCdat = ""
        for item in getCdatList {
            if item.subNm == getCdatName {
                getCdat = item.subCd ?? ""
            }
        }
        if getCdat == "17" || getCdat == "18" || getCdat == "19" || getCdat == "61" {
            return true
        }
        return false
    }
    
    func setStEn() {
        let lunchTime = timeArray[0]
        let dinnerTime = timeArray[2]
        let restTime1 = timeArray[4]
        let restTime2 = timeArray[6]
        let restTime3 = timeArray[8]
        let mealTime = [lunchTime, dinnerTime]
        let restTime = [restTime1, restTime2, restTime3]
        
        for index in updateList.indices {
            var timeSt = "0000"

            let ct = self.reportData?.comeTime

            let frMin = self.util.fnCalcFureHHMM2Min(time: ct!)
            var min = frMin

            if (!self.sPg) {
                min = max(frMin, 450)
            }

            min += (min % 30 == 0) ? 0 : (30 - (min % 30))

            timeSt = self.util.fnCalcMin2HHMM(getMin: min)
            
            if (index > 0) {
                if let timeEn = updateList[index-1].timeEn {
                    timeSt = timeEn
                }
            }
            if (timeArray.count != 10) {
                return
            }

            for item in mealTime {
                let s = util.fnCalcFureHHMM2Min(time: item)
                let e = s + 60
                let timeStMin = util.fnCalcFureHHMM2Min(time: timeSt)
                if (s <= timeStMin && timeStMin < e) {
                    timeSt = util.fnCalcMin2HHMM(getMin: e)
                    break
                }
            }
            for item in restTime {
                let s = util.fnCalcFureHHMM2Min(time: item) //휴게시작시간 분
                let e = s + 30 //휴게종료시간 분
                let timeStMin = util.fnCalcFureHHMM2Min(time: timeSt) //업무시작시간 분으로 변환
                if (s <= timeStMin && timeStMin < e) { //업무시작시간이 휴게시간에 포함 될 경우
                    timeSt = util.fnCalcMin2HHMM(getMin: e) // 휴게시간 종료시간으로 업무시작시간을 설정
                    break
                }
            }

            let timeStMin:Int = util.fnCalcHHMM2Min(str: timeSt, getComeTime: frMin)
            let timeWorkMin:Int = util.fnCalcFureHHMM2Min(time: updateList[index].uphma4 ?? "")
            var timeEnMin:Int = timeStMin + timeWorkMin //종료시간 분을 단순 계산
            for item in mealTime {
                let s:Int = util.fnCalcHHMM2Min(str: item, getComeTime: frMin); //휴게시작시간 분
                let e:Int = s + 60; //휴게종료시간 분
                if (timeStMin < s && timeEnMin < e && s < timeEnMin) { //휴게시간이 업무시작 ~ 종료시간에 온전히 포함될 경우 60분 추가
                    timeEnMin += 60;
                } else {//그외의 경우 포함된 휴게시간만큼 추가
                    let ss:Int = [timeStMin, s].max()!
                    let ee:Int = [timeEnMin, e].min()!
                    timeEnMin += [ee - ss, 0].max()!
                }
            }
            for item in restTime {
                let s = util.fnCalcHHMM2Min(str: item, getComeTime: frMin) //휴게시작시간 분
                let e = s + 30; //휴게종료시간 분
                if (timeStMin < s && timeEnMin < e && s < timeEnMin) { //휴게시간이 업무시작 ~ 종료시간에 온전히 포함될 경우 30분 추가
                    timeEnMin += 30;
                } else {//그외의 경우 포함된 휴게시간만큼 추가
                    let ss:Int = [timeStMin, s].max()!
                    let ee:Int = [timeEnMin, e].min()!
                    timeEnMin += [ee - ss, 0].max()!
                }
            }
            updateList[index].timeSt = util.fnCalcMin2HHMM(getMin: timeStMin)
            updateList[index].timeEn = util.fnCalcMin2HHMM(getMin: timeEnMin)
        }
    }
    
    @objc func btnAddClicked(){
        let npnoa4 = lblnpnoa4Value.text ?? ""
        if selectedUpcda4 != "w" && npnoa4.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "작업번호를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let cdaca4 = lblcdaca4Value.text ?? ""
        if selectedUpcda4 != "z" && cdaca4.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "관리코드를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let remka4 = tfremka4.text ?? ""
        if remka4.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "업무내용을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let stUphma4 = tfuphma4.text ?? ""
        if stUphma4.isEmpty || stUphma4.count != 4 {
            let alert  = UIAlertController(title: "알림".localized, message: "업무시간을 HHMM형식으로 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let addItem = WorkReportUpdateList(
            divcd4: selectedDivcd4,
            upcda4: selectedUpcda4,
            npnoa4: npnoa4,
            cdaca4: cdaca4,
            remka4: remka4,
            timeSt: "",
            timeEn: "",
            uphma4: stUphma4,
            isSelected: false)
        
        var isSelected = false
        for index in updateList.indices {
            if updateList[index].isSelected ?? false {
                updateList[index] = addItem
                isSelected = true
            }
        }
        if(!isSelected) {
            updateList.append(addItem)
        }
        setStEn()
        
//        upcda4DropDown.stTitle = "내용을 선택하세요.".localized
//        upcda4DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        updateupcda4DropDown()
        
        selectedUpcda4 = ""
        lblnpnoa4Value.text = ""
        lblcdaca4Value.text = ""
        tfremka4.text = ""
        tfuphma4.text = ""
        
        self.btnAdd.setTitle("추가".localized,for: .normal)
        
        cvReportHeightAnchor?.isActive = false
        let cvReportHeight = 51 * updateList.count + 51
        cvReportHeightAnchor = cvReport.heightAnchor.constraint(equalToConstant: CGFloat(cvReportHeight))
        cvReportHeightAnchor?.isActive = true
        DispatchQueue.main.async {
            self.cvReport.reloadData()
            print("btnAddClicked End : \(self.updateList)")
        }
        
        if updateList.count > 0 {
            btnSave.setEnable()
        }else {
            btnSave.setDisable()
        }
    }
    
    @objc func btnDeleteClicked(){
        updateList = updateList.filter( { (value: WorkReportUpdateList) -> Bool in return !(value.isSelected ?? false) } )
        setStEn()
        
        cvReportHeightAnchor?.isActive = false
        let cvReportHeight = 51 * updateList.count + 51
        cvReportHeightAnchor = cvReport.heightAnchor.constraint(equalToConstant: CGFloat(cvReportHeight))
        cvReportHeightAnchor?.isActive = true
        cvReport.reloadData()
        
//        upcda4DropDown.stTitle = "내용을 선택하세요.".localized
//        upcda4DropDown.lblTitle.text = ""
        updateupcda4DropDown()
        selectedUpcda4 = ""
        lblnpnoa4Value.text = ""
        lblcdaca4Value.text = ""
        tfremka4.text = ""
        tfuphma4.text = ""
        
        self.btnAdd.setTitle("추가".localized,for: .normal)
        if isBtnEnable {
            btnDelete.setDisable()
        }
        if updateList.count > 0 {
            btnSave.setEnable()
        }else {
            btnSave.setDisable()
        }
    }
    
    @objc func btnSaveCliceked(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        var inUphma3 = 0
        for item in updateList {
            if let uphma4 = item.uphma4 {
                inUphma3 += util.fnCalcFureHHMM2Min(time: uphma4)
            }
        }
        let stUphma3 = util.fnCalcMin2HHMM(getMin: inUphma3)
        
        ApiService.request(router: WorkReportApi.update(param: WorkReportUpdateRequest(yyyymmdd: yyyymmdd, uphma3: stUphma3, list: updateList)), success: { (response: ApiResponse<CodeListResponse>) in
            print("response : \(response)")
            self.hud.dismiss()
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension WorkReportRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cvReport {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvApprove {
            return approveList.count
        } else if collectionView == cvRequest {
            return cvRequestTitleArray.count
        } else {
            //            cvReport
            if section == 0 {
                return 1
            } else {
                return updateList.count
            }
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
        } else if collectionView == cvRequest {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkReportRegisterRequestCell.ID, for: indexPath) as! WorkReportRegisterRequestCell
            cell.lblTitle.text = cvRequestTitleArray[indexPath.row]
            cell.lblContent.text = ""
            if cvRequestValueArray.count > indexPath.row {
                cell.lblContent.text = cvRequestValueArray[indexPath.row]
                if cvRequestValueArray[indexPath.row] == "0" {
                    cell.lblContent.text = ""
                }
            }
            
            return cell
        } else {
            //cvReport
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkReportUpdateCollectionViewCell.ID, for: indexPath) as! WorkReportUpdateCollectionViewCell
            switch indexPath.section {
            case 0:
                cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
                cell.lblnpnoa4.text = "작업번호".localized
                cell.lblcdaca4.text = "관리코드".localized
                cell.lblremka4.text = "업무내용".localized
                cell.lbluphma4.text = "업무시간".localized
            default:
                cell.lblnpnoa4.text = updateList[indexPath.row].npnoa4
                cell.lblcdaca4.text = updateList[indexPath.row].cdaca4
                cell.lblremka4.text = updateList[indexPath.row].remka4
                cell.lbluphma4.text = updateList[indexPath.row].uphma4
                
                cell.backgroundColor = .white
                if let selected = updateList[indexPath.row].isSelected {
                    if selected {
                        cell.backgroundColor = .lightGray
                    } else {
                        cell.backgroundColor = .white
                    }
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvApprove {
            if(approveList[indexPath.row].isSelected ?? false) {
                approveList[indexPath.row].isSelected = false
                btnApprovalDelete.setDisable()
            }else {
                for (index, _) in approveList.enumerated() {
                    approveList[index].isSelected = false
                    btnApprovalDelete.setDisable()
                }
                approveList[indexPath.row].isSelected = true
                btnApprovalDelete.setEnable()
            }
            cvApprove.reloadData()
        }else if collectionView == cvReport {
            switch indexPath.section {
            case 0:
                break
            default:
                if let isSelected = updateList[indexPath.row].isSelected {
                    for index in updateList.indices {
                        updateList[index].isSelected = false
                    }
                    updateList[indexPath.row].isSelected = !isSelected
                    if !isSelected {
                        for item in getupcda4List {
                            if item.subCd == updateList[indexPath.row].upcda4 {
                                upcda4DropDown.lblTitle.text = item.subNm
                                selectedUpcda4 = item.subCd ?? ""
                            }
                        }
                        
                        lblnpnoa4Value.text = updateList[indexPath.row].npnoa4 //작업번호
                        lblcdaca4Value.text = updateList[indexPath.row].cdaca4 //관리코드
                        tfremka4.text = updateList[indexPath.row].remka4 //업무내용
                        tfuphma4.text = updateList[indexPath.row].uphma4 //업무시간
                        self.btnAdd.setTitle("수정".localized,for: .normal)
                        if isBtnEnable {
                            btnDelete.setEnable()
                        }
                    }else {
                        upcda4DropDown.lblTitle.text = ""
                        selectedUpcda4 = ""
                        lblnpnoa4Value.text = ""
                        lblcdaca4Value.text = ""
                        tfremka4.text = ""
                        tfuphma4.text = ""
                        
                        self.btnAdd.setTitle("추가".localized,for: .normal)
                        if isBtnEnable {
                            btnDelete.setDisable()
                        }
                    }
                }
                cvReport.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvApprove {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 40)
        } else if collectionView == cvRequest {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 23)
        } else {
            //cvReport
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 51)
        }
    }
}

//
//  CheckerAddViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit
import JGProgressHUD
import Alamofire
import SDWebImage

class CheckerAddViewController: UIViewController, DropDownViewProtocol, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    var checkerData:CheckerMasterListDetailResponse?
    var checkerRefData:CheckerMasterListDetailResponse?
    
    let hud = JGProgressHUD()
    let util = Util()
    
    let cvApproval = UIView(frame: CGRect.zero)
    
    var cvApprovalHeightAnchor:NSLayoutConstraint?
    var cvApproveHeightAnchor:NSLayoutConstraint?
    var makeDateViewTap: UITapGestureRecognizer?
    
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
    
    
    
    let lblmakeDate: UILabel = {
        let label = UILabel()
        label.text = "근태일자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblmakeDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var selectedMakeStartDate = Date()
    
    let lblCdat: UILabel = {
        let label = UILabel()
        label.text = "근태코드".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var cdatDropDown = DropDownBtn()
    var cdatList:[String] = []
    var getCdatList:[CodeListDetailResponse] = []
    
    let lbldivCdParam: UILabel = {
        let label = UILabel()
        label.text = "겸직사업부문".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var divCdParamDropDown = DropDownBtn()
    var divCdParamList:[String] = []
    var getdivCdParamList:[CheckerDetailInfoDetailListResponse] = []
    
    let lblnationCd: UILabel = {
        let label = UILabel()
        label.text = "국가코드".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var nationDropDown = DropDownBtn()
    var nationList:[String] = []
    var getNationList:[CodeListDetailResponse] = []
    
    let lblexitCd: UILabel = {
        let label = UILabel()
        label.text = "출국구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var exitDropDown = DropDownBtn()
    var exitList:[String] = []
    var getExitList:[CodeListDetailResponse] = []
    
    let lbleduOrg: UILabel = {
        let label = UILabel()
        label.text = "시행처".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfeduOrg: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblorderNum: UILabel = {
        let label = UILabel()
        label.text = "수주번호".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tforderNum: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblcustomNm: UILabel = {
        let label = UILabel()
        label.text = "수주처".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfcustomNm: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.setLeftPaddingPoints(16)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    
    let lblorderNm: UILabel = {
        let label = UILabel()
        label.text = "공사명".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tforderNm: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.setLeftPaddingPoints(16)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let lblreason: UILabel = {
        let label = UILabel()
        label.text = "사유".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfreason: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "사유를 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    
    
    let lblStartDate: UILabel = {
        let label = UILabel()
        label.text = "기간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblStartDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var selectedStartDate:Date?
    let lblEndDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var selectedEndDate:Date?
    
    let lbldutyDays: UILabel = {
        let label = UILabel()
        label.text = "일수".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lbldutyDaysValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblremark: UILabel = {
        let label = UILabel()
        label.text = "비고".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfremark: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "비고를 입력하세요".localized
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
    
    let lblHoliday: UILabel = {
        let label = UILabel()
        label.text = "명절대체근무일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var holidayDropDown = DropDownBtn()
    var holidayList:[String] = []
    var getHolidayList:[CheckerGetMHolidayDetailResponse] = []
    
    
    let scrollView = UIScrollView()
    
    var isClose = false
    var defaultDivCd = ""
    var selectedDivCd = ""
    var selectedNationCd = ""
    var selectedExitCd = ""
    var selectedHoliday = ""
    var apprState = "000"
    var msgCd = ""
    var modifiedYn = ""
    var dutyCode  = ""
    var seq:Int?
    var erpStatus = ""
    var exitCd = ""
    var refSeq:Int?
    
    var lblorderNumTopAnchor:NSLayoutConstraint?
    var lbleduOrgTopAnchor:NSLayoutConstraint?
    var btnDeleteApprovalTopAnchor:NSLayoutConstraint?
    var lblDutyDaysTopAnchor:NSLayoutConstraint?
    
    let endDateView = UIView()
    let startDateView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
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
        self.view.addSubview(topView)
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(cvApproval)
        cvApproval.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cvApproval.translatesAutoresizingMaskIntoConstraints = false
        cvApproval.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        cvApproval.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        cvApproval.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: CGFloat(270))
        cvApprovalHeightAnchor?.isActive = true
        
        cvApproval.addSubview(lblApproveTitle)
        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
        lblApproveTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
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
        btnApprovalList.topAnchor.constraint(equalTo: lblApproveTitle.bottomAnchor, constant: 16).isActive = true
        btnApprovalList.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnApprovalList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnApprovalList.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnApprovalList.addTarget(self, action: #selector(btnApprovalListClicked), for: .touchUpInside)
        btnApprovalList.setDisable()
        
        cvApproval.addSubview(btnDraft)
        btnDraft.translatesAutoresizingMaskIntoConstraints = false
        btnDraft.topAnchor.constraint(equalTo: btnApprovalList.bottomAnchor, constant: 16).isActive = true
        btnDraft.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnDraft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnDraft.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDraft.addTarget(self, action: #selector(btnDraftClicked), for: .touchUpInside)
        btnDraft.setDisable()
        
        cvApproval.addSubview(btnEdit)
        btnEdit.translatesAutoresizingMaskIntoConstraints = false
        btnEdit.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16).isActive = true
        btnEdit.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnEdit.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnEdit.addTarget(self, action: #selector(btnEditClicked), for: .touchUpInside)
        btnEdit.isHidden = true
        
        cvApproval.addSubview(btnApprovalDelete)
        btnApprovalDelete.translatesAutoresizingMaskIntoConstraints = false
        btnDeleteApprovalTopAnchor =  btnApprovalDelete.topAnchor.constraint(equalTo: btnDraft.bottomAnchor, constant: 16)
        btnDeleteApprovalTopAnchor?.isActive = true
        btnApprovalDelete.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnApprovalDelete.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor, constant: 16).isActive = true
        btnApprovalDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnApprovalDelete.addTarget(self, action: #selector(btnApprovalDeleteClicked), for: .touchUpInside)
        btnApprovalDelete.setDisable()
        
        scrollView.addSubview(lblRequestTitle)
        lblRequestTitle.translatesAutoresizingMaskIntoConstraints = false
        lblRequestTitle.topAnchor.constraint(equalTo: cvApproval.bottomAnchor, constant: 16).isActive = true
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
        
        scrollView.addSubview(lblmakeDate)
        lblmakeDate.translatesAutoresizingMaskIntoConstraints = false
        lblmakeDate.topAnchor.constraint(equalTo: lblRequester.bottomAnchor, constant: 41).isActive = true
        lblmakeDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblmakeDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let makeDateView = UIView()
        scrollView.addSubview(makeDateView)
        makeDateView.translatesAutoresizingMaskIntoConstraints = false
        makeDateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        makeDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        makeDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        makeDateView.centerYAnchor.constraint(equalTo: lblmakeDate.centerYAnchor).isActive = true
        makeDateView.backgroundColor = .white
        makeDateView.layer.borderWidth = 1
        makeDateView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        makeDateView.layer.cornerRadius = 8
        makeDateView.isUserInteractionEnabled = true
        makeDateViewTap = UITapGestureRecognizer(target: self, action: #selector(makeDateViewClicked))
        makeDateView.addGestureRecognizer(makeDateViewTap!)
        
        scrollView.addSubview(lblmakeDateValue)
        lblmakeDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblmakeDateValue.centerYAnchor.constraint(equalTo: lblmakeDate.centerYAnchor).isActive = true
        lblmakeDateValue.leadingAnchor.constraint(equalTo: makeDateView.leadingAnchor, constant: 15).isActive = true
        
        scrollView.addSubview(lblCdat)
        lblCdat.translatesAutoresizingMaskIntoConstraints = false
        lblCdat.topAnchor.constraint(equalTo: lblmakeDate.bottomAnchor, constant: 45).isActive = true
        lblCdat.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblCdat.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lbldivCdParam)
        lbldivCdParam.translatesAutoresizingMaskIntoConstraints = false
        lbldivCdParam.topAnchor.constraint(equalTo: lblCdat.bottomAnchor, constant: 43).isActive = true
        lbldivCdParam.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivCdParam.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblnationCd)
        lblnationCd.translatesAutoresizingMaskIntoConstraints = false
        lblnationCd.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43).isActive = true
        lblnationCd.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblnationCd.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblnationCd.isHidden = true
        
        scrollView.addSubview(lblexitCd)
        lblexitCd.translatesAutoresizingMaskIntoConstraints = false
        lblexitCd.topAnchor.constraint(equalTo: lblnationCd.bottomAnchor, constant: 43).isActive = true
        lblexitCd.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblexitCd.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblexitCd.isHidden = true
        
        scrollView.addSubview(lbleduOrg)
        lbleduOrg.translatesAutoresizingMaskIntoConstraints = false
        lbleduOrgTopAnchor = lbleduOrg.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43)
        lbleduOrgTopAnchor?.isActive = true
        lbleduOrg.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbleduOrg.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lbleduOrg.isHidden = true
        
        scrollView.addSubview(tfeduOrg)
        tfeduOrg.translatesAutoresizingMaskIntoConstraints = false
        tfeduOrg.centerYAnchor.constraint(equalTo: lbleduOrg.centerYAnchor).isActive = true
        tfeduOrg.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfeduOrg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfeduOrg.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tfeduOrg.isHidden = true
        
        scrollView.addSubview(lblorderNum)
        lblorderNum.translatesAutoresizingMaskIntoConstraints = false
        
        lblorderNumTopAnchor = lblorderNum.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43)
        lblorderNumTopAnchor?.isActive = true
        lblorderNum.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblorderNum.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tforderNum)
        tforderNum.translatesAutoresizingMaskIntoConstraints = false
        tforderNum.centerYAnchor.constraint(equalTo: lblorderNum.centerYAnchor).isActive = true
        tforderNum.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tforderNum.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tforderNum.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //        tforderNum.isEditing = false
        let npnoa4ViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(npnoa4ViewClicked)) // show 수주번호 popup
        tforderNum.addGestureRecognizer(npnoa4ViewTap)
        
        scrollView.addSubview(lblcustomNm)
        lblcustomNm.translatesAutoresizingMaskIntoConstraints = false
        lblcustomNm.topAnchor.constraint(equalTo: lblorderNum.bottomAnchor, constant: 43).isActive = true
        lblcustomNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblcustomNm.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfcustomNm)
        tfcustomNm.translatesAutoresizingMaskIntoConstraints = false
        tfcustomNm.centerYAnchor.constraint(equalTo: lblcustomNm.centerYAnchor).isActive = true
        tfcustomNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfcustomNm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfcustomNm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblorderNm)
        lblorderNm.translatesAutoresizingMaskIntoConstraints = false
        lblorderNm.topAnchor.constraint(equalTo: lblcustomNm.bottomAnchor, constant: 43).isActive = true
        lblorderNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblorderNm.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tforderNm)
        tforderNm.translatesAutoresizingMaskIntoConstraints = false
        tforderNm.centerYAnchor.constraint(equalTo: lblorderNm.centerYAnchor).isActive = true
        tforderNm.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tforderNm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tforderNm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblreason)
        lblreason.translatesAutoresizingMaskIntoConstraints = false
        lblreason.topAnchor.constraint(equalTo: lblorderNm.bottomAnchor, constant: 43).isActive = true
        lblreason.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblreason.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfreason)
        tfreason.translatesAutoresizingMaskIntoConstraints = false
        tfreason.centerYAnchor.constraint(equalTo: lblreason.centerYAnchor).isActive = true
        tfreason.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfreason.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfreason.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblStartDate)
        lblStartDate.translatesAutoresizingMaskIntoConstraints = false
        lblStartDate.topAnchor.constraint(equalTo: lblreason.bottomAnchor, constant: 43).isActive = true
        lblStartDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblStartDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(startDateView)
        startDateView.translatesAutoresizingMaskIntoConstraints = false
        startDateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        startDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        startDateView.centerYAnchor.constraint(equalTo: lblStartDate.centerYAnchor).isActive = true
        startDateView.backgroundColor = .white
        startDateView.layer.borderWidth = 1
        startDateView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        startDateView.layer.cornerRadius = 8
        startDateView.isUserInteractionEnabled = true
        let startDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startDateViewClicked))
        startDateView.addGestureRecognizer(startDateViewTap)
        
        scrollView.addSubview(lblStartDateValue)
        lblStartDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblStartDateValue.centerYAnchor.constraint(equalTo: lblStartDate.centerYAnchor).isActive = true
        lblStartDateValue.leadingAnchor.constraint(equalTo: startDateView.leadingAnchor, constant: 15).isActive = true
        //        let formatter2 = DateFormatter()
        //        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        lblStartDateValue.text = formatter2.string(from: self.selectedStartDate)
        lblStartDateValue.text = "시작 일시를 선택하세요".localized
        
        scrollView.addSubview(endDateView)
        endDateView.translatesAutoresizingMaskIntoConstraints = false
        endDateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        endDateView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        endDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        endDateView.topAnchor.constraint(equalTo: startDateView.bottomAnchor, constant: 9).isActive = true
        endDateView.backgroundColor = .white
        endDateView.layer.borderWidth = 1
        endDateView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        endDateView.layer.cornerRadius = 8
        endDateView.isUserInteractionEnabled = true
        let endDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endDateViewClicked))
        endDateView.addGestureRecognizer(endDateViewTap)
        
        scrollView.addSubview(lblEndDateValue)
        lblEndDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblEndDateValue.centerYAnchor.constraint(equalTo: endDateView.centerYAnchor).isActive = true
        lblEndDateValue.leadingAnchor.constraint(equalTo: endDateView.leadingAnchor, constant: 15).isActive = true
        //        lblEndDateValue.text = formatter2.string(from: self.selectedEndDate)
        lblEndDateValue.text = "종료 일시를 선택하세요".localized
        
        scrollView.addSubview(lblHoliday)
        lblHoliday.translatesAutoresizingMaskIntoConstraints = false
        lblHoliday.topAnchor.constraint(equalTo: lblEndDateValue.bottomAnchor, constant: 43).isActive = true
        lblHoliday.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblHoliday.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblHoliday.isHidden = true
        
        
        scrollView.addSubview(lbldutyDays)
        lbldutyDays.translatesAutoresizingMaskIntoConstraints = false
        lblDutyDaysTopAnchor = lbldutyDays.topAnchor.constraint(equalTo: lblStartDate.bottomAnchor, constant: 108)
        lblDutyDaysTopAnchor?.isActive = true
        lbldutyDays.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldutyDays.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let dutyDaysView = UIView()
        scrollView.addSubview(dutyDaysView)
        dutyDaysView.translatesAutoresizingMaskIntoConstraints = false
        dutyDaysView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dutyDaysView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        dutyDaysView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        dutyDaysView.centerYAnchor.constraint(equalTo: lbldutyDays.centerYAnchor).isActive = true
        dutyDaysView.backgroundColor = .white
        dutyDaysView.layer.borderWidth = 1
        dutyDaysView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        dutyDaysView.layer.cornerRadius = 8
        
        scrollView.addSubview(lbldutyDaysValue)
        lbldutyDaysValue.translatesAutoresizingMaskIntoConstraints = false
        lbldutyDaysValue.centerYAnchor.constraint(equalTo: dutyDaysView.centerYAnchor).isActive = true
        lbldutyDaysValue.trailingAnchor.constraint(equalTo: dutyDaysView.trailingAnchor, constant: -16).isActive = true
        lbldutyDaysValue.text = "일".localized
        
        scrollView.addSubview(lblremark)
        lblremark.translatesAutoresizingMaskIntoConstraints = false
        lblremark.topAnchor.constraint(equalTo: lbldutyDays.bottomAnchor, constant: 43).isActive = true
        lblremark.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblremark.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfremark)
        tfremark.translatesAutoresizingMaskIntoConstraints = false
        tfremark.centerYAnchor.constraint(equalTo: lblremark.centerYAnchor).isActive = true
        tfremark.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        tfremark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfremark.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tfremark.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -300).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: tfremark.bottomAnchor, constant:33).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnDelete)
        stackView.addArrangedSubview(btnCancel)
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
        
        self.getCdatCode()
        self.getNationCode()
        self.getExitCode()
        setData()
        setView()
        self.getCheckerDetailInfo()
    }
    
    func setData() {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyyMMddHHmm"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm"
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "yyyyMMdd"
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd"
        
        if(checkerData != nil) {
            if let makeDate = checkerData?.makeDate {
                selectedMakeStartDate = formatter3.date(from: makeDate) ?? Date()
                lblmakeDateValue.text = formatter4.string(from: formatter3.date(from: makeDate) ?? Date())
                lblmakeDateValue.isUserInteractionEnabled = false
                makeDateViewTap?.isEnabled = false
            }
            tforderNum.text = checkerData?.orderNum
            tfcustomNm.text = checkerData?.custNm
            tforderNm.text = checkerData?.orderNm
            tfreason.text = checkerData?.reason
            tfeduOrg.text = checkerData?.eduOrg
            let dutyDays = String(checkerData?.dutyDays ?? 0.0) + "일".localized
            lbldutyDaysValue.text = dutyDays
            tfremark.text = checkerData?.remark
            
            beforeDutyCode = checkerData?.dutyCode ?? ""
            
            if let dt = checkerData?.startDate, let tm = checkerData?.startTime, !dt.isEmpty, !tm.isEmpty {
                self.selectedStartDate = formatter1.date(from: dt + tm)!
                if let selectedStartDate = self.selectedStartDate {
                    lblStartDateValue.text = formatter2.string(from: selectedStartDate)
                    lblStartDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    beforeStartDate = formatter3.string(from: selectedStartDate)
                }
            }
            if let dt = checkerData?.endDate, let tm = checkerData?.endTime, !dt.isEmpty, !tm.isEmpty {
                self.selectedEndDate = formatter1.date(from: dt + tm)!
                if let selectedEndDate = selectedEndDate {
                    lblEndDateValue.text = formatter2.string(from: selectedEndDate)
                    lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    beforeEndDate = formatter3.string(from: selectedEndDate)
                }
            }
            
            apprState = checkerData?.apprState ?? ""
            msgCd = checkerData?.msgCd ?? ""
            seq = Int(checkerData?.seq ?? 0)
            
        }else if checkerRefData != nil {
            if let makeDate = checkerRefData?.makeDate {
                selectedMakeStartDate = formatter3.date(from: makeDate) ?? Date()
                lblmakeDateValue.text = formatter4.string(from: formatter3.date(from: makeDate) ?? Date())
                lblmakeDateValue.isUserInteractionEnabled = false
                makeDateViewTap?.isEnabled = false
            }
            tforderNum.text = checkerRefData?.orderNum
            tfcustomNm.text = checkerRefData?.custNm
            tforderNm.text = checkerRefData?.orderNm
            tfreason.text = checkerRefData?.reason
            tfeduOrg.text = checkerRefData?.eduOrg
            let dutyDays = String(checkerRefData?.dutyDays ?? 0.0) + "일".localized
            lbldutyDaysValue.text = dutyDays
            tfremark.text = checkerRefData?.remark
            
            beforeDutyCode = checkerRefData?.dutyCode ?? ""
            
            if let dt = checkerRefData?.startDate,  let tm = checkerRefData?.startTime {
                self.selectedStartDate = formatter1.date(from: dt + tm)!
                if let selectedStartDate = selectedStartDate {
                    lblStartDateValue.text = formatter2.string(from: selectedStartDate)
                    lblStartDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    beforeStartDate = formatter3.string(from: selectedStartDate)
                }
            }
            if let dt = checkerRefData?.endDate,  let tm = checkerRefData?.endTime {
                self.selectedEndDate = formatter1.date(from: dt + tm)!
                if let selectedEndDate = selectedEndDate {
                    lblEndDateValue.text = formatter2.string(from: selectedEndDate)
                    lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    beforeEndDate = formatter3.string(from: selectedEndDate)
                }
            }
            refSeq = Int(checkerRefData?.seq ?? 0)
        }else {
            self.lblmakeDateValue.text = formatter4.string(from: self.selectedMakeStartDate)
        }
    }
    
    var isDraft = false
    var isDraftCancel = false
    var isApprovalCancel = false
    
    func setView() {
        if(checkerData != nil) {
            if((apprState == "000" && msgCd == "") || apprState == "120") {
                isDraft = true
                btnDraft.setTitle("상신".localized, for: .normal)
                btnDraft.setEnable()
                btnApprovalList.setEnable()
            } else if (apprState == "100") {
                isDraftCancel = true
                btnDraft.setTitle("상신취소".localized, for: .normal)
                btnDraft.setEnable()
                btnApprovalList.setDisable()
            } else if (apprState == "130" && modifiedYn != "Y" && (dutyCode == "61" || dutyCode == "64")) {
                isApprovalCancel = true
                btnDraft.setTitle("결재취소".localized, for: .normal)
                btnDraft.setEnable()
                
                btnEdit.isHidden = false
                btnDeleteApprovalTopAnchor?.isActive = false
                btnDeleteApprovalTopAnchor =  btnApprovalDelete.topAnchor.constraint(equalTo: btnEdit.bottomAnchor, constant: 16)
                btnDeleteApprovalTopAnchor?.isActive = true
            } else if (apprState == "130" && modifiedYn != "Y") {
                isApprovalCancel = true
                btnDraft.setTitle("결재취소".localized, for: .normal)
                btnDraft.setEnable()
                btnApprovalList.setEnable()
            }
            
            if ((apprState == "000" && erpStatus != "" && !erpStatus.isEmpty) ||
                (apprState != "000" && apprState != "120" && apprState != "130" && apprState != "330") ||
                (apprState == "130" && erpStatus == "승인".localized)) {
                btnDelete.setDisable()
            }
            
            //            if (checkerData?.apprStateNm == "결재완료".localized || checkerData?.apprStateNm == "상신".localized) {
            //                btnSave.setDisable()
            //            }
            if !((apprState == "000" && msgCd == "") || apprState == "120") {
                btnSave.setDisable()
            }
            
            if self.isClose && dutyCode != "26" {
                self.btnApprovalList.setDisable()
                self.btnDraft.setDisable()
                self.btnApprovalDelete.setDisable()
                self.btnSave.setDisable()
                self.btnDelete.setDisable()
            }
            
            if let mc = checkerData?.msgCd {
                getApprovalLine(msgCd: mc)
            }else {
                setApprovalHeight()
            }
        }else {
            btnDelete.setDisable()
            cvApproval.isHidden = true
            cvApprovalHeightAnchor?.isActive = false
            cvApprovalHeightAnchor = cvApproval.heightAnchor.constraint(equalToConstant: 0)
            cvApprovalHeightAnchor?.isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("CheckerAddViewController viewWillAppear approveList : \(approveList)")
        cvApprove.reloadData()
        setApprovalHeight()
    }
    
    @objc func npnoa4ViewClicked(){
        let vc = CheckerOrderViewController()
        vc.previousViewController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    func getOrderListFromPopup(checkerOrderListItem:CheckerOrderListDetailResponse){
        self.tforderNum.text = checkerOrderListItem.orderNum
        self.tfcustomNm.text = checkerOrderListItem.customNm
        self.tforderNm.text = checkerOrderListItem.orderNm
    }
    
    //근태코드
    func getCdatCode(){
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HT016_ATS")), success: { (response: ApiResponse<CodeListResponse>) in
            if let result = response.value {
                if let list = result.data {
                    self.cdatList.removeAll()
                    self.cdatList.append("근태코드를 선택하세요".localized)
                    self.getCdatList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getCdatList.indices {
                            self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                        }
                    }
                    for item in self.getCdatList {
                        self.cdatList.append(item.subNm ?? "")
                    }
                    self.updateCdatDropDown()
                }
            }
        }) { (error) in
        }
    }
    func updateCdatDropDown(){
        cdatDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cdatDropDown.name = "cdatDropDown"
        if(self.checkerData != nil) {
            for item in getCdatList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerData?.dutyCode) {
                        cdatDropDown.stTitle = item.subNm!
                        self.dutyCode = item.subCd!
                        self.isPass = true
                        dropDownPressed(name: "cdatDropDown", string: item.subNm!)
                        
                        
                        if(checkerData != nil && checkerData?.dutyCode == "53") {
                            if !checkGetMHoliday(startDate: checkerData?.startDate ?? "", isFirst: true) {
                                self.holidayList.removeAll()
                                self.holidayList.append("명절대체근무일자를 선택하세요".localized)
                                
                                holidayDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                                holidayDropDown.name = "holidayDropDown"
                                if let useDate = checkerData?.useDate {
                                    let ud = useDate.replacingOccurrences(of: "-", with: "")
                                    self.holidayList.append(ud)
                                    holidayDropDown.stTitle = ud
                                    holidayDropDown.lblTitle.textColor = .black
                                    selectedHoliday = ud
                                }
                                holidayDropDown.delegate = self
                                holidayDropDown.dropView.dropDownOptions = self.holidayList
                                
                                scrollView.addSubview(holidayDropDown)
                                holidayDropDown.translatesAutoresizingMaskIntoConstraints = false
                                holidayDropDown.centerYAnchor.constraint(equalTo: lblHoliday.centerYAnchor).isActive = true
                                holidayDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
                                holidayDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
                                holidayDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
                                holidayDropDown.isHidden = true
                                
                                showHoliday()
                            }
                        }
                    }
                }
            }
        }else if(self.checkerRefData != nil) {
            for item in getCdatList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerRefData?.dutyCode) {
                        cdatDropDown.stTitle = item.subNm!
                        self.dutyCode = item.subCd!
                        self.isPass = true
                        dropDownPressed(name: "cdatDropDown", string: item.subNm!)
                    }
                }
            }
        }else {
            cdatDropDown.stTitle = cdatList[0]
            cdatDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        cdatDropDown.delegate = self
        cdatDropDown.dropView.dropDownOptions = self.cdatList
        
        scrollView.addSubview(cdatDropDown)
        cdatDropDown.translatesAutoresizingMaskIntoConstraints = false
        cdatDropDown.centerYAnchor.constraint(equalTo: lblCdat.centerYAnchor).isActive = true
        cdatDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        cdatDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdatDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //사업부문
    func getCheckerDetailInfo(){
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyyMMdd"
        let startDate = formatter1.string(from: selectedMakeStartDate)
        ApiService.request(router: CheckerApi.detailInfo(
            param: CheckerDetailInfoRequest(
                startDate: startDate
            )), success: { (response: ApiResponse<CheckerDetailInfoResponse>) in
            if let result = response.value {
                if let data = result.data {
                    self.isClose = data.isClose ?? false
                    if self.isClose {
                        self.btnApprovalList.setDisable()
                        self.btnDraft.setDisable()
                        self.btnApprovalDelete.setDisable()
                        self.btnSave.setDisable()
                        self.btnDelete.setDisable()
                    }
                    self.defaultDivCd = data.defaultDivCd ?? ""
                    if let list = data.list{
                        self.divCdParamList.removeAll()
                        self.divCdParamList.append("사업부문을 선택하세요".localized)
                        self.getdivCdParamList = list
                        for item in list {
                            self.divCdParamList.append(item.divNm ?? "")
                        }
                        self.updateDivCdDropDown()
                    }
                }
            }
        }) { (error) in
        }
    }
    func updateDivCdDropDown(){
        divCdParamDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divCdParamDropDown.name = "divCdParamDropDown"
        if(self.checkerData != nil) {
            for item in getdivCdParamList {
                if let subCd = item.divCd {
                    if(subCd == self.checkerData?.divCd) {
                        divCdParamDropDown.stTitle = item.divNm!
                        self.selectedDivCd = item.divCd!
                    }
                }
            }
            divCdParamDropDown.isUserInteractionEnabled = false
        }else if(self.checkerRefData != nil) {
            for item in getdivCdParamList {
                if let subCd = item.divCd {
                    if(subCd == self.checkerRefData?.divCd) {
                        divCdParamDropDown.stTitle = item.divNm!
                        self.selectedDivCd = item.divCd!
                    }
                }
            }
        }else {
            for item in getdivCdParamList {
                if let subCd = item.divCd {
                    if(subCd == self.defaultDivCd ) {
                        divCdParamDropDown.stTitle = item.divNm!
                        self.selectedDivCd = item.divCd!
                    }
                }
            }
        }
        
        divCdParamDropDown.delegate = self
        divCdParamDropDown.dropView.dropDownOptions = self.divCdParamList
        
        scrollView.addSubview(divCdParamDropDown)
        divCdParamDropDown.translatesAutoresizingMaskIntoConstraints = false
        divCdParamDropDown.centerYAnchor.constraint(equalTo: lbldivCdParam.centerYAnchor).isActive = true
        divCdParamDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        divCdParamDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divCdParamDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var isNationLoad = false
    var isExitLoad = false
    // 국가코드
    func getNationCode(){
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "B00008")), success: { (response: ApiResponse<CodeListResponse>) in
            if let result = response.value {
                if let list = result.data {
                    self.nationList.removeAll()
                    self.nationList.append("국가코드를 선택하세요".localized)
                    self.getNationList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getNationList.indices {
                            self.getNationList[index].subNm = self.getNationList[index].jpnSubNm
                        }
                    }
                    for item in self.getNationList {
                        self.nationList.append(item.subNm ?? "")
                    }
                    self.updateNationDropDown()
                    self.isNationLoad = true
                    
                    if(self.isNationLoad && self.isExitLoad) {
                        if self.dutyCode == "63" || self.dutyCode == "64" {
                            self.showNationCd()
                            if self.dutyCode == "64" {
                                self.showEduOrg()
                            }
                        }
                    }
                }
            }
        }) { (error) in
        }
    }
    func updateNationDropDown(){
        nationDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nationDropDown.name = "nationDropDown"
        if(self.checkerData != nil) {
            for item in getNationList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerData?.nationCd) {
                        nationDropDown.stTitle = item.subNm!
                        selectedNationCd = item.subCd!
                    }
                }
            }
        }else if(self.checkerRefData != nil) {
            for item in getNationList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerRefData?.nationCd) {
                        nationDropDown.stTitle = item.subNm!
                        selectedNationCd = item.subCd!
                    }
                }
            }
        }else {
            nationDropDown.stTitle = nationList[0]
            nationDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        nationDropDown.delegate = self
        nationDropDown.dropView.dropDownOptions = self.nationList
        
        scrollView.addSubview(nationDropDown)
        nationDropDown.translatesAutoresizingMaskIntoConstraints = false
        nationDropDown.centerYAnchor.constraint(equalTo: lblnationCd.centerYAnchor).isActive = true
        nationDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        nationDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        nationDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nationDropDown.isHidden = true
    }
    
    //출국구분
    func getExitCode(){
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "p99")), success: { (response: ApiResponse<CodeListResponse>) in
            if let result = response.value {
                if let list = result.data {
                    self.exitList.removeAll()
                    self.exitList.append("출국구분을 선택하세요".localized)
                    self.getExitList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getExitList.indices {
                            self.getExitList[index].subNm = self.getExitList[index].jpnSubNm
                        }
                    }
                    for item in self.getExitList {
                        self.exitList.append(item.subNm ?? "")
                    }
                    self.updateExitDropDown()
                    self.isExitLoad = true
                    
                    if(self.isNationLoad && self.isExitLoad) {
                        if self.dutyCode == "63" || self.dutyCode == "64" {
                            self.showNationCd()
                            if self.dutyCode == "64" {
                                self.showEduOrg()
                            }
                        }
                    }
                }
            }
        }) { (error) in
        }
    }
    func updateExitDropDown(){
        exitDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        exitDropDown.name = "exitDropDown"
        if(self.checkerData != nil) {
            for item in getExitList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerData?.exitCd) {
                        exitDropDown.stTitle = item.subNm!
                        selectedExitCd = item.subCd!
                    }
                }
            }
        }else if(self.checkerRefData != nil) {
            for item in getExitList {
                if let subCd = item.subCd {
                    if(subCd == self.checkerRefData?.exitCd) {
                        exitDropDown.stTitle = item.subNm!
                        selectedExitCd = item.subCd!
                    }
                }
            }
        }else {
            exitDropDown.stTitle = exitList[0]
            exitDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        exitDropDown.delegate = self
        exitDropDown.dropView.dropDownOptions = self.exitList
        
        scrollView.addSubview(exitDropDown)
        exitDropDown.translatesAutoresizingMaskIntoConstraints = false
        exitDropDown.centerYAnchor.constraint(equalTo: lblexitCd.centerYAnchor).isActive = true
        exitDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        exitDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        exitDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        exitDropDown.isHidden = true
    }
    
    var isPass = false
    func dropDownPressed(name: String, string: String) {
        if name == "cdatDropDown" {
            if !isPass {
                isPass = false
                var dc = ""
                for item in getCdatList {
                    if item.subNm == string {
                        dc = item.subCd ?? ""
                        break
                    }
                }
                if !self.check(dutyCode: dc) {
                    dutyCode = beforeDutyCode
                    cdatDropDown.stTitle = cdatList[0]
                    cdatDropDown.lblTitle.text = cdatList[0]
                    cdatDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                    for item in getCdatList {
                        if let subCd = item.subCd {
                            if(subCd == dutyCode) {
                                cdatDropDown.stTitle = item.subNm!
                                cdatDropDown.lblTitle.text = item.subNm!
                                cdatDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                                break
                            }
                        }
                    }
                    return
                }
            }
            
            cdatDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            
            dutyCode = ""
            for item in getCdatList {
                if item.subNm == string {
                    dutyCode = item.subCd ?? ""
                    cdatDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                }
            }
            
            hideNationCd()
            hideEduOrg()
            hideHoliday()
            tforderNum.isUserInteractionEnabled = true
            startDateView.isUserInteractionEnabled = true
            startDateView.backgroundColor = .white
            endDateView.isUserInteractionEnabled = true
            endDateView.backgroundColor = .white
            
            if dutyCode == "63" {
                showNationCd()
                return
            }
            if dutyCode == "64" {
                showNationCd()
                showEduOrg()
                return
            }
//            if dutyCode == "53" {
//                showHoliday()
//                return
//            }
            
            if dutyCode == "91" || dutyCode == "94" || dutyCode == "95" {
                tforderNum.isUserInteractionEnabled = false
            }
            if dutyCode == "17" {
                lblEndDateValue.text = ""
                selectedEndDate = Date()
                endDateView.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                endDateView.isUserInteractionEnabled = false
            }
            if dutyCode == "18" {
                lblStartDateValue.text = ""
                selectedStartDate = Date()
                startDateView.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                startDateView.isUserInteractionEnabled = false
            }
            if dutyCode == "94" || dutyCode == "95" {
                endDateView.isUserInteractionEnabled = false
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyy-MM-dd"
                if(dutyCode == "94") {
                    if let selectedStartDate = self.selectedStartDate {
                        self.selectedEndDate = self.selectedStartDate
                        lblStartDateValue.text = formatter1.string(from: selectedStartDate) + " 08:30"
                        lblEndDateValue.text = formatter1.string(from: selectedStartDate) + " 12:00"
                        lbldutyDaysValue.text = "0.44" + "일".localized
                    }
                }else {
                    if let selectedStartDate = self.selectedStartDate {
                        self.selectedEndDate = self.selectedStartDate
                        lblStartDateValue.text = formatter1.string(from: selectedStartDate) + " 13:00"
                        lblEndDateValue.text = formatter1.string(from: selectedStartDate) + " 17:30"
                        lbldutyDaysValue.text = "0.56" + "일".localized
                    }
                }
            }
            
            if dutyCode == "19" || dutyCode == "26" || dutyCode == "53" {
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyy-MM-dd HH:mm"
                if let selectedStartDate = self.selectedStartDate {
                    self.lblEndDateValue.text = formatter1.string(from: selectedStartDate)
                }
            }
        }else if name == "divCdParamDropDown" {
            divCdParamDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getdivCdParamList {
                if item.divNm == string {
                    divCdParamDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    selectedDivCd = item.divCd ?? ""
                }
            }
        } else if name == "nationDropDown" {
            nationDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getNationList {
                if item.subNm == string {
                    nationDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    selectedNationCd = item.subCd ?? ""
                }
            }
        } else if name == "exitDropDown" {
            exitDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getExitList {
                if item.subNm == string {
                    exitDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    selectedExitCd = item.subCd ?? ""
                }
            }
        } else if name == "holidayDropDown" {
            holidayDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getHolidayList {
                if item.date01 == string {
                    holidayDropDown.lblTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                    selectedHoliday = item.date01 ?? ""
                }
            }
        }
    }
    
    func showNationCd(){
        lblnationCd.isHidden = false
        nationDropDown.isHidden = false
        lblexitCd.isHidden = false
        exitDropDown.isHidden = false
        
        lblorderNumTopAnchor?.isActive = false
        lblorderNumTopAnchor = lblorderNum.topAnchor.constraint(equalTo: lblexitCd.bottomAnchor, constant: 43)
        lblorderNumTopAnchor?.isActive = true
    }
    
    func hideNationCd(){
        lblnationCd.isHidden = true
        nationDropDown.isHidden = true
        lblexitCd.isHidden = true
        exitDropDown.isHidden = true
        
        lblorderNumTopAnchor?.isActive = false
        lblorderNumTopAnchor = lblorderNum.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43)
        lblorderNumTopAnchor?.isActive = true
    }
    
    func showEduOrg(){
        lbleduOrg.isHidden = false
        tfeduOrg.isHidden = false
        
        lbleduOrgTopAnchor?.isActive = false
        lbleduOrgTopAnchor = lbleduOrg.topAnchor.constraint(equalTo: lblexitCd.bottomAnchor, constant: 43)
        lbleduOrgTopAnchor?.isActive = true
        
        lblorderNumTopAnchor?.isActive = false
        lblorderNumTopAnchor = lblorderNum.topAnchor.constraint(equalTo: lbleduOrg.bottomAnchor, constant: 43)
        lblorderNumTopAnchor?.isActive = true
    }
    
    func hideEduOrg(){
        lbleduOrgTopAnchor?.isActive = false
        lbleduOrgTopAnchor = lbleduOrg.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43)
        lbleduOrgTopAnchor?.isActive = true
        
        lbleduOrg.isHidden = true
        tfeduOrg.isHidden = true
        lblorderNumTopAnchor?.isActive = false
        lblorderNumTopAnchor = lblorderNum.topAnchor.constraint(equalTo: lbldivCdParam.bottomAnchor, constant: 43)
        lblorderNumTopAnchor?.isActive = true
    }
    
    func showHoliday(){
        lblHoliday.isHidden = false
        holidayDropDown.isHidden = false
        
        lblDutyDaysTopAnchor?.isActive = false
        lblDutyDaysTopAnchor = lbldutyDays.topAnchor.constraint(equalTo: lblHoliday.bottomAnchor, constant: 43)
        lblDutyDaysTopAnchor?.isActive = true
    }
    
    func hideHoliday(){
        lblDutyDaysTopAnchor?.isActive = false
        lblDutyDaysTopAnchor = lbldutyDays.topAnchor.constraint(equalTo: lblStartDate.bottomAnchor, constant: 108)
        lblDutyDaysTopAnchor?.isActive = true

        
        lblHoliday.isHidden = true
        holidayDropDown.isHidden = true
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
    func setApprovalHeight() {
        if(checkerData != nil) {
            let innerH = 16 + ([(approveList.count * 40), 40].max() ?? 40)
            
            var outerH = 130
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
            if !btnEdit.isHidden {
                outerH += Int(btnEdit.intrinsicContentSize.height)
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
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyyMMdd"
        var dutyDay = ""
        if let selectedStartDate = self.selectedStartDate {
            dutyDay = formatter1.string(from: selectedStartDate)
        }else if let selectedEndDate = self.selectedEndDate {
            dutyDay = formatter1.string(from: selectedEndDate)
        }
        
        var title = ""
        var router:CheckerApi?
        if isDraft {
            if approvalId.isEmpty {
                let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            title = "상신 되었습니다".localized
            router = CheckerApi.draft(param: CheckerDraftRequest(
                seq: String(seq ?? 0),
                dutyCode: dutyCode,
                divCdParam: selectedDivCd,
                dutyDay: dutyDay,
                approvalId: approvalId,
                refSeq: (refSeq == nil ? "" : String(refSeq!))
            ))
        }else if isDraftCancel {
            title = "상신취소 되었습니다".localized
            router = CheckerApi.draftCancel(param: CheckerDraftCancelRequest(
                msgCd: msgCd
            ))
        }else if isApprovalCancel {
            if approvalId.isEmpty {
                let alert  = UIAlertController(title: "알림".localized, message: "승인자를 지정하세요".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            title = "결재취소 상신 되었습니다".localized
            router = CheckerApi.approvalCancel(param: CheckerApprovalCancelRequest(
                seq: String(seq ?? 0),
                dutyCode: dutyCode,
                divCdParam: selectedDivCd,
                dutyDay: dutyDay,
                approvalId: approvalId
            ))
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if let rot = router {
            ApiService.request(router: rot, success: { (response: ApiResponse<CheckerDetailInfoResponse>) in
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
        btnApprovalDelete.setDisable()
    }
    
    @objc func btnEditClicked() {
        guard let pvc = self.presentingViewController else { return }
        self.dismiss(animated: true) {
            if let getVc = self.util.getViewControllerFromText(label: "확인원 등록 상세".localized) {
                if let getVc2 = getVc as? CheckerAddViewController {
                    getVc2.checkerRefData = self.checkerData
                    getVc2.modalPresentationStyle = .fullScreen
                    pvc.present(getVc2, animated: true, completion: nil)
                }
            }
        }
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    var beforeDutyCode = ""
    var beforeStartDate = ""
    var beforeEndDate = ""
    var yyyymmddFormatter = DateFormatter()
    
    func check(dutyCode: String? = nil, startDate: String? = nil, endDate: String? = nil) -> Bool {
        yyyymmddFormatter.dateFormat = "yyyyMMdd"
        
        let md = yyyymmddFormatter.string(from: self.selectedMakeStartDate)
        let dc = dutyCode ?? self.dutyCode
        let sd = startDate ?? beforeStartDate
        let ed = endDate ?? beforeEndDate
        let osd = beforeStartDate
        let oed = beforeEndDate
        
        if !sd.isEmpty && !ed.isEmpty {
            if sd.left(8) != ed.left(8) {
                if dc == "19" {
                    let alert  = UIAlertController(title: "알림".localized, message: "직출직퇴는 2일 이상 입력할 수 없습니다. 2일 이상 입력시 나눠서 입력하십시요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                if dc == "26" {
                    let alert  = UIAlertController(title: "알림".localized, message: "명절대체휴가신청은 2일 이상 입력할 수 없습니다. 2일 이상 입력시 나눠서 입력하십시요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
            }
            if sd.left(6) != ed.left(6) {
                let alert  = UIAlertController(title: "알림".localized, message: "기간은 월단위로만 등록이 가능합니다. 시작월과 종료월이 다른 경우 각각 신청해주시기 바랍니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            if sd.left(8) > ed.left(8) {
                let alert  = UIAlertController(title: "알림".localized, message: "종료일시가 시작일시보다 빠릅니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        
        if (dc != "18" && !sd.isEmpty && !ed.isEmpty) || (dc == "17" && !sd.isEmpty) || (dc == "18" && !ed.isEmpty) {
            if !checkDup(dutyCode: dc, startDate: sd, endDate: (dc == "18" ? md : ed), orgStartDate: osd, orgEndDate: oed) {
                return false
            }
        }
        
        if (dc == "17" && !sd.isEmpty) || (dc == "18" && !ed.isEmpty) || (dc == "19" && !sd.isEmpty) {
            if !checkAttendanceRead(dutyCode: dc, dutyDay: (dc == "18" ? md : sd)) {
                return false
            }
        }
        
        if !sd.isEmpty {
            if !checkWorkReportList(dutyCode: dc, dutyDay: sd) {
                return false
            }
            if !checkCalendarRead(dutyCode: dc, dutyDay: sd) {
                return false
            }
        }
        if dc == "26" && !sd.isEmpty {
            if !checkCalendarHolidayM(startDate: sd, endDate: ed) {
                return false
            }
            if !checkCheckWorkTime(startDate: sd) {
                return false
            }
        }
        if dc == "53" && !sd.isEmpty {
            if !checkGetMHoliday(startDate: sd) {
                return false
            }
        }
        if (dc == "91" || dc == "94" || dc == "95") && !sd.isEmpty && !ed.isEmpty {
            if !checkGetHoliday(startDate: sd) {
                return false
            }
        }
        if dc == "51" && !sd.isEmpty && !ed.isEmpty {
            if !checkGetYearHoliday(startDate: sd) {
                return false
            }
        }
        
        if let dc = dutyCode {
            beforeDutyCode = dc
        }
        if let sd = startDate {
            beforeStartDate = sd
        }
        if let ed = endDate {
            beforeEndDate = ed
        }
        return true
    }
    
    func checkDup(dutyCode: String, startDate: String, endDate: String, orgStartDate: String, orgEndDate: String) -> Bool {
        var isOk = false
        let parameters:[String : Any] = [
            "dutyCode": dutyCode,
            "startDate": startDate,
            "endDate": endDate,
            "orgStartDate": orgStartDate,
            "orgEndDate": orgEndDate
        ]
        let jsonString = requestSync(url: "checkDup", parameters: parameters)
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerCheckDupResponse.self, from: data)
                if res.data == nil {
                    isOk = true
                }else {
                    let alert  = UIAlertController(title: "알림".localized, message: "확인원 내역이 존재합니다. 확인 후 다시 작성해주시기 바랍니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                
            }
        }
        return isOk
    }
    func checkAttendanceRead(dutyCode: String, dutyDay: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "dutyDay": dutyDay
        ]
        let jsonString = requestSync(url: "attendanceRead", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerAttendanceReadResponse.self, from: result)
                
                if let data = res.data {
                    if dutyCode == "18", let leaveTime = data.leaveTime, !leaveTime.isEmpty {
                        let alert  = UIAlertController(title: "알림".localized, message: "해당일자 퇴근기록이 존재합니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        isOk = false
                    }
                    if dutyCode == "18", (data.comeTime == nil || data.comeTime!.isEmpty) {
                        let alert  = UIAlertController(title: "알림".localized, message: "해당일자 출근기록이 없습니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        isOk = false
                    }
                    if dutyCode == "17", let comeTime = data.comeTime, !comeTime.isEmpty {
                        let alert  = UIAlertController(title: "알림".localized, message: "해당일자 출근기록이 존재합니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        isOk = false
                    }
                }
            } catch {
                
            }
        }
        return isOk
    }
    func checkWorkReportList(dutyCode: String, dutyDay: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "dutyDay": dutyDay
        ]
        let jsonString = requestSync(url: "workReportList", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerWorkReportListResponse.self, from: result)
                
                if dutyCode != "26", let data = res.data, data.count > 0 {
                    let alert  = UIAlertController(title: "알림".localized, message: "업무일지가 있어서 입력 할 수 없습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    func checkCalendarRead(dutyCode: String, dutyDay: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "dutyDay": dutyDay
        ]
        let jsonString = requestSync(url: "calendarRead", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerCalendarReadResponse.self, from: result)
                
                if res.data == nil {
                    let alert  = UIAlertController(title: "알림".localized, message: "해당 일자의 근무 Calender가 없습니다. 인사담당자에게 확인하시기 바랍니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    func checkCalendarHolidayM(startDate: String, endDate: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "startDate": startDate,
            "endDate": endDate,
        ]
        let jsonString = requestSync(url: "checkHolidayM", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerCalendarHolidayMResponse.self, from: result)
                
                if let data = res.data, data[0].cnt == 0 {
                    let alert  = UIAlertController(title: "알림".localized, message: "명절대체휴가신청은 명절만 등록 가능합니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    func checkCheckWorkTime(startDate: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "startDate": startDate
        ]
        let jsonString = requestSync(url: "checkWorkTime", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerCheckWorkTimeResponse.self, from: result)
                
                if let data = res.data, (data.count == 0 || data[0].gTime == nil) {
                    let alert  = UIAlertController(title: "알림".localized, message: "해당 일자에 근무 시간이 입력되지 않았습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
                if let data = res.data, data.count > 0, Int(data[0].gTime ?? "0") ?? 0 < 1200 {
                    let alert  = UIAlertController(title: "알림".localized, message: "해당일 근무시간이 8시간 이상이어야 합니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    
    func checkGetHoliday(startDate: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "startDate": startDate
        ]
        let jsonString = requestSync(url: "getHoliday", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerGetHolidayResponse.self, from: result)
                
                if res.data == nil || res.data!.count == 0 {
                    let alert  = UIAlertController(title: "알림".localized, message: "사용 가능한 휴가가 없습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    
    func checkGetYearHoliday(startDate: String) -> Bool {
        var isOk = true
        let parameters:[String : Any] = [
            "startDate": startDate
        ]
        let jsonString = requestSync(url: "getYearHoliday", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerGetYearHolidayResponse.self, from: result)
                
                if res.data == nil || res.data!.count == 0 || res.data![0].cnps96 == 0 {
                    let alert  = UIAlertController(title: "알림".localized, message: "사용 가능한 근속휴가가 없습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    isOk = false
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    
    func checkGetMHoliday(startDate: String, isFirst: Bool = false) -> Bool {
        var isOk = true
        
        var sd = ""
        let yyyymmddFormatter = DateFormatter()
        yyyymmddFormatter.dateFormat = "yyyyMMdd"
        if let ssd = yyyymmddFormatter.date(from: startDate) {
            let d = Calendar.current.date(byAdding: .month, value: -2, to: ssd)
            let y =  Calendar.current.dateComponents([.year], from: d!)
            let m =  Calendar.current.dateComponents([.month], from: d!)
            let dateComponents = DateComponents(year: y.year!, month: m.month!, day: 1)
            let dsd = Calendar.current.date(from: dateComponents)
            sd = yyyymmddFormatter.string(from: dsd!)
        }
        let parameters:[String : Any] = [
            "startDate": sd,
            "endDate": startDate
        ]
        let jsonString = requestSync(url: "getMHoliday", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerGetMHolidayResponse.self, from: result)
                
                if res.data == nil || res.data!.count == 0 {
                    if(!isFirst) {
                        let alert  = UIAlertController(title: "알림".localized, message: "사용 가능한 명절대체휴가가 없습니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    isOk = false
                }else {
                    if let list = res.data {
                        self.holidayList.removeAll()
                        self.holidayList.append("명절대체근무일자를 선택하세요".localized)
                        self.getHolidayList = list
                        for item in self.getHolidayList {
                            self.holidayList.append(item.date01 ?? "")
                        }
                        
                        holidayDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                        holidayDropDown.name = "holidayDropDown"
                        if(self.checkerData != nil) {
                            if let useDate = checkerData?.useDate {
                                self.holidayList.append(useDate)
                                holidayDropDown.stTitle = useDate
                                holidayDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                            }
                        }else {
                            holidayDropDown.stTitle = holidayList[0]
                            holidayDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                        }
                        
                        holidayDropDown.delegate = self
                        holidayDropDown.dropView.dropDownOptions = self.holidayList
                        
                        scrollView.addSubview(holidayDropDown)
                        holidayDropDown.translatesAutoresizingMaskIntoConstraints = false
                        holidayDropDown.centerYAnchor.constraint(equalTo: lblHoliday.centerYAnchor).isActive = true
                        holidayDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
                        holidayDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
                        holidayDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
                        holidayDropDown.isHidden = true
                        
                        showHoliday()
                    }
                }
            } catch {
                print("parsing error")
            }
        }
        return isOk
    }
    
    func checkDayCount(startDate: String, endDate: String) -> Int {
        var rsCnt = 0
        let parameters:[String : Any] = [
            "startDate": startDate,
            "endDate": endDate
        ]
        let jsonString = requestSync(url: "dayCount", parameters: parameters)
        
        if let result = jsonString.data(using: .utf8) {
            do {
                let res = try JSONDecoder().decode(CheckerDayCountResponse.self, from: result)
                
                if let data = res.data, data.count > 0 {
                    rsCnt = data[0].rsCnt ?? 0
                }
            } catch {
                print("parsing error")
            }
        }
        return rsCnt
    }
    
    func requestSync(url: String, parameters: [String : Any]) -> String {
        print("requestSync url : \(url), parameters : \(parameters)")
        var returnStr:String! = ""
        let urlString = "\(Environment.BASE_URL)/checker/\(url)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(Environment.AUTHORIZATOIN, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                self.semaphore.signal()
                print(error.localizedDescription)
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    self.semaphore.signal()
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    self.semaphore.signal()
                    return
                }
                
                returnStr = String(data: data!, encoding: .utf8)
                print("returnStr : \(returnStr)")
                
                self.semaphore.signal()
            }
            task.resume()
        }
        semaphore.wait()
        return returnStr
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func makeDateViewClicked(){
        let timePicker = UIDatePicker()
        timePicker.setDate(self.selectedMakeStartDate, animated: false)
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.datePickerMode = .date
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        //        timePicker.minuteInterval = 30
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        //        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            self.lblmakeDateValue.text = formatter1.string(from: self.selectedMakeStartDate)
            self.getCheckerDetailInfo()
            self.lblmakeDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
            
        })
        timePicker.addTarget(self, action: #selector(makeTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func makeTimeDiveChanged(sender: UIDatePicker) {
        selectedMakeStartDate = sender.date
    }
    
    @objc func startDateViewClicked(){
        let timePicker = UIDatePicker()
        if let selectedStartDate = self.selectedStartDate {
            timePicker.setDate(selectedStartDate, animated: false)
        }else {
            self.selectedStartDate = Date()
            timePicker.setDate(Date(), animated: false)
        }
        timePicker.minuteInterval = 10
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        if dutyCode == "26" || dutyCode == "51" || dutyCode == "61" || dutyCode == "63" || dutyCode == "65" || dutyCode == "91" || dutyCode == "94" || dutyCode == "95"{
            timePicker.datePickerMode = .date
        }else {
            timePicker.datePickerMode = .dateAndTime
        }
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        //        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let yyyymmddFormatter = DateFormatter()
            yyyymmddFormatter.dateFormat = "yyyyMMdd"
            if(!self.check(startDate: yyyymmddFormatter.string(from: self.selectedStartDate!))) {
                self.selectedStartDate = self.beforeStartDate.isEmpty ? nil : yyyymmddFormatter.date(from: self.beforeStartDate)
                return
            }
            
            let formatter1 = DateFormatter()
            let dutyCode = self.dutyCode
            if dutyCode == "26" || dutyCode == "51" || dutyCode == "61" || dutyCode == "63" || dutyCode == "65" || dutyCode == "91"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 08:30"
                if let selectedEndDate = self.selectedEndDate {
                    self.lblEndDateValue.text = formatter1.string(from: selectedEndDate) + " 17:30"
                }
            }else if dutyCode == "54"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 10:30"
                if let selectedEndDate = self.selectedEndDate {
                    self.lblEndDateValue.text = formatter1.string(from: selectedEndDate) + " 17:30"
                }
            }else if dutyCode == "94"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 08:30"
                self.selectedEndDate = self.selectedStartDate
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 12:00"
                self.lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                self.lbldutyDaysValue.text = "0.44" + "일".localized
            }else if dutyCode == "95"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 13:00"
                self.selectedEndDate = self.selectedStartDate
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 17:30"
                self.lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                self.lbldutyDaysValue.text = "0.56" + "일".localized
            }else {
                formatter1.dateFormat = "yyyy-MM-dd HH:mm"
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!)
            }
            if dutyCode == "19" || dutyCode == "26" || dutyCode == "53" {
                formatter1.dateFormat = "yyyy-MM-dd HH:mm"
                self.selectedEndDate = self.selectedStartDate
                self.lblEndDateValue.text = formatter1.string(from: self.selectedStartDate!)
                self.lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            }
            self.calculateDudyDays()
            self.lblStartDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
        })
        timePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        selectedStartDate = sender.date
    }
    
    @objc func endDateViewClicked(){
        let timePicker = UIDatePicker()
        if let selectedEndDate = self.selectedEndDate {
            timePicker.setDate(selectedEndDate, animated: false)
        }else {
            self.selectedEndDate = Date()
            timePicker.setDate(Date(), animated: false)
        }
        //        timePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        if dutyCode == "26" || dutyCode == "51" || dutyCode == "61" || dutyCode == "63" || dutyCode == "65" || dutyCode == "91" || dutyCode == "94" || dutyCode == "95"{
            timePicker.datePickerMode = .date
        }else {
            timePicker.datePickerMode = .dateAndTime
        }
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        //        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyyMMdd"
            if !self.check(endDate: formatter1.string(from: self.selectedEndDate!)) {
                self.selectedEndDate = self.beforeEndDate.isEmpty ? nil : formatter1.date(from: self.beforeEndDate)
                return
            }
            
            let dutyCode = self.dutyCode
            if dutyCode == "26" || dutyCode == "51" || dutyCode == "61" || dutyCode == "63" || dutyCode == "65" || dutyCode == "91"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 17:30"
            }else if dutyCode == "54"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 17:30"
            }else if dutyCode == "94"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.selectedStartDate = self.selectedEndDate!
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 08:30"
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 12:00"
                self.lbldutyDaysValue.text = "0.44" + "일".localized
            }else if dutyCode == "95"{
                formatter1.dateFormat = "yyyy-MM-dd"
                self.selectedStartDate = self.selectedEndDate!
                self.lblStartDateValue.text = formatter1.string(from: self.selectedStartDate!) + " 13:00"
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!) + " 17:30"
                self.lbldutyDaysValue.text = "0.56" + "일".localized
            }else {
                formatter1.dateFormat = "yyyy-MM-dd HH:mm"
                self.lblEndDateValue.text = formatter1.string(from: self.selectedEndDate!)
            }
            self.calculateDudyDays()
            self.lblEndDateValue.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
        })
        timePicker.addTarget(self, action: #selector(endTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func endTimeDiveChanged(sender: UIDatePicker) {
        selectedEndDate = sender.date
    }
    
    func calculateDudyDays(){
        if !lblStartDateValue.text!.contains("시작".localized) && !lblEndDateValue.text!.contains("종료".localized) {
            if dutyCode == "17" || dutyCode == "18" {
                lbldutyDaysValue.text = "1" + "일".localized
            }else if(dutyCode != "94" && dutyCode != "95") {
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyyMMdd"
                if let selectedStartDate = selectedStartDate, let selectedEndDate = selectedEndDate {
                    
                    let rsCnt = checkDayCount(
                        startDate: formatter1.string(from: selectedStartDate),
                        endDate: formatter1.string(from: selectedEndDate))
                    
                    let dateDiff = selectedEndDate.timeIntervalSince(selectedStartDate)
                    let divided = dateDiff/(60*60*24)
                    let dutyDays = floor(round(divided*100)/100) + 1
                    let dd = Int(dutyDays) - rsCnt
                    lbldutyDaysValue.text = "\(dd)" + "일".localized
                }
            }
        }
    }
    
    @objc func btnSaveClicked(){
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyyMMdd"
        let makeDate = formatter1.string(from: selectedMakeStartDate)
        
        if makeDate.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "근태일자를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if dutyCode.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "근태 코드를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if selectedDivCd.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "사업부문을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (dutyCode == "63" || dutyCode == "64") && selectedNationCd.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "국가코드를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (dutyCode == "63" || dutyCode == "64") && selectedExitCd.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "출국구분을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if dutyCode == "53" && selectedHoliday.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "명절대체근무일을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let eduOrg = tfeduOrg.text ?? ""
        let orderNum = tforderNum.text ?? ""
        let reason = tfreason.text ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let minuteFormatter = DateFormatter()
        minuteFormatter.dateFormat = "HHmm"
        let fullFormatter = DateFormatter()
        fullFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        var startDate = ""
        var startTime = ""
        if let selectedStartDate = selectedStartDate, let s = self.lblStartDateValue.text {
//            startDate = dutyCode != "18" ? dateFormatter.string(from: selectedStartDate) : ""
//            startTime = dutyCode != "18" ? minuteFormatter.string(from: selectedStartDate) : ""
            if let sd = fullFormatter.date(from: s) {
                startDate = dutyCode != "18" ? dateFormatter.string(from: sd) : ""
                startTime = dutyCode != "18" ? minuteFormatter.string(from: sd) : ""
            }
        }
        var endDate = ""
        var endTime = ""
        if let selectedEndDate = selectedEndDate, let e = self.lblEndDateValue.text {
//            endDate = dutyCode != "17" ? dateFormatter.string(from: selectedEndDate) : ""
//            endTime = dutyCode != "17" ? minuteFormatter.string(from: selectedEndDate) : ""
            if let ed = fullFormatter.date(from: e) {
                endDate = dutyCode != "17" ? dateFormatter.string(from: ed) : ""
                endTime = dutyCode != "17" ? minuteFormatter.string(from: ed) : ""
            }
        }
        
        if dutyCode != "18" && startDate.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "시작일자를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if dutyCode != "17" && endDate.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "종료일자를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var dutyDays = ""
        if let stDays = lbldutyDaysValue.text {
            dutyDays = stDays.replacingOccurrences(of: "일".localized, with: "")
        }
        let remark = tfremark.text ?? ""
        ApiService.request(router: CheckerApi.update(param: CheckerUpdateRequest(
            makeDate: makeDate,
            dutyCode: dutyCode,
            divCdParam: selectedDivCd,
            nationCd: selectedNationCd,
            exitCd: selectedExitCd,
            eduOrg: eduOrg,
            orderNum: orderNum,
            reason: reason,
            startDate: startDate,
            startTime: startTime,
            endDate: endDate,
            endTime: endTime,
            dutyDays: dutyDays,
            remark: remark,
            apprState: apprState,
            msgCd: msgCd,
            seq: seq,
            refSeq: refSeq,
            useDate: selectedHoliday
        )),
                           success: { (response: ApiResponse<CheckerDetailInfoResponse>) in
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
        }
    }
    
    @objc func btnDeleteClicked(){
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyyMMdd"
        let makeDate = formatter1.string(from: selectedMakeStartDate)
        
        if makeDate.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "근태일자를 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        ApiService.request(router: CheckerApi.delete(param: CheckerDeleteRequest(
            seq: seq,
            makeDate: makeDate,
            dutyCode: dutyCode
        )),
                           success: { (response: ApiResponse<CheckerDetailInfoResponse>) in
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "삭제 되었습니다".localized, preferredStyle: .alert)
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
    
    @objc func btnCancelClicked(){
        self.dismiss(animated: true, completion: nil)
    }
}
extension CheckerAddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if btnDraft.isEnabled && !isDraftCancel {
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 40)
    }
}

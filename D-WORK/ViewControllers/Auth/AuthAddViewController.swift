//
//  AuthAddViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit
import JGProgressHUD
class AuthAddViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, DropDownViewProtocol {
    
    let hud = JGProgressHUD()
    let util = Util()
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    let scrollView = UIScrollView()
    
    let lblUpdateTitle: UILabel = {
        let label = UILabel()
        label.text = "적용 권한".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    let lblUser: UILabel = {
        let label = UILabel()
        label.text = "사용자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblUserValue: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let lblactPermission: UILabel = {
        let label = UILabel()
        label.text = "사용권한".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lbldivPermission: UILabel = {
        let label = UILabel()
        label.text = "사업부문권한".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvInfoListCellHeight = 51
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    
    var getActPermissionList:[CodeListDetailResponse] = []
    var actPermissionList:[String] = []
    var actPermissionDropDown = DropDownBtn()
    
    var divPermissionDropDown = DropDownBtn()
    var getDivPermissionList:[CodeListDetailResponse] = []
    var divPermissionList:[String] = []
    
    let lbldivCd1: UILabel = {
        let label = UILabel()
        label.text = "겸직사업장1".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var divCd1DropDown = DropDownBtn()
    var getDivCd1List:[DivListDetailResponse] = []
    var divCd1List:[String] = []
    
    let lbldivCd2: UILabel = {
        let label = UILabel()
        label.text = "겸직사업장2".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var divCd2DropDown = DropDownBtn()
    
    let lbldivCd3: UILabel = {
        let label = UILabel()
        label.text = "겸직사업장3".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var divCd3DropDown = DropDownBtn()
    
    let lbldivCd4: UILabel = {
        let label = UILabel()
        label.text = "겸직사업장4".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var divCd4DropDown = DropDownBtn()
    
    let btnAdd: UIButton = {
        let button = UIButton()
        button.setTitle("권한추가".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    var btnAddTopAnchor:NSLayoutConstraint?
    
    let lblEtcTitle: UILabel = {
        let label = UILabel()
        label.text = "미적용 권한".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor.black
        return label
    }()
    var etcList:[AuthEtcListResponseData] = []
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
        topView.isShowNoti = true
        self.view.addSubview(topView)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(lblUpdateTitle)
        lblUpdateTitle.translatesAutoresizingMaskIntoConstraints = false
        lblUpdateTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        lblUpdateTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblUpdateTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        scrollView.addSubview(lblUser)
        lblUser.translatesAutoresizingMaskIntoConstraints = false
        lblUser.topAnchor.constraint(equalTo: lblUpdateTitle.bottomAnchor, constant: 24).isActive = true
        lblUser.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblUser.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblUserValue)
        lblUserValue.translatesAutoresizingMaskIntoConstraints = false
        lblUserValue.centerYAnchor.constraint(equalTo: lblUser.centerYAnchor).isActive = true
        lblUserValue.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblUserValue.leadingAnchor.constraint(equalTo: lblUser.trailingAnchor, constant: 65).isActive = true
        
        scrollView.addSubview(lblactPermission)
        lblactPermission.translatesAutoresizingMaskIntoConstraints = false
        lblactPermission.topAnchor.constraint(equalTo: lblUser.bottomAnchor, constant: 41).isActive = true
        lblactPermission.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblactPermission.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lbldivPermission)
        lbldivPermission.translatesAutoresizingMaskIntoConstraints = false
        lbldivPermission.topAnchor.constraint(equalTo: lblactPermission.bottomAnchor, constant: 41).isActive = true
        lbldivPermission.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivPermission.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        
        scrollView.addSubview(lbldivCd1)
        lbldivCd1.translatesAutoresizingMaskIntoConstraints = false
        lbldivCd1.topAnchor.constraint(equalTo: lbldivPermission.bottomAnchor, constant: 41).isActive = true
        lbldivCd1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivCd1.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lbldivCd2)
        lbldivCd2.translatesAutoresizingMaskIntoConstraints = false
        lbldivCd2.topAnchor.constraint(equalTo: lbldivCd1.bottomAnchor, constant: 41).isActive = true
        lbldivCd2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivCd2.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lbldivCd3)
        lbldivCd3.translatesAutoresizingMaskIntoConstraints = false
        lbldivCd3.topAnchor.constraint(equalTo: lbldivCd2.bottomAnchor, constant: 41).isActive = true
        lbldivCd3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivCd3.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lbldivCd4)
        lbldivCd4.translatesAutoresizingMaskIntoConstraints = false
        lbldivCd4.topAnchor.constraint(equalTo: lbldivCd3.bottomAnchor, constant: 41).isActive = true
        lbldivCd4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lbldivCd4.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(btnAdd)
        btnAdd.translatesAutoresizingMaskIntoConstraints = false
        btnAdd.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnAdd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        
        scrollView.addSubview(lblEtcTitle)
        lblEtcTitle.translatesAutoresizingMaskIntoConstraints = false
        lblEtcTitle.topAnchor.constraint(equalTo: btnAdd.bottomAnchor, constant: 32).isActive = true
        lblEtcTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        lblEtcTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        scrollView.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: lblEtcTitle.bottomAnchor, constant: 16).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.isScrollEnabled = false
        cvInfoList.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        cvInfoList.register(MessageRecvPopupListCollectionViewCell.self, forCellWithReuseIdentifier: MessageRecvPopupListCollectionViewCell.ID)
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 0)
        cvInfoListHeightAnchor?.isActive = true
        
        getDivCd1Code()
        getDivPermissionCode()
        getActPermissionCode()
        
        if authInfo == nil {
            getEtcList()
        }else {
            lblEtcTitle.isHidden = true
            selectedActPermission = authInfo?.actPermission ?? ""
            selectedDivPermission = authInfo?.divPermission ?? ""
            selectedDivCd1 = authInfo?.divCd1 ?? ""
            selectedDivCd2 = authInfo?.divCd2 ?? ""
            selectedDivCd3 = authInfo?.divCd3 ?? ""
            selectedDivCd4 = authInfo?.divCd4 ?? ""
            btnAdd.setTitle("권한수정".localized, for: .normal)
        }
        
        lblUserValue.text = prsnNm ?? ""
        // Do any additional setup after loading the view.
    }
    
    var prsnCdParam:String?
    var prsnNm:String?
    var authInfo:AuthInfoListResponseData?
    
    var selectedActPermission:String = ""
    var selectedDivPermission:String = ""
    var selectedDivCd1:String = ""
    var selectedDivCd2:String = ""
    var selectedDivCd3:String = ""
    var selectedDivCd4:String = ""
    
    @objc func btnAddClicked() {
        var list = [AuthInfoUpdateRequestList]()
        if authInfo == nil {
            for item in etcList {
                if item.isSelected ?? false {
                    list.append(AuthInfoUpdateRequestList(
                        pgmId: item.pgmId ?? ""
                    ))
                }
            }
            if list.count == 0 {
                let alert  = UIAlertController(title: "알림".localized, message: "권한 추가할 프로그램을 선택해 주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in}))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }else {
            list.append(AuthInfoUpdateRequestList(
                pgmId: authInfo?.pgmId ?? ""
            ))
        }
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: AuthApi.infoUpdate(
            param: AuthInfoUpdateRequest(
                prsnCdParam: self.prsnCdParam ?? "",
                actPermission: self.selectedActPermission,
                divPermission: self.selectedDivPermission,
                divCd1: selectedDivCd1,
                divCd2: selectedDivCd2,
                divCd3: selectedDivCd3,
                divCd4: selectedDivCd4,
                list: list
            )), success: { (response: ApiResponse<AuthEtcListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        NotificationCenter.default.post(name: Notification.Name("callReload"), object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert  = UIAlertController(title: "알림".localized, message: "장애가 발생하였습니다. 전산실로 문의하여 주십시오", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "divPermissionDropDown" {
            for item in getDivPermissionList {
                if item.subNm == string {
                    selectedDivPermission = item.subCd!
                    if item.subCd == "S" {
                        showDivCds()
                    } else {
                        hideDivCds()
                    }
                    break
                }
            }
        }else if name == "actPermissionDropDown" {
            for item in getActPermissionList {
                if item.subNm == string {
                    selectedActPermission = item.subCd!
                    break
                }
            }
        }else if name == "divCd1DropDown" {
            for item in getDivCd1List {
                if item.divNm == string {
                    selectedDivCd1 = item.divCd!
                    break
                }
            }
        }else if name == "divCd2DropDown" {
            for item in getDivCd1List {
                if item.divNm == string {
                    selectedDivCd2 = item.divCd!
                    break
                }
            }
        }else if name == "divCd3DropDown" {
            for item in getDivCd1List {
                if item.divNm == string {
                    selectedDivCd3 = item.divCd!
                    break
                }
            }
        }else if name == "divCd4DropDown" {
            for item in getDivCd1List {
                if item.divNm == string {
                    selectedDivCd4 = item.divCd!
                    break
                }
            }
        }
    }
    
    func showDivCds(){
        btnAddTopAnchor?.isActive = false
        btnAddTopAnchor = btnAdd.topAnchor.constraint(equalTo: lbldivCd4.bottomAnchor, constant: 41)
        btnAddTopAnchor?.isActive = true
        lbldivCd4.isHidden = false
        divCd4DropDown.isHidden = false
        lbldivCd3.isHidden = false
        divCd3DropDown.isHidden = false
        lbldivCd2.isHidden = false
        divCd2DropDown.isHidden = false
        lbldivCd1.isHidden = false
        divCd1DropDown.isHidden = false
    }
    func hideDivCds(){
        btnAddTopAnchor?.isActive = false
        btnAddTopAnchor = btnAdd.topAnchor.constraint(equalTo: lbldivPermission.bottomAnchor, constant: 41)
        btnAddTopAnchor?.isActive = true
        
        lbldivCd4.isHidden = true
        divCd4DropDown.isHidden = true
        lbldivCd3.isHidden = true
        divCd3DropDown.isHidden = true
        lbldivCd2.isHidden = true
        divCd2DropDown.isHidden = true
        lbldivCd1.isHidden = true
        divCd1DropDown.isHidden = true
        
        selectedDivCd1 = ""
        selectedDivCd2 = ""
        selectedDivCd3 = ""
        selectedDivCd4 = ""
    }
    
    func getDivCd1Code() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.divList, success: { (response: ApiResponse<DivListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getDivCd1List = list
                    self.divCd1List.removeAll()
                    for item in list {
                        self.divCd1List.append(item.divNm ?? "")
                    }
                    self.updateDivCdDropDowns()
                    
                    if self.authInfo != nil {
                        if self.authInfo?.divPermission == "S" {
                            self.showDivCds()
                        }else {
                            self.hideDivCds()
                        }
                    }else {
                        self.hideDivCds()
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func updateDivCdDropDowns(){
        //4
        divCd4DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divCd4DropDown.name = "divCd4DropDown"
        if authInfo == nil || (authInfo?.divCd4 ?? "").isEmpty {
            divCd4DropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getDivCd1List {
                if item.divCd == authInfo?.divCd4 {
                    divCd4DropDown.stTitle = item.divNm ?? ""
                }
            }
        }
        
        divCd4DropDown.delegate = self
        divCd4DropDown.dropView.dropDownOptions = self.divCd1List
        scrollView.addSubview(divCd4DropDown)
        divCd4DropDown.translatesAutoresizingMaskIntoConstraints = false
        divCd4DropDown.centerYAnchor.constraint(equalTo: lbldivCd4.centerYAnchor).isActive = true
        divCd4DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        divCd4DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divCd4DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //3
        divCd3DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divCd3DropDown.name = "divCd3DropDown"
        if authInfo == nil || (authInfo?.divCd3 ?? "").isEmpty {
            divCd3DropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getDivCd1List {
                if item.divCd == authInfo?.divCd3 {
                    divCd3DropDown.stTitle = item.divNm ?? ""
                }
            }
        }
        divCd3DropDown.delegate = self
        divCd3DropDown.dropView.dropDownOptions = self.divCd1List
        scrollView.addSubview(divCd3DropDown)
        divCd3DropDown.translatesAutoresizingMaskIntoConstraints = false
        divCd3DropDown.centerYAnchor.constraint(equalTo: lbldivCd3.centerYAnchor).isActive = true
        divCd3DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        divCd3DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divCd3DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //2
        divCd2DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divCd2DropDown.name = "divCd2DropDown"
        if authInfo == nil || (authInfo?.divCd2 ?? "").isEmpty {
            divCd2DropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getDivCd1List {
                if item.divCd == authInfo?.divCd2 {
                    divCd2DropDown.stTitle = item.divNm ?? ""
                }
            }
        }
        divCd2DropDown.delegate = self
        divCd2DropDown.dropView.dropDownOptions = self.divCd1List
        scrollView.addSubview(divCd2DropDown)
        divCd2DropDown.translatesAutoresizingMaskIntoConstraints = false
        divCd2DropDown.centerYAnchor.constraint(equalTo: lbldivCd2.centerYAnchor).isActive = true
        divCd2DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        divCd2DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divCd2DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 1
        divCd1DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divCd1DropDown.name = "divCd1DropDown"
        if authInfo == nil || (authInfo?.divCd1 ?? "").isEmpty {
            divCd1DropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getDivCd1List {
                if item.divCd == authInfo?.divCd1 {
                    divCd1DropDown.stTitle = item.divNm ?? ""
                }
            }
        }
        divCd1DropDown.delegate = self
        divCd1DropDown.dropView.dropDownOptions = self.divCd1List
        scrollView.addSubview(divCd1DropDown)
        divCd1DropDown.translatesAutoresizingMaskIntoConstraints = false
        divCd1DropDown.centerYAnchor.constraint(equalTo: lbldivCd1.centerYAnchor).isActive = true
        divCd1DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        divCd1DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divCd1DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func getActPermissionCode(){
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "BB070")), success: { (response: ApiResponse<CodeListResponse>) in
            if let result = response.value {
                self.actPermissionList.removeAll()
                if let result = response.value {
                    if let list = result.data {
                        self.getActPermissionList = list
                        if Environment.SYS_LANG == "ja" {
                            for index in self.getActPermissionList.indices {
                                self.getActPermissionList[index].subNm = self.getActPermissionList[index].jpnSubNm
                            }
                        }
                        for item in self.getActPermissionList {
                            self.actPermissionList.append(item.subNm ?? "")
                        }
                        self.updateActPermissionDropDown()
                    }
                }
            }
        }) { (error) in
        }
    }
    
    func updateActPermissionDropDown(){
        actPermissionDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        actPermissionDropDown.name = "actPermissionDropDown"
        
        if authInfo == nil {
            actPermissionDropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getActPermissionList {
                if item.subCd == authInfo?.actPermission {
                    actPermissionDropDown.stTitle = item.subNm ?? ""
                }
            }
        }
        
        actPermissionDropDown.delegate = self
        actPermissionDropDown.dropView.dropDownOptions = self.actPermissionList
        scrollView.addSubview(actPermissionDropDown)
        actPermissionDropDown.translatesAutoresizingMaskIntoConstraints = false
        actPermissionDropDown.centerYAnchor.constraint(equalTo: lblactPermission.centerYAnchor).isActive = true
        actPermissionDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        actPermissionDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        actPermissionDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func getDivPermissionCode(){
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "BB071")), success: { (response: ApiResponse<CodeListResponse>) in
            if let result = response.value {
                self.divPermissionList.removeAll()
                if let result = response.value {
                    if let list = result.data {
                        self.getDivPermissionList = list
                        if Environment.SYS_LANG == "ja" {
                            for index in self.getDivPermissionList.indices {
                                self.getDivPermissionList[index].subNm = self.getDivPermissionList[index].jpnSubNm
                            }
                        }
                        for item in self.getDivPermissionList {
                            self.divPermissionList.append(item.subNm ?? "")
                        }
                        //                        self.cvUpdateList.reloadData()
                        self.updateDivPermissionDropDown()
                    }
                    
                }
            }
            
        }) { (error) in
        }
    }
    
    func updateDivPermissionDropDown(){
        divPermissionDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divPermissionDropDown.name = "divPermissionDropDown"
        
        if authInfo == nil {
            divPermissionDropDown.stTitle = "내용을 선택하세요".localized
        }else {
            for item in self.getDivPermissionList {
                if item.subCd == authInfo?.divPermission {
                    divPermissionDropDown.stTitle = item.subNm ?? ""
                }
            }
        }
        
        divPermissionDropDown.delegate = self
        divPermissionDropDown.dropView.dropDownOptions = self.divPermissionList
        scrollView.addSubview(divPermissionDropDown)
        divPermissionDropDown.translatesAutoresizingMaskIntoConstraints = false
        divPermissionDropDown.centerYAnchor.constraint(equalTo: lbldivPermission.centerYAnchor).isActive = true
        divPermissionDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        divPermissionDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divPermissionDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func getEtcList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: AuthApi.etcList(param: AuthInfoReadRequest(prsnCdParam: self.prsnCdParam ?? "")), success: { (response: ApiResponse<AuthEtcListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.etcList = list
                    
                    let totalHeight = list.count * self.cvInfoListCellHeight
                    self.cvInfoListHeightAnchor?.isActive = false
                    self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
                    self.cvInfoListHeightAnchor?.isActive = true
                    self.cvInfoList.reloadData()
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

extension AuthAddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return etcList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageRecvPopupListCollectionViewCell.ID, for: indexPath) as! MessageRecvPopupListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblCheck.isHidden = false
            cell.cbCheck.isHidden = true
            for view in cell.stackView.subviews {
                view.removeFromSuperview()
            }
            
            cell.lblDivNm.text = "프로그램ID".localized
            cell.lblDeptNm.text = "프로그램명".localized
            cell.stackView.addArrangedSubview(cell.lblDivNm)
            cell.stackView.addArrangedSubview(cell.lblDeptNm)
            
        default:
            cell.lblCheck.isHidden = true
            cell.cbCheck.isHidden = false
            
            cell.lblDivNm.text =  etcList[indexPath.row].pgmId
            cell.lblDeptNm.text =  etcList[indexPath.row].pgmNm
            for view in cell.stackView.subviews {
                view.removeFromSuperview()
            }
            cell.stackView.addArrangedSubview(cell.lblDivNm)
            cell.stackView.addArrangedSubview(cell.lblDeptNm)
            cell.cbCheck.isSelected = false
            if let isSelected = etcList[indexPath.row].isSelected {
                if isSelected {
                    cell.cbCheck.isSelected = true
                }
            }
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            etcList[indexPath.row].isSelected = !(etcList[indexPath.row].isSelected ?? false)
            cvInfoList.reloadItems(at: [indexPath])
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 51)
    }
}

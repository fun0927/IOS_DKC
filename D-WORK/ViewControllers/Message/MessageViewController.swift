//
//  MessageViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/12.
//

import UIKit
import JGProgressHUD
import SQLite

class MessageViewController: UIViewController, DropDownViewProtocol, UITextViewDelegate {
    
    
    let scrollView = UIScrollView()
    let hud = JGProgressHUD()
    let util = Util()
    var typeDropDown = DropDownBtn()
    var cdatList:[String] = []
    var getCdatList:[CodeListDetailResponse] = []
    let lblType: UILabel = {
        let label = UILabel()
        label.text = "구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var selectedType = ""
    
    let lblRecv: UILabel = {
        let label = UILabel()
        label.text = "수신자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfRecv: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "이름을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    var recvDropDown = DropDownBtn()
    
    let lblttlKr: UILabel = {
        let label = UILabel()
        label.text = "한국어 제목".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfttlKr: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "제목을 입력해주세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblbdKr: UILabel = {
        let label = UILabel()
        label.text = "한국어 내용".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tvbdKr: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .white
        textView.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.text = "내용을 입력해주세요".localized
        return textView
    }()
    
    
    let lblttlJpn: UILabel = {
        let label = UILabel()
        label.text = "일본어 제목".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfttlJpn: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "제목을 입력해주세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let lblbdJpn: UILabel = {
        let label = UILabel()
        label.text = "일본어 내용".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tvbdJpn: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .white
        textView.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.text = "내용을 입력해주세요".localized
        return textView
    }()
    
    let btnSend: UIButton = {
        let button = UIButton()
        button.setTitle("보내기".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("취소".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    let btnTempSave: UIButton = {
        let button = UIButton()
        button.setTitle("임시저장".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    var recvList:[String] = []
    //    struct RecvModel {
    //        var recvType = ""
    //        var recvCd = ""
    //    }
    var requestRecvList:[MessageInfoUpdateRequestList] = []
    var userList:[UserListDetailResponse] = []
    
    struct TmpModel {
        var index = 0
        var date = ""
        var ttlKr = ""
        var ttlJpn = ""
        var bdKr = ""
        var bdJpn = ""
    }
    var tmpSaveList:[TmpModel] = []
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(lblType)
        lblType.translatesAutoresizingMaskIntoConstraints = false
        lblType.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 23).isActive = true
        lblType.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblType.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(lblRecv)
        lblRecv.translatesAutoresizingMaskIntoConstraints = false
        lblRecv.topAnchor.constraint(equalTo: lblType.bottomAnchor, constant: 36).isActive = true
        lblRecv.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblRecv.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        let addView = UIView()
        scrollView.addSubview(addView)
        addView.translatesAutoresizingMaskIntoConstraints = false
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        addView.layer.cornerRadius = 8
        addView.backgroundColor = .white
        
        addView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addView.centerYAnchor.constraint(equalTo: lblRecv.centerYAnchor).isActive = true
        //        addView.leadingAnchor.constraint(equalTo: tfRecv.trailingAnchor, constant: 5).isActive = true
        addView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivAddClicked))
        addView.addGestureRecognizer(tap)
        
        scrollView.addSubview(tfRecv)
        tfRecv.translatesAutoresizingMaskIntoConstraints = false
        tfRecv.centerYAnchor.constraint(equalTo: lblRecv.centerYAnchor).isActive = true
        tfRecv.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        tfRecv.trailingAnchor.constraint(equalTo:addView.leadingAnchor, constant: -5).isActive = true
        tfRecv.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        
        let ivAdd = UIImageView()
        ivAdd.image = UIImage(named: "icon-plus")
        scrollView.addSubview(ivAdd)
        ivAdd.translatesAutoresizingMaskIntoConstraints = false
        ivAdd.widthAnchor.constraint(equalToConstant: 14).isActive = true
        ivAdd.heightAnchor.constraint(equalToConstant: 14).isActive = true
        ivAdd.centerYAnchor.constraint(equalTo: addView.centerYAnchor).isActive = true
        ivAdd.centerXAnchor.constraint(equalTo: addView.centerXAnchor).isActive = true
        
        
        updateRecvDropDown()
        
        
        scrollView.addSubview(lblttlKr)
        lblttlKr.translatesAutoresizingMaskIntoConstraints = false
        lblttlKr.topAnchor.constraint(equalTo: lblRecv.bottomAnchor, constant: 95).isActive = true
        lblttlKr.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblttlKr.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(tfttlKr)
        tfttlKr.translatesAutoresizingMaskIntoConstraints = false
        tfttlKr.centerYAnchor.constraint(equalTo: lblttlKr.centerYAnchor).isActive = true
        tfttlKr.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        tfttlKr.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfttlKr.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        scrollView.addSubview(lblbdKr)
        lblbdKr.translatesAutoresizingMaskIntoConstraints = false
        lblbdKr.topAnchor.constraint(equalTo: lblttlKr.bottomAnchor, constant: 36).isActive = true
        lblbdKr.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblbdKr.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(tvbdKr)
        tvbdKr.delegate = self
        tvbdKr.translatesAutoresizingMaskIntoConstraints = false
        tvbdKr.topAnchor.constraint(equalTo: tfttlKr.bottomAnchor, constant: 8).isActive = true
        tvbdKr.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        tvbdKr.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tvbdKr.heightAnchor.constraint(equalToConstant: 153).isActive = true
        
        scrollView.addSubview(lblttlJpn)
        lblttlJpn.translatesAutoresizingMaskIntoConstraints = false
        lblttlJpn.topAnchor.constraint(equalTo: lblbdKr.bottomAnchor, constant: 138).isActive = true
        lblttlJpn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblttlJpn.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(tfttlJpn)
        tfttlJpn.translatesAutoresizingMaskIntoConstraints = false
        tfttlJpn.centerYAnchor.constraint(equalTo: lblttlJpn.centerYAnchor).isActive = true
        tfttlJpn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        tfttlJpn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfttlJpn.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        scrollView.addSubview(lblbdJpn)
        lblbdJpn.translatesAutoresizingMaskIntoConstraints = false
        lblbdJpn.topAnchor.constraint(equalTo: lblttlJpn.bottomAnchor, constant: 36).isActive = true
        lblbdJpn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblbdJpn.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(tvbdJpn)
        tvbdJpn.delegate = self
        tvbdJpn.translatesAutoresizingMaskIntoConstraints = false
        tvbdJpn.topAnchor.constraint(equalTo: tfttlJpn.bottomAnchor, constant: 8).isActive = true
        tvbdJpn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        tvbdJpn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tvbdJpn.heightAnchor.constraint(equalToConstant: 153).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 9
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: tvbdJpn.bottomAnchor, constant:16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.addArrangedSubview(btnSend)
        stackView.addArrangedSubview(btnCancel)
        stackView.addArrangedSubview(btnTempSave)
        
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        btnTempSave.addTarget(self, action: #selector(btnTempSaveClicked), for: .touchUpInside)
        btnSend.addTarget(self, action: #selector(btnSendClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 7
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        scrollView.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(MessageTmpListCollectionViewCell.self, forCellWithReuseIdentifier: MessageTmpListCollectionViewCell.ID)
        
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 0)
        cvInfoListHeightAnchor?.isActive = true
        cvInfoList.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        getSqlData()
        getCdatCode()
        hideKeyboardWhenTappedAround()
    }
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    @objc func ivAddClicked(){
        if let stRecev = tfRecv.text {
            
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            ApiService.request(router: CommonApi.userList(param: UserListRequest(prsnCdParam: "", prsnNmParam: stRecev)), success: { (response: ApiResponse<UserListResponse>) in
                self.hud.dismiss()
                if let result = response.value {
                    if let list = result.data {
                        self.userList = list
                        if list.count == 1 {
                            let item = list[0]
                            self.recvList.append(item.prsnNm ?? "")
                            self.requestRecvList.append(MessageInfoUpdateRequestList(recvType: "4", recvCd: item.prsnCd ?? ""))
                            self.recvDropDown.dropView.reloadData(dropDownOptions: self.recvList)
                        } else {
                            DispatchQueue.main.async {
                                let vc = MessageRecvPopUpViewController()
                                vc.previousViewController = self
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
                
            }) { (error) in
                self.hud.dismiss()
                
                return
            }
        } else {
            let vc = MessageRecvPopUpViewController()
            vc.previousViewController = self
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    func setDeptListFromPopup(approveList:[UpDeptListDetailResponse], recvType:Int){
        for approveListItem:UpDeptListDetailResponse in approveList {
            var recvCd = ""
            var recvNm = ""
            switch recvType {
            case 1:
                recvCd = approveListItem.divCd ?? ""
                recvNm = approveListItem.divNm ?? ""
            case 2:
                recvCd = approveListItem.deptCd ?? ""
                recvNm = approveListItem.deptNm ?? ""
            case 3:
                recvCd = approveListItem.deptCd ?? ""
                recvNm = approveListItem.deptNm ?? ""
            default:
                recvCd = approveListItem.divCd ?? ""
                recvNm = approveListItem.divNm ?? ""
            }
            self.recvList.append(recvNm)
            self.requestRecvList.append(MessageInfoUpdateRequestList(recvType: "\(recvType)", recvCd: recvCd))
            self.recvDropDown.dropView.reloadData(dropDownOptions: self.recvList)
        }
    }
    func setPrsnListFromPopup(approveList:[UserListDetailResponse], recvType:Int){
        for item:UserListDetailResponse in approveList {
            let recvCd = item.prsnCd ?? ""
            let recvNm = item.prsnNm ?? ""
            self.recvList.append(recvNm)
            self.requestRecvList.append(MessageInfoUpdateRequestList(recvType: "\(recvType)", recvCd: recvCd))
            self.recvDropDown.dropView.reloadData(dropDownOptions: self.recvList)
        }
    }
    
    func getCdatCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 구분 목록
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "F10002")), success: { (response: ApiResponse<CodeListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getCdatList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getCdatList.indices {
                            self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                        }
                    }
                    self.cdatList.removeAll()
                    self.cdatList.append("내용을 선택하세요".localized)
                    for item in self.getCdatList {
                        self.cdatList.append(item.subNm ?? "")
                    }
                    self.updateTypeDropDown()
                }
                
            }
            
        }) { (error) in
            self.hud.dismiss()
        }
    }
    func updateTypeDropDown(){
        typeDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        typeDropDown.name = "typeDropDown"
        typeDropDown.stTitle = cdatList[0]
        typeDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        typeDropDown.delegate = self
        typeDropDown.dropView.dropDownOptions = self.cdatList
        scrollView.addSubview(typeDropDown)
        typeDropDown.translatesAutoresizingMaskIntoConstraints = false
        typeDropDown.centerYAnchor.constraint(equalTo: lblType.centerYAnchor).isActive = true
        typeDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        typeDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        typeDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func updateRecvDropDown(){
        recvDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        recvDropDown.name = "recvDropDown"
        recvDropDown.stTitle = "수신자 리스트 보기".localized
        
        recvDropDown.delegate = self
        recvDropDown.dropView.dropDownOptions = self.recvList
        scrollView.addSubview(recvDropDown)
        recvDropDown.translatesAutoresizingMaskIntoConstraints = false
        recvDropDown.topAnchor.constraint(equalTo: tfRecv.bottomAnchor, constant: 8).isActive = true
        recvDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 103).isActive = true
        recvDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        recvDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "typeDropDown" {
            typeDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getCdatList {
                if item.subNm == string {
                    selectedType = item.subCd ?? ""
                    typeDropDown.lblTitle.textColor = .black
                }
            }
        }
        
        if name == "recvDropDown" {
            recvDropDown.stTitle = "수신자 리스트 보기".localized
            recvDropDown.lblTitle.text = "수신자 리스트 보기".localized
            print("recvList : \(recvList)")
            print("requestRecvList : \(requestRecvList)")
            for (index, item) in recvList.enumerated() {
                if item == string {
                    recvList.remove(at: index)
                    requestRecvList.remove(at: index)
                    self.recvDropDown.dropView.reloadData(dropDownOptions: self.recvList)
                    break
                }
            }
        }
    }
    
    @objc func btnTempSaveClicked(){
        
        guard let stTtlkr = tfttlKr.text else {
            return
        }
        guard let stBdKr = tvbdKr.text else {
            return
        }
        guard let stTtlJpn = tfttlJpn.text else {
            return
        }
        guard let stBdJpn = tvbdJpn.text else {
            return
        }
        if stTtlkr.isEmpty && stTtlJpn.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "한국어 제목, 일본어 제목 중 하나는 입력해야 합니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if !stTtlkr.isEmpty && stBdKr.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "한국어 내용을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if !stTtlJpn.isEmpty && stBdJpn.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "일본어 내용을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        do {
            let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
            let index = Expression<Int>("index")
            let ttlKr = Expression<String>("ttlKr")
            let bdKr = Expression<String>("bdKr")
            let ttlJpn = Expression<String>("ttlJpn")
            let bdJpn = Expression<String>("bdJpn")
            let date = Expression<String>("date")
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy.MM.dd"
            let stDate = formatter1.string(from: Date())
            let message = Table("message")
            
            let currentIndex = tmpSaveList.count > 0 ? tmpSaveList[tmpSaveList.count-1].index+1 : 0
            try db.run(message.insert(index <- currentIndex,
                                      ttlKr <- stTtlkr,
                                      ttlJpn <- stTtlJpn,
                                      bdKr <- stBdKr,
                                      bdJpn <- stBdJpn,
                                      date <- stDate
                                     ))
            
            hud.dismiss()
            let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
                self.getSqlData()
            }))
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            hud.dismiss()
            print(error)
        }
    }
    
    func getSqlData(){
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
            let id = Expression<Int64>("id")
            let index = Expression<Int>("index")
            let ttlKr = Expression<String>("ttlKr")
            let bdKr = Expression<String>("bdKr")
            let ttlJpn = Expression<String>("ttlJpn")
            let bdJpn = Expression<String>("bdJpn")
            let date = Expression<String>("date")
            let message = Table("message")
            //TODO 실제 개발시 만들어졌다면 다시 만들면 안됨
            //            try db.run(message.create { t in     // CREATE TABLE "users" (
            try db.run(message.create(ifNotExists: true) { t in     // CREATE TABLE "users" (
                t.column(id, primaryKey: true) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(index)
                t.column(ttlKr)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(bdKr)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(ttlJpn)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(bdJpn)  //     "email" TEXT UNIQUE NOT NULL,
                t.column(date)  //     "email" TEXT UNIQUE NOT NULL,
            })
            self.cvInfoListHeightAnchor?.isActive = false
            var totalHeight = 0
            tmpSaveList.removeAll()
            
            for sql in try db.prepare(message) {
                let tmpModel = TmpModel(index:sql[index], date: sql[date], ttlKr: sql[ttlKr], ttlJpn: sql[ttlJpn], bdKr: sql[bdKr], bdJpn: sql[bdJpn])
                tmpSaveList.append(tmpModel)
                totalHeight+=7 // lineSpacing
                totalHeight+=433 //cellHeight
            }
            self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
            self.cvInfoListHeightAnchor?.isActive = true
            cvInfoList.reloadData()
            print("tmpSaveList : \(tmpSaveList)")
            
        } catch {
            print (error)
        }
    }
    
    @objc func btnDeleteClicked(sender:UIButton){
        print("sender : \(sender.tag)")
        
        let alert  = UIAlertController(title: "알림".localized, message: "임시 저장에서 삭제할까요?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            do {
                let message = Table("message")
                let index = Expression<Int>("index")
                let deleteRow = message.filter(index == sender.tag)
                let path = NSSearchPathForDirectoriesInDomains(
                    .documentDirectory, .userDomainMask, true
                ).first!
                let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
                try db.run(deleteRow.delete())
                self.getSqlData()
                
            } catch {
                print (error)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소".localized, style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btnCancelClicked(){
        tfttlKr.text = ""
        tvbdKr.text = ""
        tfttlJpn.text = ""
        tvbdJpn.text = ""
        
    }
    
    @objc func btnSendClicked(){
        guard let stTtlkr = tfttlKr.text else {
            return
        }
        guard let stBdKr = tvbdKr.text else {
            return
        }
        guard let stTtlJpn = tfttlJpn.text else {
            return
        }
        guard let stBdJpn = tvbdJpn.text else {
            return
        }
        if stTtlkr.isEmpty && stTtlJpn.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "한국어 제목, 일본어 제목 중 하나는 입력해야 합니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if !stTtlkr.isEmpty && stBdKr.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "한국어 내용을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if !stTtlJpn.isEmpty && stBdJpn.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "일본어 내용을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        
        ApiService.request(router: MessageApi.infoUpdate(param: MessageInfoUpdateRequest(type: selectedType, ttlKr: stTtlkr, bdKr: stBdKr, ttlJpn: stTtlJpn, bdJpn: stBdJpn, list: requestRecvList)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "전송 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        //                        self.dismiss(animated: true, completion: nil)
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

extension MessageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tmpSaveList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageTmpListCollectionViewCell.ID, for: indexPath) as! MessageTmpListCollectionViewCell
        
        cell.lblDateValue.text = tmpSaveList[indexPath.row].date
        cell.lblttlkrValue.text = tmpSaveList[indexPath.row].ttlKr
        cell.lblbdkrValue.text = tmpSaveList[indexPath.row].bdKr
        cell.lblttljpnValue.text = tmpSaveList[indexPath.row].ttlJpn
        cell.lblbdjpnValue.text = tmpSaveList[indexPath.row].bdJpn
        cell.btnDelete.tag = tmpSaveList[indexPath.row].index
        cell.btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tfttlKr.text = tmpSaveList[indexPath.row].ttlKr
        tvbdKr.text = tmpSaveList[indexPath.row].bdKr
        tvbdKr.textColor = .black
        tfttlJpn.text = tmpSaveList[indexPath.row].ttlJpn
        tvbdJpn.text = tmpSaveList[indexPath.row].bdJpn
        tvbdJpn.textColor = .black
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        return CGSize(width: collectionViewSize, height: 433)
    }
}

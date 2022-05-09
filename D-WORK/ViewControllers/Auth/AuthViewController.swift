//
//  AuthViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit
import JGProgressHUD
class AuthViewController: UIViewController, CheckBoxProtocol {
    let hud = JGProgressHUD()
    let util = Util()
    let scrollView = UIScrollView()
    
    let tfPrsnNmParam: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "사원명".localized
        return textField
    }()
    
    let btnRead: UIButton = {
        let button = UIButton()
        button.setTitle("조회".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let lblUserTitle: UILabel = {
        let label = UILabel()
        label.text = "사용자 현황".localized
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
        return label
    }()
    let cvUser = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvUserCellHeight = 55
    
    struct UserInfo {
        var title = ""
        var value = ""
        
    }
    var authInfoList:[UserInfo] = [UserInfo(title: "사업부문".localized, value: ""),UserInfo(title: "ID", value: ""),UserInfo(title: "사원명".localized, value: ""),UserInfo(title: "부서".localized, value: "")]
    
    let lblInfoTitle: UILabel = {
        let label = UILabel()
        label.text = "프로그램 현황".localized
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
        return label
    }()
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    var infoList:[AuthInfoListResponseData] = []
    var isListAllChecked = false
    let cvInfoCellHeight = 51
    
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
    var getActPermissionList:[CodeListDetailResponse] = []
    var getDivPermissionList:[CodeListDetailResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(btnRead)
        btnRead.translatesAutoresizingMaskIntoConstraints = false
        btnRead.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        btnRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnRead.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnRead.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnRead.addTarget(self, action: #selector(btnReadClicked), for: .touchUpInside)
        
        scrollView.addSubview(tfPrsnNmParam)
        tfPrsnNmParam.translatesAutoresizingMaskIntoConstraints = false
        tfPrsnNmParam.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        tfPrsnNmParam.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfPrsnNmParam.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfPrsnNmParam.trailingAnchor.constraint(equalTo: btnRead.leadingAnchor, constant: -7).isActive = true
        
        scrollView.addSubview(lblUserTitle)
        lblUserTitle.translatesAutoresizingMaskIntoConstraints = false
        lblUserTitle.topAnchor.constraint(equalTo: tfPrsnNmParam.bottomAnchor, constant: 24).isActive = true
        lblUserTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblUserTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        
        
        let cvUserLayout = UICollectionViewFlowLayout()
        cvUserLayout.minimumLineSpacing = 0
        cvUserLayout.minimumInteritemSpacing = 0
        cvUserLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvUser.collectionViewLayout = cvUserLayout
        
        cvUser.delegate = self
        cvUser.dataSource = self
        cvUser.backgroundColor = .white
        scrollView.addSubview(cvUser)
        cvUser.translatesAutoresizingMaskIntoConstraints = false
        cvUser.topAnchor.constraint(equalTo: lblUserTitle.bottomAnchor, constant: 16).isActive = true
        cvUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        let cvUserHeight = cvUserCellHeight*4
        cvUser.heightAnchor.constraint(equalToConstant: CGFloat(cvUserHeight)).isActive = true
        cvUser.register(AuthUserCollectionViewCell.self, forCellWithReuseIdentifier: AuthUserCollectionViewCell.ID)
        
        
        let divider = UIView()
        scrollView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.bottomAnchor.constraint(equalTo: cvUser.topAnchor).isActive = true
        divider.leadingAnchor.constraint(equalTo: cvUser.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: cvUser.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        // Do any additional setup after loading the view.
        
        
        scrollView.addSubview(lblInfoTitle)
        lblInfoTitle.translatesAutoresizingMaskIntoConstraints = false
        lblInfoTitle.topAnchor.constraint(equalTo: cvUser.bottomAnchor, constant: 24).isActive = true
        lblInfoTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblInfoTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
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
        cvInfoList.topAnchor.constraint(equalTo: lblInfoTitle.bottomAnchor, constant: 16).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.isScrollEnabled = false
        cvInfoList.register(AuthInfoListCollectionViewCell.self, forCellWithReuseIdentifier: AuthInfoListCollectionViewCell.ID)
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 0)
        cvInfoListHeightAnchor?.isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cvInfoList.bottomAnchor, constant:16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        
        stackView.addArrangedSubview(btnAdd)
        stackView.addArrangedSubview(btnDelete)
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        getDivPermissionCode()
        getActPermissionCode()
        hideKeyboardWhenTappedAround()
        btnAdd.setDisable()
        btnDelete.setDisable()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: Notification.Name(rawValue: "callReload"),
            object: nil)
    }
    @objc func reload() {
        infoList.removeAll()
        getInfoList()
    }
    
    var selectedPrsnCd = ""
    var selectedPrsnNm = ""
    
    @objc func btnAddClicked(){
        let vc = AuthAddViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.prsnCdParam = selectedPrsnCd
        vc.prsnNm = selectedPrsnNm
        present(vc, animated: true, completion: nil)
    }
    @objc func btnDeleteClicked(){
        var list:[AuthInfoDeleteRequestList] = []
        var isDelete = false
        for item in infoList {
            if let isSelected = item.isSelected, isSelected {
                list.append(AuthInfoDeleteRequestList(prsnCdParam: item.prsnCd ?? "", pgmId: item.pgmId ?? ""))
                isDelete = true
            }
        }
        print("list : \(list)")
        if !isDelete {
            let alert  = UIAlertController(title: "알림".localized, message: "권한 삭제할 프로그램을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        //        return
        let alert  = UIAlertController(title: "알림".localized, message: "권한을 삭제 하시겠습나까?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
            self.deleteAuth(list: list)
        }))
        alert.addAction(UIAlertAction(title: "취소".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func deleteAuth(list:[AuthInfoDeleteRequestList]){
        self.hud.textLabel.text = "Loading"
        self.hud.show(in: self.view)
        ApiService.request(router: AuthApi.infoDelete(param: AuthInfoDeleteRequest(list: list)), success: { (response: ApiResponse<AuthInfoReadResponse>) in
            self.hud.dismiss()
            if let _ = response.value {
                let alert  = UIAlertController(title: "알림".localized, message: "권한이 삭제 되었습니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                    self.getInfoList()
                }))
                alert.addAction(UIAlertAction(title: "취소".localized, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    
    @objc func btnReadClicked(){
        if let stRecev = tfPrsnNmParam.text {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            ApiService.request(router: CommonApi.userList(param: UserListRequest(prsnCdParam: "", prsnNmParam: stRecev)), success: { (response: ApiResponse<UserListResponse>) in
                self.hud.dismiss()
                if let result = response.value {
                    if let list = result.data {
                        if list.count == 1 {
                            self.selectedPrsnCd = list[0].prsnCd ?? ""
                            self.getInfoRead()
                            self.getInfoList()
                        } else {
                            let vc = UserPopUpViewController()
                            vc.previousViewController = self
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    } else {
                        let vc = UserPopUpViewController()
                        vc.previousViewController = self
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                }
                
            }) { (error) in
                self.hud.dismiss()
                
            }
        }
        
    }
    func getApproveListFromPopup(approveListItem:UserListDetailResponse){
        if let prsnCd = approveListItem.prsnCd {
            selectedPrsnCd = prsnCd
            self.getInfoRead()
            self.getInfoList()
        }
    }
    
    func getInfoRead() {
        ApiService.request(router: AuthApi.infoRead(param: AuthInfoReadRequest(prsnCdParam: self.selectedPrsnCd)), success: { (response: ApiResponse<AuthInfoReadResponse>) in
            if let result = response.value {
                if let data = result.data {
                    self.selectedPrsnNm = data.prsnNm ?? ""
                    self.authInfoList[0] = UserInfo(title: "사업부문".localized, value: data.divNm ?? "")
                    self.authInfoList[1] = UserInfo(title: "ID", value: data.prsnCd ?? "")
                    self.authInfoList[2] = UserInfo(title: "사원명".localized, value: data.prsnNm ?? "")
                    self.authInfoList[3] = UserInfo(title: "부서".localized, value: data.deptNm ?? "")
                    self.cvUser.reloadData()
                    
                    self.btnAdd.setEnable()
                }
            }
        }) { (error) in
        }
    }
    
    func getInfoList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: AuthApi.infoList(param: AuthInfoReadRequest(prsnCdParam: self.selectedPrsnCd)), success: { (response: ApiResponse<AuthInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList = list
                    self.cvInfoListHeightAnchor?.isActive = false
                    let totalHeight = self.cvInfoCellHeight * self.infoList.count + self.infoList.count*7
                    self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
                    self.cvInfoListHeightAnchor?.isActive = true
                    self.cvInfoList.reloadData()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getActPermissionCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 구분 목록
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "BB070")), success: { (response: ApiResponse<CodeListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getActPermissionList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getActPermissionList.indices {
                            self.getActPermissionList[index].subNm = self.getActPermissionList[index].jpnSubNm
                        }
                    }
                }
            }
            
        }) { (error) in
            self.hud.dismiss()
        }
    }
    func getDivPermissionCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 구분 목록
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "BB071")), success: { (response: ApiResponse<CodeListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getDivPermissionList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getDivPermissionList.indices {
                            self.getDivPermissionList[index].subNm = self.getDivPermissionList[index].jpnSubNm
                        }
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func onSelectChange(name: String, isSelected: Bool) {
        print("name : \(name)")
        if let row:Int = Int(name), row >= 0 {
            if let isS = infoList[row].isSelected, isS {
                infoList[row].isSelected = false
                isListAllChecked = false
            } else {
                infoList[row].isSelected = true
            }
            btnDelete.setDisable()
            for index in infoList.indices {
                if infoList[index].isSelected ?? false {
                    btnDelete.setEnable()
                    break
                }
            }
            cvInfoList.reloadItems(at: [IndexPath(row: 0, section: 0), IndexPath(row: row, section: 1)])
        }else {
            if infoList.count < 1 {
                return
            }
            if isListAllChecked {
                for index in infoList.indices {
                    infoList[index].isSelected = false
                }
                isListAllChecked = false
            } else {
                for index in infoList.indices {
                    infoList[index].isSelected = true
                }
                isListAllChecked = true
            }
            cvInfoList.reloadData()
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
extension AuthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cvInfoList {
            return 2
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvInfoList {
            if section == 0 {
                return 1
            } else {
                return infoList.count
            }
        } else {
            return authInfoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvInfoList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuthInfoListCollectionViewCell.ID, for: indexPath) as! AuthInfoListCollectionViewCell
            switch indexPath.section {
            case 0:
                cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
                cell.lblpgmNm.text = "프로그램명".localized
                cell.lblactPermission.text = "사용권한".localized
                cell.lbldivPermission.text = "사업부문권한".localized
                cell.cbCheck.delegate = self
                cell.cbCheck.name = "-1"
                cell.cbCheck.isSelected = isListAllChecked
//                cell.cbCheck.delegate = nil
//                cell.cbCheck.isUserInteractionEnabled = false
                break
            default:
                cell.lblpgmNm.text = infoList[indexPath.row].pgmNm
                cell.lblactPermission.text = infoList[indexPath.row].actPermission
                cell.lbldivPermission.text = infoList[indexPath.row].divPermission
                cell.cbCheck.delegate = self
                cell.cbCheck.name = String(indexPath.row)
                cell.cbCheck.isSelected = infoList[indexPath.row].isSelected ?? false
                
                if let actPermission = infoList[indexPath.row].actPermission {
                    for item in getActPermissionList {
                        if item.subCd == actPermission {
                            cell.lblactPermission.text = item.subNm
                        }
                    }
                }
                
                if let divPermission = infoList[indexPath.row].divPermission {
                    for item in getDivPermissionList {
                        if item.subCd == divPermission {
                            cell.lbldivPermission.text = item.subNm
                        }
                    }
                }
                cell.backgroundColor = .white
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuthUserCollectionViewCell.ID, for: indexPath) as! AuthUserCollectionViewCell
            
            cell.lblLabel.text = authInfoList[indexPath.row].title
            cell.lblValue.text = authInfoList[indexPath.row].value
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvInfoList {
            if indexPath.section == 1 {
                let vc = AuthAddViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.prsnCdParam = selectedPrsnCd
                vc.prsnNm = selectedPrsnNm
                vc.authInfo = self.infoList[indexPath.row]
                present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        if collectionView == cvInfoList {
            return CGSize(width: collectionViewSize, height: CGFloat(cvInfoCellHeight))
        } else {
            return CGSize(width: collectionViewSize, height: CGFloat(cvUserCellHeight))
        }
    }
}

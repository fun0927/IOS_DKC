//  UserInfoUpdateViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import UIKit
import JGProgressHUD
import Alamofire
import WebKit

class DSSUserInfoUpdateViewController: UIViewController, WKUIDelegate {
    let hud = JGProgressHUD()
    let util = Util()

    let lblUserTitle: UILabel = {
        let label = UILabel()
        label.text = "사용자 정보".localized
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
        return label
    }()
  
    let scrollView = UIScrollView()
    let cvUser = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvUserCellHeight = 55
//    var userList
    struct UserInfo {
        var title = ""
        var value = ""

    }
    var authInfoList:[UserInfo] = []
    
    
    let lblChangeTitle: UILabel = {
        let label = UILabel()
        label.text = "변경신청 정보".localized
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
        return label
    }()
    
    let tftelNo: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "전화번호를 입력하세요".localized
        return textField
    }()
    
    let btnFind: UIButton = {
        let button = UIButton()
        button.setTitle("주소찾기".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    let tfKeyword: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "주소를 입력하세요".localized
        return textField
    }()
    let tfDetailAddress: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "나머지 주소를 입력하세요".localized
        return textField
    }()
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("사용자정보 변경 신청".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    let lblChange1: UILabel = {
        let label = UILabel()
        label.text = "변경상태".localized
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblChange2: UILabel = {
        let label = UILabel()
        label.text = "미적용".localized
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        return label
    }()
    var model:KakaoAddress?
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
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
        
        scrollView.addSubview(lblUserTitle)
        lblUserTitle.translatesAutoresizingMaskIntoConstraints = false
        lblUserTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
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
        let cvUserHeight = 245
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

        scrollView.addSubview(lblChangeTitle)
        lblChangeTitle.translatesAutoresizingMaskIntoConstraints = false
        lblChangeTitle.topAnchor.constraint(equalTo: cvUser.bottomAnchor, constant: 32).isActive = true
        lblChangeTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblChangeTitle.heightAnchor.constraint(equalToConstant: 29).isActive = true
       
        scrollView.addSubview(tftelNo)
        tftelNo.translatesAutoresizingMaskIntoConstraints = false
        tftelNo.topAnchor.constraint(equalTo: lblChangeTitle.bottomAnchor, constant: 17).isActive = true
        tftelNo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tftelNo.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tftelNo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        scrollView.addSubview(btnFind)
        btnFind.translatesAutoresizingMaskIntoConstraints = false
        btnFind.widthAnchor.constraint(equalToConstant: 119).isActive = true
        btnFind.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnFind.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnFind.topAnchor.constraint(equalTo: tftelNo.bottomAnchor, constant: 9).isActive = true
        btnFind.addTarget(self, action: #selector(btnFindClicked), for: .touchUpInside)
       
        scrollView.addSubview(tfKeyword)
        tfKeyword.translatesAutoresizingMaskIntoConstraints = false
        tfKeyword.topAnchor.constraint(equalTo: tftelNo.bottomAnchor, constant: 9).isActive = true
        tfKeyword.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfKeyword.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfKeyword.trailingAnchor.constraint(equalTo: btnFind.leadingAnchor, constant: -8).isActive = true
        tfKeyword.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
        
        scrollView.addSubview(tfDetailAddress)
        tfDetailAddress.translatesAutoresizingMaskIntoConstraints = false
        tfDetailAddress.topAnchor.constraint(equalTo: tfKeyword.bottomAnchor, constant: 9).isActive = true
        tfDetailAddress.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfDetailAddress.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfDetailAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
       
        scrollView.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.topAnchor.constraint(equalTo: tfDetailAddress.bottomAnchor, constant: 16).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
       
        scrollView.addSubview(lblChange2)
        lblChange2.translatesAutoresizingMaskIntoConstraints = false
        lblChange2.centerYAnchor.constraint(equalTo: lblChangeTitle.centerYAnchor).isActive = true
        lblChange2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19).isActive = true
        lblChange2.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(lblChange1)
        lblChange1.translatesAutoresizingMaskIntoConstraints = false
        lblChange1.centerYAnchor.constraint(equalTo: lblChangeTitle.centerYAnchor).isActive = true
        lblChange1.trailingAnchor.constraint(equalTo: lblChange2.leadingAnchor, constant: -8).isActive = true
        
        lblChange2.isHidden = true
        lblChange1.isHidden = true
        getInfoRead()
        // Do any additional setup after loading the view.
    }
    
    func getInfoRead() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: UserApi.infoRead, success: { (response: ApiResponse<UserInfoReadResponse>) in
            self.authInfoList.removeAll()
            self.hud.dismiss()
            if let result = response.value {
                if let code = result.code, code == 101 {
                  print("code is 101")
                }
                
                if let data = result.data {
                    self.authInfoList.append(UserInfo(title: "사번".localized, value: data.prsnCd ?? ""))
                    self.authInfoList.append(UserInfo(title: "성명".localized, value: data.prsnNm ?? ""))
                    self.authInfoList.append(UserInfo(title: "전화번호".localized, value: data.telNo ?? ""))
                    self.authInfoList.append(UserInfo(title: "주소".localized, value: data.addr ?? ""))
                    self.cvUser.reloadData()
                    if let editTelNo =  data.editTelNo {
                        self.lblChange2.isHidden = false
                        self.lblChange1.isHidden = false
                        self.tftelNo.text = editTelNo
                    }
                    if let editAddr =  data.editAddr {
                        self.lblChange2.isHidden = false
                        self.lblChange1.isHidden = false
                        self.tfKeyword.text = editAddr
                    }
                    if let editDetailAddr =  data.editDetailAddr {
                        self.lblChange2.isHidden = false
                        self.lblChange1.isHidden = false
                        self.tfDetailAddress.text = editDetailAddr
                    }
                }
            }

        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    @objc func btnSaveClicked(){
       
        
        guard let stTelNo = tftelNo.text else {
            return
        }
        guard let stAddress = tfKeyword.text else {
            return
        }
        guard let stDetailAddress = tfDetailAddress.text else {
            return
        }
        if stTelNo.isEmpty && stAddress.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "전화번호 와 주소중 하나는 입력해야 합니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if stDetailAddress.isEmpty && stAddress.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "나머지 주소를 입력하세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: UserApi.infoUpdate(param: UserInfoUpdateRequest(telNo: stTelNo, zipCd: "", roadAddress: stAddress, bname: "", buildingName: "", detailAddress: stDetailAddress)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let code = result.code, code == 101 {
                  print("code is 101")
                    let alert  = UIAlertController(title: "알림".localized, message: "기존 신청 정보가 있습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                  return
                }
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "사용자 정보 변경이 신청되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        self.getInfoRead()
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

    var webview : WKWebView!
    
    @objc func btnFindClicked(){
        let gitURL = URL(string: "http://119.197.110.148:81/addressPop.html?type=IOS")!
        let url = gitURL
        let request = URLRequest(url: url)
        let configure = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        configure.userContentController = contentController
        
        webview = WKWebView(frame: UIScreen.main.bounds, configuration: configure)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        webview.load(request)
        view.addSubview(webview)
    }
}
extension DSSUserInfoUpdateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return authInfoList.count
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuthUserCollectionViewCell.ID, for: indexPath) as! AuthUserCollectionViewCell
        cell.lblLabel.text = authInfoList[indexPath.row].title
        cell.lblValue.text = authInfoList[indexPath.row].value
        if indexPath.row ==  3 {
            cell.lblValue.numberOfLines = 2
        } else {
            cell.lblValue.numberOfLines = 1
        }
        
        return cell
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        if indexPath.row == 3 {
            return CGSize(width: collectionViewSize, height: CGFloat(80))
        } else {
            return CGSize(width: collectionViewSize, height: CGFloat(55))
        }
    }
}

extension DSSUserInfoUpdateViewController: WKNavigationDelegate {
    
}
extension DSSUserInfoUpdateViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            print(data["zonecode"] ?? "")
            print(data["roadAddress"] ?? "")
            print(data["bname"] ?? "")
            print(data["buildingName"] ?? "")
            
            webview.removeFromSuperview()
        }
    }
}

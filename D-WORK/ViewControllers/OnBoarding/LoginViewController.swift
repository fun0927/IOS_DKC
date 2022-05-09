//
//  LoginViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import UIKit
import JGProgressHUD
import Firebase

class LoginViewController: UIViewController, CheckBoxProtocol {
    func onSelectChange(name: String, isSelected: Bool) {
        
    }
    
    let hud = JGProgressHUD()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "사용자 로그인".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        //        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    let tfId: UITextField = {
        let textField = UITextField()
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Medium", size: 16)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "사원번호".localized, attributes:attributes)
        //        textField.placeholder = "사원번호"
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    
    let tfPassword: UITextField = {
        let textField = UITextField()
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "NotoSansKR-Medium", size: 16)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호".localized, attributes:attributes)
        //        textField.placeholder = "사원번호"
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        //        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    let btnShowPassword: UIButton = {
        let button = UIButton()
        button.setTitle("표시".localized,for: .normal)
        button.setTitleColor(UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        
        return button
    }()
    let cbAutoLogin = CheckBox()
    
    let lblAutoLogin: UILabel = {
        let label = UILabel()
        label.text = "자동로그인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        //        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let btnLogin: UIButton = {
        let button = UIButton()
        button.setTitle("로그인".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let lblStatus: UILabel = {
        let label = UILabel()
        label.text = "신청일".localized + "2020-09-01"+"     "+"신청상태".localized+" "+"미승인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        //        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
        topView.isShowPush = false
        //        topView.delegate = self
        self.view.addSubview(topView)
        
        view.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 52).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblTitle.widthAnchor.constraint(equalToConstant: 215).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblTitle.textAlignment = .center
        
        
        let viewId = UILabel()
        viewId.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        viewId.layer.cornerRadius = 8
        viewId.layer.borderWidth = 1
        viewId.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        viewId.layer.masksToBounds = true
        
        view.addSubview(viewId)
        viewId.translatesAutoresizingMaskIntoConstraints = false
        viewId.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 32).isActive = true
        viewId.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16).isActive = true
        viewId.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewId.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(tfId)
        tfId.translatesAutoresizingMaskIntoConstraints = false
        tfId.centerYAnchor.constraint(equalTo: viewId.centerYAnchor).isActive = true
        tfId.leadingAnchor.constraint(equalTo: viewId.leadingAnchor, constant: 16).isActive = true
        tfId.trailingAnchor.constraint(equalTo: viewId.trailingAnchor, constant: -16).isActive = true
        tfId.topAnchor.constraint(equalTo: viewId.topAnchor).isActive = true
        tfId.bottomAnchor.constraint(equalTo: viewId.bottomAnchor).isActive = true
        // 일반직
        //        tfId.text = "206009"
        //        조현진 217002 서비스Group // 푸쉬 테스트용
        //                tfId.text = "217002"
        //        tfId.text = "200001" // 슬라이드 메뉴 확인용
        //        tfId.text = "216015" // 푸쉬 테스트용
        // 관리직
        //        tfId.text = "212005"
        //        tfId.text = "198014"
        
        let viewPassword = UILabel()
        viewPassword.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        viewPassword.layer.cornerRadius = 8
        viewPassword.layer.borderWidth = 1
        viewPassword.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        viewPassword.layer.masksToBounds = true
        
        view.addSubview(viewPassword)
        viewPassword.translatesAutoresizingMaskIntoConstraints = false
        viewPassword.topAnchor.constraint(equalTo: tfId.bottomAnchor, constant: 16).isActive = true
        viewPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16).isActive = true
        viewPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tfPassword)
        tfPassword.translatesAutoresizingMaskIntoConstraints = false
        tfPassword.centerYAnchor.constraint(equalTo: viewPassword.centerYAnchor).isActive = true
        tfPassword.leadingAnchor.constraint(equalTo: viewPassword.leadingAnchor, constant: 16).isActive = true
        tfPassword.trailingAnchor.constraint(equalTo: viewPassword.trailingAnchor, constant: -16).isActive = true
        tfPassword.topAnchor.constraint(equalTo: viewPassword.topAnchor).isActive = true
        tfPassword.bottomAnchor.constraint(equalTo: viewPassword.bottomAnchor).isActive = true
        
        //        tfPassword.text = "kjh109"
        //        tfPassword.text = "kcw0830"
        
        view.addSubview(btnShowPassword)
        btnShowPassword.translatesAutoresizingMaskIntoConstraints = false
        btnShowPassword.centerYAnchor.constraint(equalTo: viewPassword.centerYAnchor).isActive = true
        btnShowPassword.trailingAnchor.constraint(equalTo: viewPassword.trailingAnchor, constant: -16).isActive = true
        btnShowPassword.addTarget(self, action: #selector(btnShowPasswordClicked), for: .touchUpInside)
        
        cbAutoLogin.delegate = self
        cbAutoLogin.name = "cbAutoLogin"
        view.addSubview(cbAutoLogin)
        cbAutoLogin.translatesAutoresizingMaskIntoConstraints = false
        cbAutoLogin.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 25).isActive = true
        cbAutoLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cbAutoLogin.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbAutoLogin.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(lblAutoLogin)
        lblAutoLogin.translatesAutoresizingMaskIntoConstraints = false
        lblAutoLogin.centerYAnchor.constraint(equalTo: cbAutoLogin.centerYAnchor).isActive = true
        lblAutoLogin.leadingAnchor.constraint(equalTo: cbAutoLogin.trailingAnchor, constant: 10).isActive = true
        
        
        view.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.topAnchor.constraint(equalTo: cbAutoLogin.bottomAnchor, constant: 23).isActive = true
        btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnLogin.addTarget(self, action: #selector(btnLoginClicked), for: .touchUpInside)
        
        view.addSubview(lblStatus)
        lblStatus.translatesAutoresizingMaskIntoConstraints = false
        lblStatus.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 24).isActive = true
        lblStatus.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        hideKeyboardWhenTappedAround()
        
        let defaults: UserDefaults = UserDefaults.standard
        guard let stat = defaults.string(forKey: "stat") else { return }
        print("stat : \(stat)")
        
        switch stat {
        case "Y":
            lblStatus.isHidden = true
            break
        default:
            guard let reqDate = defaults.string(forKey: "reqDate") else { return }
            let editedReqDate = reqDate.split(separator: "T")[0]
            let st1 = "신청일".localized
            let st2 = "신청상태".localized
            let attributedString = NSMutableAttributedString(string: "\(st1) \(editedReqDate)     \(st2) \("미승인".localized)", attributes: [
                .font: UIFont(name: "NotoSansKR-Regular", size: 16),
                .foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            ])
            attributedString.addAttributes([
                .font: UIFont(name: "NotoSansKR-Medium", size: 16)!,
                .foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            ], range: NSRange(location: 0, length: 3))
            attributedString.addAttributes([
                .font: UIFont(name: "NotoSansKR-Medium", size: 16)!,
                .foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            ], range: NSRange(location: 19, length: 4))
            
            lblStatus.attributedText = attributedString
        }
        
        let autoLogin = defaults.bool(forKey: "autoLogin")
        if autoLogin {
            cbAutoLogin.isSelected = true
            //            print("autoLogin : \(autoLogin)")
            if let prsnCd = defaults.string(forKey: "prsnCd"), let pwd = defaults.string(forKey: "pwd") {
                //                print("prsnCd : \(prsnCd), pwd : \(pwd)")
                login(stId: prsnCd, stPassword: pwd)
            }
        }
    }
    
    @objc func btnShowPasswordClicked(){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
    }
    
    @objc func btnLoginClicked(){
        if let stId = tfId.text, let stPassword = tfPassword.text {
            login(stId: stId, stPassword: stPassword)
        }
    }
    
    func login(stId:String, stPassword:String){
        if stId.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "사원번호를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if stPassword.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "비밀번호를 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let model =  UIDevice.modelName
        
        ApiService.request(router: AuthApi.Login(param: LoginRequest(prsnCd: stId, pwd: stPassword, uuid: Environment.DEVICE_ID)), success: { (response: ApiResponse<LoginResponse>) in
            self.hud.dismiss()
            if let headers = response.headers {
                if let Authorization = headers["Authorization"]{
                    Environment.AUTHORIZATOIN = "\(Authorization)"
                    
                }else {
                    let alert  = UIAlertController(title: "알림".localized, message: "로그인 정보를 확인하세요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
            }
            if let result = response.value {
                //                print("AuthApi.Login result : \(result)")
                
                Messaging.messaging().token { token, error in
                    if let error = error {
                        print("Error fetching FCM registration token: \(error)")
                    } else if let token = token {
                        ApiService.request(router: CommonApi.pushTokenUpdate(param: pushTokenUpdateRequest(pushToken: token)), success: { (response: ApiResponse<LoginResponse>) in
                            
                        }){(error) in
                            
                        }
                    }
                }
                
                
                let defaults: UserDefaults = UserDefaults.standard
                
                if self.cbAutoLogin.isSelected {
                    defaults.set(true, forKey: "autoLogin")
                    defaults.set(stId, forKey: "prsnCd")
                    defaults.set(stPassword, forKey: "pwd")
                    
                    defaults.synchronize()
                    
                }
                if let isManage = result.data?.isManage {
                    Environment.IS_MANAGE = isManage
                    
                }
                if let USER_NAME = result.data?.prsnNm {
                    Environment.USER_NAME = USER_NAME
                }
                if let USER_DIV_CD = result.data?.divCd {
                    Environment.USER_DIV_CD = USER_DIV_CD
                }
                if let USER_DIV_NAME = result.data?.divNm {
                    Environment.USER_DIV_NAME = USER_DIV_NAME
                }
                
                Environment.USER_PRSN_CD = stId
                
                
                DispatchQueue.main.async {
                    let vc = MainViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }) { (error) in
            self.hud.dismiss()
            if let status = error?.errorMessage?.status, let code = error?.errorMessage?.code {
                let alert  = UIAlertController(title: "알림".localized, message: "로그인 정보를 확인하세요".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                //                switch code {
                //                case 900:
                //                    let alert  = UIAlertController(title: "알림", message: "로그인 정보를 확인하세요", preferredStyle: .alert)
                //                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                //                    self.present(alert, animated: true, completion: nil)
                //                default:
                //                    let alert  = UIAlertController(title: "알림", message: "다시 확인해주세요", preferredStyle: .alert)
                //                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                //                    self.present(alert, animated: true, completion: nil)
                //                }
            }//
        }
    }
}

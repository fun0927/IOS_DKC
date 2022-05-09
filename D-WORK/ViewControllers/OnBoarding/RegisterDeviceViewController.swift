//
//  ViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/15.
//

import UIKit
import JGProgressHUD
import CoreLocation
import Firebase
class RegisterDeviceViewController: UIViewController {
    let hud = JGProgressHUD()
    
    let ivTitle = UIImageView()
    let lblTitle: UILabel = {
        let label = UILabel()
        //        label.text = "사용자 기기 접속 신청".localized
        label.text = NSLocalizedString("사용자 기기 접속 신청".localized, comment: "")
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        //        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    let lblDesc: UILabel = {
        let label = UILabel()
        label.text = "다이후쿠 코리아 HR 시스템을\n사용하기 위해서는 기기등록을 해야합니다.\n기기등록시 본인인증을 합니다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
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
    
    let btnRegister: UIButton = {
        let button = UIButton()
        button.setTitle("신청".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnShowPassword: UIButton = {
        let button = UIButton()
        button.setTitle("표시".localized,for: .normal)
        button.setTitleColor(UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        
        return button
    }()
    let locationManager = CLLocationManager()
    var push_token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.addSubview(ivTitle)
        //        ivTitle.image = UIImage(named: "title")
        //        ivTitle.translatesAutoresizingMaskIntoConstraints = false
        //        ivTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        //        ivTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        ivTitle.widthAnchor.constraint(equalToConstant: 94).isActive = true
        //        ivTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //        // Do any additional setup after loading the view.
        
        //add topview
//        var statusBarHeight:CGFloat = 0
//        if #available(iOS 13.0, *) {
//            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        } else {
//            statusBarHeight = UIApplication.shared.statusBarFrame.height
//        }
//        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
//        //        topView.delegate = self
//        self.view.addSubview(topView)
        
        view.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
        lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblTitle.widthAnchor.constraint(equalToConstant: 215).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblTitle.textAlignment = .center
        
        view.addSubview(lblDesc)
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16).isActive = true
        lblDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        lblDesc.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lblDesc.numberOfLines = 0
        lblDesc.textAlignment = .center
        
        let viewId = UILabel()
        viewId.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        viewId.layer.cornerRadius = 8
        viewId.layer.borderWidth = 1
        viewId.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        viewId.layer.masksToBounds = true
        
        view.addSubview(viewId)
        viewId.translatesAutoresizingMaskIntoConstraints = false
        viewId.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 32).isActive = true
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
        //        tfId.text = "217002"
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
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant:24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnRegister)
        stackView.addArrangedSubview(btnCancel)
        
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        btnRegister.addTarget(self, action: #selector(btnRegisterClicked), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                //            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
                self.push_token = token
                let defaults: UserDefaults = UserDefaults.standard
                guard let prsnCd = defaults.string(forKey: "prsnCd") else {
                    return
                }
                guard let pwd = defaults.string(forKey: "pwd") else {
                    return
                }
                let stat = defaults.string(forKey: "stat")
                let reqDate = defaults.string(forKey: "reqDate")
                let isRegisterDevice = defaults.bool(forKey: "isRegisterDevice")
                if isRegisterDevice {
                    self.getRegistCheck(stId: prsnCd, stPassword: pwd, isRegisterDevice:isRegisterDevice)
                }else {
                    self.getRegist(stId: prsnCd, stPassword: pwd, isRegisterDevice:isRegisterDevice)
                }
            }
        }
        
        //        DispatchQueue.main.async {
        //            let vc = LoginViewController()
        //            vc.modalPresentationStyle = .fullScreen
        //            self.present(vc, animated: true, completion: nil)
        //        }
        
        // Do any additional setup after loading the view.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func btnRegisterClicked(){
        if let stId = tfId.text, let stPassword = tfPassword.text {
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
            getRegist(stId: stId, stPassword: stPassword)
        }
    }
    
    func getRegistCheck(stId:String, stPassword:String, isRegisterDevice:Bool=false){
        let model =  UIDevice.modelName
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: AuthApi.RegistCheck(
            param: RegistRequest(
                prsnCd: stId,
                pwd: stPassword,
                model: model,
                os: "IOS, \(Environment.OS_VERSION)",
                uuid: Environment.DEVICE_ID,
                pushToken: push_token
            )), success: { (response: ApiResponse<RegistResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    if result.data == nil {
                        let defaults: UserDefaults = UserDefaults.standard
                        defaults.set(stId, forKey: "prsnCd")
                        defaults.set(stPassword, forKey: "pwd")
                        defaults.set("Y", forKey: "stat")
                        defaults.set(defaults.string(forKey: "reqDate"), forKey: "reqDate")
                        defaults.set(isRegisterDevice, forKey: "isRegisterDevice")
                        defaults.synchronize()
                    }else {
                        let defaults: UserDefaults = UserDefaults.standard
                        defaults.set(stId, forKey: "prsnCd")
                        defaults.set(stPassword, forKey: "pwd")
                        defaults.set(result.data?.stat, forKey: "stat")
                        defaults.set(result.data?.reqDate, forKey: "reqDate")
                        defaults.set(isRegisterDevice, forKey: "isRegisterDevice")
                        defaults.synchronize()
                    }
                    
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                    }
                }else {
                    if result.data != nil {
                        let defaults: UserDefaults = UserDefaults.standard
                        defaults.set(stId, forKey: "prsnCd")
                        defaults.set(stPassword, forKey: "pwd")
                        defaults.set(result.data?.stat, forKey: "stat")
                        defaults.set(result.data?.reqDate, forKey: "reqDate")
                        defaults.set(isRegisterDevice, forKey: "isRegisterDevice")
                        defaults.synchronize()
                        
                        DispatchQueue.main.async {
                            let vc = LoginViewController()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
            //                print("error : \(error)")
            if let status = error?.errorMessage?.status, let code = error?.errorMessage?.code {
                switch code {
                case 900:
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                    }
                default:
                    let alert  = UIAlertController(title: "알림".localized, message: "확인하세요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getRegist(stId:String, stPassword:String, isRegisterDevice:Bool=false){
        let model =  UIDevice.modelName
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: AuthApi.Regist(param: RegistRequest(prsnCd: stId, pwd: stPassword, model: model, os: "IOS, \(Environment.OS_VERSION)", uuid: Environment.DEVICE_ID, pushToken: push_token)), success: { (response: ApiResponse<RegistResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                let defaults: UserDefaults = UserDefaults.standard
                defaults.set(stId, forKey: "prsnCd")
                defaults.set(stPassword, forKey: "pwd")
                defaults.set(result.data?.stat, forKey: "stat")
                defaults.set(result.data?.reqDate, forKey: "reqDate")
                defaults.set(true, forKey: "isRegisterDevice")
                defaults.synchronize()
                
                if isRegisterDevice {
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    let alert  = UIAlertController(title: "알림".localized, message: "사용자 기기 접속 신청이 완료되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }) { (error) in
            self.hud.dismiss()
            //                print("error : \(error)")
            if let status = error?.errorMessage?.status, let code = error?.errorMessage?.code {
                switch code {
                case 900:
                    let alert  = UIAlertController(title: "알림".localized, message: "비밀번호를 확인해주세요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                default:
                    let alert  = UIAlertController(title: "알림".localized, message: "확인해주세요".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func btnCancelClicked(){
        tfId.text = ""
        tfPassword.text = ""
    }
    
    @objc func btnShowPasswordClicked(){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
    }
}


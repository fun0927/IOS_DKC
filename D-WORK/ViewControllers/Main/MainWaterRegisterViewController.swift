//
//  MainWaterRegisterViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import UIKit
import CoreLocation
import JGProgressHUD
class MainWaterRegisterViewController: UIViewController, CLLocationManagerDelegate, DropDownViewProtocol, UITextFieldDelegate, CheckBoxProtocol {
  
    
    let hud = JGProgressHUD()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "출/퇴근 등록".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblToday: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let scrollView = UIScrollView()
    let util = Util()
    
    let cvInOut = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    struct InOutStruct {
        var title = ""
        var date = ""
    }
    var inoutArray:[InOutStruct] = [InOutStruct(title: "출근시간".localized, date: "00 : 00"), InOutStruct(title: "퇴근시간".localized, date: "00 : 00")]
    let locationManager = CLLocationManager()
    
    
    let btnIn: UIButton = {
        let button = UIButton()
        button.setTitle("출근".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let btnOut: UIButton = {
        let button = UIButton()
        button.setTitle("퇴근".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    var isLate = false
    var isEarly = false
    var exceptDropDown = DropDownBtn()
    var exceptDropDownHeightAnchor:NSLayoutConstraint?
    var exceptList:[String] = ["예외1".localized]
    var myLocation:CLLocation?
    var isLocationServicesEnabled = false
    
    let lblWaterRegisterTitle: UILabel = {
        let label = UILabel()
        label.text = "식수 등록".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let cbLaunch = CheckBox()
    let lblLaunch: UILabel = {
        let label = UILabel()
        label.text = "중식".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    var launchDropDown = DropDownBtn()
    var foodList:[String] = ["본사".localized, "공장".localized]
    let launchSummaryView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        view.layer.cornerRadius = 8
        return view
        
    }()
    let lblLaunchSummaryLabel: UILabel = {
        let label = UILabel()
        label.text = "추가인원".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let stWordTotal = "총".localized
    let lblLaunchSum: UILabel = {
        let label = UILabel()
//        label.text = "\(stWordTotal) 100명"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let btnLaunchAdd: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let cvLaunch = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvDinner = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let cbDinner = CheckBox()
    let lblDinner: UILabel = {
        let label = UILabel()
        label.text = "석식".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    var dinnerDropDown = DropDownBtn()
    let dinnerSummaryView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        view.layer.cornerRadius = 8
        return view
        
    }()
    let btnDinnerAdd: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let lblDinnerSummaryLabel: UILabel = {
        let label = UILabel()
        label.text = "추가인원".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblDinnerSum: UILabel = {
        let label = UILabel()
//        label.text = "\(stWordTotal) 100명"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    struct FoodStruct {
        var ldCd:String? // L: 중식, D: 석식
        var addNm:String?
        var addNum:Int?
        var edit:Bool?
    }
    
    var lunchSum = 0
    var cvLaunchHeight = 0.0
    var cvLaunchHeightAnchor:NSLayoutConstraint?
    var launchShowFoodArray:[FoodStruct] = Array.init(repeating: FoodStruct(), count: 3)
    
    var dinnerSum = 0
    var cvDinnerHeight = 0.0
    var cvDinnerHeightAnchor:NSLayoutConstraint?
    var dinnerShowFoodArray:[FoodStruct] = Array.init(repeating: FoodStruct(), count: 3)
    
    var selectedlncLoc = ""
    var selecteddnrLoc = ""
    
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
    var btnSaveTopAnchor:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        if Environment.IS_MANAGE == "0" {
            scrollView.addSubview(lblTitle)
            lblTitle.translatesAutoresizingMaskIntoConstraints = false
            lblTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            lblTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
            lblTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            scrollView.addSubview(lblToday)
            lblToday.translatesAutoresizingMaskIntoConstraints = false
            lblToday.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            lblToday.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
            lblToday.heightAnchor.constraint(equalToConstant: 24).isActive = true
            lblToday.text = util.getToday(format: "yyyy년 MM월 dd일".localized)
            
            let divider = UIView()
            divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
            scrollView.addSubview(divider)
            divider.translatesAutoresizingMaskIntoConstraints = false
            divider.topAnchor.constraint(equalTo: lblToday.bottomAnchor, constant: 18).isActive = true
            divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            divider.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            
            let cvLayout = UICollectionViewFlowLayout()
            cvLayout.minimumLineSpacing = 0
            cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cvInOut.collectionViewLayout = cvLayout
            
            cvInOut.delegate = self
            cvInOut.dataSource = self
            scrollView.addSubview(cvInOut)
            cvInOut.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
            cvInOut.translatesAutoresizingMaskIntoConstraints = false
            cvInOut.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
            cvInOut.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            cvInOut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            let cvHeight = 2 * 56
            cvInOut.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight)).isActive = true
            cvInOut.register(WaterRegisterInOutCollectionViewCell.self, forCellWithReuseIdentifier: WaterRegisterInOutCollectionViewCell.ID)
            cvInOut.isScrollEnabled = false
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
    //        stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 7
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: cvInOut.bottomAnchor, constant:16).isActive = true
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
            
            stackView.addArrangedSubview(btnIn)
            stackView.addArrangedSubview(btnOut)
            
            btnIn.addTarget(self, action: #selector(btnInClicked), for: .touchUpInside)
            btnOut.addTarget(self, action: #selector(btnOutClicked), for: .touchUpInside)
            
            exceptDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            exceptDropDown.name = "exceptDropDown"
            exceptDropDown.stTitle = "예외사항 선택".localized
            exceptDropDown.delegate = self
            scrollView.addSubview(exceptDropDown)
            exceptDropDown.translatesAutoresizingMaskIntoConstraints = false
            exceptDropDown.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:16).isActive = true
            exceptDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            exceptDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
            exceptDropDownHeightAnchor = exceptDropDown.heightAnchor.constraint(equalToConstant: 51)
            exceptDropDownHeightAnchor?.isActive = true
            exceptDropDown.dropView.dropDownOptions = exceptList
            
            
            
            // Do any additional setup after loading the view.
            getLocation()
        }
        
        scrollView.addSubview(lblWaterRegisterTitle)
        lblWaterRegisterTitle.translatesAutoresizingMaskIntoConstraints = false
        if Environment.IS_MANAGE == "0"{
            lblWaterRegisterTitle.topAnchor.constraint(equalTo: exceptDropDown.bottomAnchor, constant: 32).isActive = true
        } else {
            lblWaterRegisterTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        }
        
        lblWaterRegisterTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblWaterRegisterTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        scrollView.addSubview(cbLaunch)
        cbLaunch.translatesAutoresizingMaskIntoConstraints = false
        cbLaunch.topAnchor.constraint(equalTo: lblWaterRegisterTitle.bottomAnchor, constant: 17).isActive = true
        cbLaunch.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbLaunch.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbLaunch.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        cbLaunch.name = "cbLaunch"
        cbLaunch.delegate = self
        
        scrollView.addSubview(lblLaunch)
        lblLaunch.translatesAutoresizingMaskIntoConstraints = false
        lblLaunch.leadingAnchor.constraint(equalTo: cbLaunch.trailingAnchor, constant: 15).isActive = true
        lblLaunch.centerYAnchor.constraint(equalTo: cbLaunch.centerYAnchor).isActive = true
        
        launchDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        launchDropDown.name = "launchDropDown"
        launchDropDown.stTitle = "식당 선택".localized
        launchDropDown.delegate = self
        scrollView.addSubview(launchDropDown)
        launchDropDown.translatesAutoresizingMaskIntoConstraints = false
        launchDropDown.topAnchor.constraint(equalTo: cbLaunch.bottomAnchor, constant:16).isActive = true
        launchDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        launchDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        launchDropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
        launchDropDown.dropView.dropDownOptions = foodList
        launchDropDown.isUserInteractionEnabled = false
        
        scrollView.addSubview(btnLaunchAdd)
        btnLaunchAdd.translatesAutoresizingMaskIntoConstraints = false
        btnLaunchAdd.widthAnchor.constraint(equalToConstant: 59).isActive = true
        btnLaunchAdd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnLaunchAdd.topAnchor.constraint(equalTo: launchDropDown.bottomAnchor, constant: 16).isActive = true
        btnLaunchAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16).isActive = true
        btnLaunchAdd.addTarget(self, action: #selector(btnLaunchAddClicked), for: .touchUpInside)
        
        scrollView.addSubview(launchSummaryView)
        launchSummaryView.translatesAutoresizingMaskIntoConstraints = false
        launchSummaryView.topAnchor.constraint(equalTo: launchDropDown.bottomAnchor, constant: 16).isActive = true
        launchSummaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        launchSummaryView.trailingAnchor.constraint(equalTo: btnLaunchAdd.leadingAnchor, constant: -8).isActive = true
        launchSummaryView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        scrollView.addSubview(lblLaunchSummaryLabel)
        lblLaunchSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        lblLaunchSummaryLabel.centerYAnchor.constraint(equalTo: launchSummaryView.centerYAnchor).isActive = true
        lblLaunchSummaryLabel.leadingAnchor.constraint(equalTo: launchSummaryView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblLaunchSum)
        lblLaunchSum.translatesAutoresizingMaskIntoConstraints = false
        lblLaunchSum.trailingAnchor.constraint(equalTo: launchSummaryView.trailingAnchor, constant: -24).isActive = true
        lblLaunchSum.centerYAnchor.constraint(equalTo: launchSummaryView.centerYAnchor).isActive = true
        lblLaunchSum.text = "\(stWordTotal) 100" + "명".localized
        
        let cvLaunchLayout = UICollectionViewFlowLayout()
        cvLaunchLayout.minimumLineSpacing = 8
        cvLaunchLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvLaunch.collectionViewLayout = cvLaunchLayout
        
        cvLaunch.delegate = self
        cvLaunch.dataSource = self
        scrollView.addSubview(cvLaunch)
        cvLaunch.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cvLaunch.translatesAutoresizingMaskIntoConstraints = false
        cvLaunch.topAnchor.constraint(equalTo: launchSummaryView.bottomAnchor, constant: 8).isActive = true
        cvLaunch.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvLaunch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
//        cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchHeight)).isActive = true
        cvLaunchHeightAnchor = cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchHeight))
        cvLaunchHeightAnchor?.isActive = true
        cvLaunch.register(LaunchCollectionViewCell.self, forCellWithReuseIdentifier: LaunchCollectionViewCell.ID)
        cvLaunch.isScrollEnabled = false
        
        scrollView.addSubview(cbDinner)
        cbDinner.isSelected = true
        cbDinner.translatesAutoresizingMaskIntoConstraints = false
        cbDinner.topAnchor.constraint(equalTo: cvLaunch.bottomAnchor, constant: 24).isActive = true
        cbDinner.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbDinner.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbDinner.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        cbDinner.name = "cbDinner"
        cbDinner.delegate = self
        
        scrollView.addSubview(lblDinner)
        lblDinner.translatesAutoresizingMaskIntoConstraints = false
        lblDinner.leadingAnchor.constraint(equalTo: cbDinner.trailingAnchor, constant: 15).isActive = true
        lblDinner.centerYAnchor.constraint(equalTo: cbDinner.centerYAnchor).isActive = true
        
        dinnerDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dinnerDropDown.name = "dinnerDropDown"
        dinnerDropDown.stTitle = "식당 선택".localized
        dinnerDropDown.delegate = self
        scrollView.addSubview(dinnerDropDown)
        dinnerDropDown.translatesAutoresizingMaskIntoConstraints = false
        dinnerDropDown.topAnchor.constraint(equalTo: cbDinner.bottomAnchor, constant:16).isActive = true
        dinnerDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        dinnerDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        dinnerDropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
        dinnerDropDown.dropView.dropDownOptions = foodList
        dinnerDropDown.isUserInteractionEnabled = false
        
        scrollView.addSubview(btnDinnerAdd)
        btnDinnerAdd.translatesAutoresizingMaskIntoConstraints = false
        btnDinnerAdd.widthAnchor.constraint(equalToConstant: 59).isActive = true
        btnDinnerAdd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDinnerAdd.topAnchor.constraint(equalTo: dinnerDropDown.bottomAnchor, constant: 16).isActive = true
        btnDinnerAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16).isActive = true
        btnDinnerAdd.addTarget(self, action: #selector(btnDinnerAddClicked), for: .touchUpInside)
        btnDinnerAdd.isEnabled = false
        
        scrollView.addSubview(dinnerSummaryView)
        dinnerSummaryView.translatesAutoresizingMaskIntoConstraints = false
        dinnerSummaryView.topAnchor.constraint(equalTo: dinnerDropDown.bottomAnchor, constant: 16).isActive = true
        dinnerSummaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        dinnerSummaryView.trailingAnchor.constraint(equalTo: btnDinnerAdd.leadingAnchor, constant: -8).isActive = true
        dinnerSummaryView.heightAnchor.constraint(equalToConstant: 51).isActive = true
//        dinnerSummaryView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
        
        scrollView.addSubview(lblDinnerSummaryLabel)
        lblDinnerSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        lblDinnerSummaryLabel.centerYAnchor.constraint(equalTo: dinnerSummaryView.centerYAnchor).isActive = true
        lblDinnerSummaryLabel.leadingAnchor.constraint(equalTo: dinnerSummaryView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblDinnerSum)
        lblDinnerSum.translatesAutoresizingMaskIntoConstraints = false
        lblDinnerSum.trailingAnchor.constraint(equalTo: dinnerSummaryView.trailingAnchor, constant: -24).isActive = true
        lblDinnerSum.centerYAnchor.constraint(equalTo: dinnerSummaryView.centerYAnchor).isActive = true
        lblDinnerSum.text = "\(stWordTotal) 100" + "명".localized
        
        let cvDinnerLayout = UICollectionViewFlowLayout()
        cvDinnerLayout.minimumLineSpacing = 8
        cvDinnerLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvDinner.collectionViewLayout = cvDinnerLayout
        
        cvDinner.delegate = self
        cvDinner.dataSource = self
        scrollView.addSubview(cvDinner)
        cvDinner.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cvDinner.translatesAutoresizingMaskIntoConstraints = false
        cvDinner.topAnchor.constraint(equalTo: dinnerSummaryView.bottomAnchor, constant: 8).isActive = true
        cvDinner.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvDinner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        cvDinner.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
//        cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchHeight)).isActive = true
//        let cvDinnerTotalHeight = Double(3*51+8*2)
        let cvDinnerTotalHeight = 0
        cvDinnerHeightAnchor = cvDinner.heightAnchor.constraint(equalToConstant: CGFloat(cvDinnerTotalHeight))
        cvDinnerHeightAnchor?.isActive = true
        cvDinner.register(DinnerCollectionViewCell.self, forCellWithReuseIdentifier: "DinnerCollectionViewCell")
        cvDinner.isScrollEnabled = false
     
        scrollView.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
//        btnSave.topAnchor.constraint(equalTo: cvDinner.bottomAnchor, constant: 16).isActive = true
        btnSaveTopAnchor = btnSave.topAnchor.constraint(equalTo: cvDinner.bottomAnchor, constant: 16)
        btnSaveTopAnchor?.isActive = true
        
        btnSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        
        
        getFoodList()
        
        hideKeyboardWhenTappedAround()
        
    }
    
    func setBtnStatus() {
        let current = util.getToday(format: "HH:mm")
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        
        let timeOver1 = "10:30"
        let isEdit1 = !(f.date(from: current)! > f.date(from: timeOver1)!)
        cbLaunch.isUserInteractionEnabled = isEdit1
        launchDropDown.isUserInteractionEnabled = cbLaunch.isSelected && isEdit1
        btnLaunchAdd.isEnabled = cbLaunch.isSelected && isEdit1
        for i in 0..<launchShowFoodArray.count {
            launchShowFoodArray[i].edit = cbLaunch.isSelected && isEdit1
        }
        cvLaunch.reloadData()
        
        let timeOver2 = "15:30"
        let isEdit2 = !(f.date(from: current)! > f.date(from: timeOver2)!)
        cbDinner.isUserInteractionEnabled = isEdit2
        dinnerDropDown.isUserInteractionEnabled = cbDinner.isSelected && isEdit2
        btnDinnerAdd.isEnabled = cbDinner.isSelected && isEdit2
        for i in 0..<dinnerShowFoodArray.count {
            dinnerShowFoodArray[i].edit = cbDinner.isSelected && isEdit2
        }
        cvDinner.reloadData()
        
        if(!isEdit2) {
            btnSave.setDisable()
        }
    }
    
    
    // 중식 추가 뷰 핸들링
    @objc func btnLaunchAddClicked(){
        if(btnLaunchAdd.isEnabled && launchShowFoodArray.count < 3) {
            let goalCount = launchShowFoodArray.count + 1
            let currentCount = launchShowFoodArray.count
            let addNum = goalCount - currentCount
            for _ in 0..<addNum {
                launchShowFoodArray.append(FoodStruct())
            }
            
            let cvLaunchTotalHeight = Double((goalCount*51) + (currentCount * 9))
            if cvLaunchHeight < cvLaunchTotalHeight {
                cvLaunchHeightAnchor?.isActive = false
                cvLaunchHeightAnchor = cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchTotalHeight))
                cvLaunchHeightAnchor?.isActive = true
            }
            cvLaunch.reloadData()
        }
    }
    
    @objc func btnLunchListMinusClicked(sender:UIButton){
        let index = sender.tag
        launchShowFoodArray.remove(at: index)
//        print("btnLunchListMinusClicked : \(launchShowFoodArray)")
        let cvLaunchTotalHeight = Double(launchShowFoodArray.count*51+8*(launchShowFoodArray.count-1))
        if cvLaunchHeight < cvLaunchTotalHeight {
            cvLaunchHeightAnchor?.isActive = false
            cvLaunchHeightAnchor = cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchTotalHeight))
            cvLaunchHeightAnchor?.isActive = true
            DispatchQueue.main.async {
//                print("cvLaunchTotalHeight : \(cvLaunchTotalHeight)")
                self.cvLaunch.reloadData()
            }
        }
        updateLaunchSum()
    }
    
    @objc func btnDinnerAddClicked(){
        if(btnDinnerAdd.isEnabled && dinnerShowFoodArray.count < 3) {
            let goalCount = dinnerShowFoodArray.count + 1
            let currentCount = dinnerShowFoodArray.count
            let addNum = goalCount - currentCount
            for _ in 0..<addNum {
                dinnerShowFoodArray.append(FoodStruct())
            }
            
            let cvDinnerTotalHeight = Double((goalCount*51) + (currentCount * 9))
            cvDinnerHeightAnchor?.isActive = false
            cvDinnerHeightAnchor = cvDinner.heightAnchor.constraint(equalToConstant: CGFloat(cvDinnerTotalHeight))
            cvDinnerHeightAnchor?.isActive = true
            cvDinner.reloadData()
        }
    }
    
    @objc func btnDinnerListMinusClicked(sender:UIButton){
        let index = sender.tag
        dinnerShowFoodArray.remove(at: index)
//        print("btnDinnerListMinusClicked : \(dinnerShowFoodArray)")
        let cvDinnerTotalHeight = Double(dinnerShowFoodArray.count*51+8*(dinnerShowFoodArray.count-1))
        cvDinnerHeightAnchor?.isActive = false
        cvDinnerHeightAnchor = cvDinner.heightAnchor.constraint(equalToConstant: CGFloat(cvDinnerTotalHeight))
        cvDinnerHeightAnchor?.isActive = true
        DispatchQueue.main.async {
//            print("cvDinnerTotalHeight : \(cvDinnerTotalHeight)")
            self.cvDinner.reloadData()
        }
        updateDinnerSum()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("textFieldDidEndEditing text : \(textField.text)")
//        print("textFieldDidEndEditing tag : \(textField.tag)")
        let stTag = "\(textField.tag)"
        if let text = textField.text {
            if stTag.contains("100") || stTag.contains("101") || stTag.contains("102") {
                // cvLaunch
                let lastIndex = stTag.index(stTag.startIndex, offsetBy: 2)
                let lastTag = stTag.substring(from: lastIndex)
//                print("lastTag : \(lastTag)")
                if let inIndex = Int(lastTag) {
                    launchShowFoodArray[inIndex].addNm = textField.text
//                    print("textFieldDidEndEditing launchShowFoodArray : \(launchShowFoodArray)")
                    updateLaunchSum()
                }
            } else if stTag.contains("110") ||  stTag.contains("111") ||  stTag.contains("112") {
                let lastIndex = stTag.index(stTag.startIndex, offsetBy: 2)
                let lastTag = stTag.substring(from: lastIndex)
//                print("lastTag : \(lastTag)")
                if let inIndex = Int(lastTag) {
                    launchShowFoodArray[inIndex].addNum = Int(text)
//                    print("textFieldDidEndEditing launchShowFoodArray : \(launchShowFoodArray)")
                    updateLaunchSum()
                }
            }  else if stTag.contains("200") ||  stTag.contains("201") ||  stTag.contains("202") {
                let lastIndex = stTag.index(stTag.startIndex, offsetBy: 2)
                let lastTag = stTag.substring(from: lastIndex)
                print("lastTag : \(lastTag)")
                if let inIndex = Int(lastTag) {
                    dinnerShowFoodArray[inIndex].addNm = textField.text
//                    print("textFieldDidEndEditing dinnerShowFoodArray : \(dinnerShowFoodArray)")
                    updateDinnerSum()
                }
            } else if stTag.contains("210") ||  stTag.contains("211") ||  stTag.contains("212") {
                let lastIndex = stTag.index(stTag.startIndex, offsetBy: 2)
                let lastTag = stTag.substring(from: lastIndex)
//                print("lastTag : \(lastTag)")
                if let inIndex = Int(lastTag) {
                    dinnerShowFoodArray[inIndex].addNum = Int(text)
//                    print("textFieldDidEndEditing dinnerShowFoodArray : \(dinnerShowFoodArray)")
                    updateDinnerSum()
                }
            }
        }
    }
    
    func updateLaunchSum(){
        var total = 0
        for item in launchShowFoodArray {
            total += item.addNum ?? 0
        }
        let attributedString = NSMutableAttributedString(string: "\(stWordTotal) \(total)" + "명".localized, attributes: [
          .font: UIFont(name: "NotoSansKR-Regular", size: 16),
          .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "NotoSansKR-Medium", size: 16)!,
          .foregroundColor:  UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        ], range: NSRange(location: 2, length: String(total).count))
        
        lblLaunchSum.attributedText = attributedString
    }
    
    func updateDinnerSum(){
        var total = 0
        for item in dinnerShowFoodArray {
            total += item.addNum ?? 0
        }
        let attributedString = NSMutableAttributedString(string: "\(stWordTotal) \(total)" + "명".localized, attributes: [
          .font: UIFont(name: "NotoSansKR-Regular", size: 16),
          .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "NotoSansKR-Medium", size: 16)!,
          .foregroundColor:  UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        ], range: NSRange(location: 2, length: String(total).count))
        
        lblDinnerSum.attributedText = attributedString
    }
    
    
    
    @objc func btnInClicked(){
        // 출근 등록 gps 사용일 경우,
        var inOutInsertRequest:InOutInsertRequest
        if isLocationServicesEnabled {
            inOutInsertRequest = InOutInsertRequest(inOut: "1", reason: "mainCd: BM010", lttd: String((myLocation?.coordinate.latitude)!), lngt: String((myLocation?.coordinate.longitude)!))
            postInOut(inOutInsertRequest: inOutInsertRequest)
        } else {
            inOutInsertRequest = InOutInsertRequest(inOut:"1")
            postInOut(inOutInsertRequest: inOutInsertRequest)
        }
    }
    
    
    
    @objc func btnOutClicked(){
        // 퇴근 등록 gps 사용일 경우,
        var inOutInsertRequest:InOutInsertRequest
        if isLocationServicesEnabled {
            inOutInsertRequest = InOutInsertRequest(inOut: "2", reason: "mainCd: BM010", lttd: String((myLocation?.coordinate.latitude)!), lngt: String((myLocation?.coordinate.longitude)!))
            postInOut(inOutInsertRequest: inOutInsertRequest)
        } else {
            inOutInsertRequest = InOutInsertRequest(inOut:"2")
            postInOut(inOutInsertRequest: inOutInsertRequest)
        }
        
    }
    
    func postInOut(inOutInsertRequest:InOutInsertRequest){
        print("inOutInsertRequest : \(inOutInsertRequest)")
        ApiService.request(router: InOutApi.inOutInsert(param: inOutInsertRequest), success: { (response: ApiResponse<InOutReadResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                self.inOutTimeViewHandler(result: result)
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func dropDownPressed(name: String, string: String) {
        print("dropDownPressed name : \(name), string : \(string)")
        if name == "exceptDropDown" {
            self.activateBtnIn()
            self.activateBtnOut()
        } else if name == "launchDropDown" {
            if string == "공장".localized {
                selectedlncLoc = "200"
            } else {
                selectedlncLoc = "100"
            }
        } else if name == "dinnerDropDown"{
            if string == "공장".localized {
                selecteddnrLoc = "200"
            } else {
                selecteddnrLoc = "100"
            }
        }
    }
    
    func getFoodList(){
        ApiService.request(router: FoodAPi.foodList, success: { (response: ApiResponse<FoodListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                self.updateFoodUi(result: result)
            }

        }) { (error) in
            self.hud.dismiss()
          return
        }
    }
    
    
    func getLocation(){
        // Do any additional setup after loading the view.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
//            print("CLLocationManager enabled")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            if let currentLoc = locationManager.location {
//                print("currentLoc : \(currentLoc)")
                self.myLocation = currentLoc
                self.isLocationServicesEnabled = true
//                addMap(lat: currentLoc.coordinate.latitude, lng: currentLoc.coordinate.longitude)
            } else {
//                print("can not call currentLoc ")
                self.activateBtnIn()
                self.activateBtnOut()
                self.hideExceptDropDown()
            }
        } else {
//            print("CLLocationManager not enabled")
            self.activateBtnIn()
            self.activateBtnOut()
            self.exceptDropDown.isHidden = true
        }
        getInOutInfo()

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        addMap(lat: locValue.latitude, lng: locValue.longitude)
    }
    
    
    func getInOutInfo(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: InOutApi.inOutRead, success: { (response: ApiResponse<InOutReadResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("getInOutInfo result : \(result)")
                self.inOutTimeViewHandler(result: result)
            }

        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
          
          return
        }
    }
    
    func inOutTimeViewHandler(result:InOutReadResponse){
        if let comeTime = result.data?.comeTime {
            if comeTime.isEmpty {
                // 출근버튼 활성화
                self.activateBtnIn()
                
            } else {
                // 비활성화
                self.inoutArray[0].date = comeTime
                self.deactivateBtnIn()
            }
        }
        if let leaveTime = result.data?.leaveTime {
            if leaveTime.isEmpty {
                self.activateBtnOut()
            } else {
                self.inoutArray[1].date = leaveTime
                self.deactivateBtnOut()
            }
        }
        if let isLate = result.data?.isLate {
            if isLate == 1 {
                self.isLate = true
            }
        }
        if let isEarly = result.data?.isEarly {
            if isEarly == 1 {
                self.isEarly = true
            }
        }
        if let gpsYn = result.data?.gpsYn {
            if gpsYn == "Y" {
//                        self.exceptDropDown.isHidden = false
                self.getInOutCoordList()
            } else {
                self.hideExceptDropDown()
            }
        }
        
        self.cvInOut.reloadData()
    }
    
    func getInOutCoordList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: InOutApi.inOutCoordList, success: { (response: ApiResponse<InOutCoordListRespnose>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("getInOutCoordList result : \(result)")
                if let coordList = result.data {
                    var isActive = false
                    for item in coordList {
                        if let myLocation = self.myLocation, let lttd = item.lttd, let lngt = item.lngt, let range = item.range {
                            let coordinate = CLLocation(latitude: Double(lttd)!, longitude: Double(lngt)!)
                            let distanceInMeters = myLocation.distance(from: coordinate) // result is in meters
//                            print("coordinate : \(coordinate)")
//                            print("distanceInMeters : \(distanceInMeters)")
//                            print("range : \(range)")
                            let dbRange = Double(range)!
                            if distanceInMeters <= dbRange {
//                                print("반경 내".localized)
                                isActive = true
                            }
                            
                        }
                    }
//
                    if self.isLocationServicesEnabled {
                        if isActive {
                            self.activateBtnIn()
                            self.activateBtnOut()
                        } else {
                            self.deactivateBtnIn()
                            self.deactivateBtnOut()
                        }
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func activateBtnIn(){
        self.btnIn.isEnabled = true
        self.btnIn.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
    }
    
    func deactivateBtnIn(){
        self.btnIn.isEnabled = false
        self.btnIn.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
    }
    func activateBtnOut(){
        self.btnOut.isEnabled = true
        self.btnOut.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
    }
    func deactivateBtnOut(){
        self.btnOut.isEnabled = false
        self.btnOut.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
    }
    func hideExceptDropDown(){
        exceptDropDown.isHidden = true
        exceptDropDownHeightAnchor?.isActive = false
        exceptDropDownHeightAnchor = exceptDropDown.heightAnchor.constraint(equalToConstant: 0)
        exceptDropDownHeightAnchor?.isActive = true
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func btnSaveClicked(){
        var lncYn = "N"
        if cbLaunch.isSelected {
            lncYn = "Y"
        }
        var dnrYn = "N"
        if cbDinner.isSelected {
            dnrYn = "Y"
        }
     
        var list:[FoodListStruct] = []
        var lncAdd = 0
        for item in launchShowFoodArray {
            lncAdd += item.addNum ?? 0
            list.append(FoodListStruct(ldCd: "L", addNm: item.addNm, addNum: item.addNum))
        }
        
        var dnrAdd = 0
       
        for item in dinnerShowFoodArray {
            dnrAdd += item.addNum ?? 0
            list.append(FoodListStruct(ldCd: "D", addNm: item.addNm, addNum: item.addNum))
        }
        if selectedlncLoc.isEmpty && lncYn == "Y" {
            let alert  = UIAlertController(title: "알림".localized, message: "중식 식당을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if selecteddnrLoc.isEmpty && dnrYn == "Y" {
            let alert  = UIAlertController(title: "알림".localized, message: "석식 식당을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let foodInsertRequest = FoodInsertRequest(lncYn: lncYn, lncLoc: selectedlncLoc, lncAdd: String(lncAdd), dnrYn: dnrYn, dnrLoc: selecteddnrLoc, dnrAdd: String(dnrAdd), list: list)
//        print("foodInsertRequest : \(foodInsertRequest)")
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: FoodAPi.foodInsert(param: foodInsertRequest), success: { (response: ApiResponse<FoodListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("foodInsertRequest result : \(result)")
                let alert  = UIAlertController(title: "알림".localized, message: "저장되었습니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
//                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
//                self.updateFoodUi(result: result)
                
            }

        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
          
          return
        }
    }
    
    func updateFoodUi(result:FoodListResponse){
        self.launchShowFoodArray.removeAll()
        self.dinnerShowFoodArray.removeAll()
        
        if let lncYn = result.data?.lncYn {
            print("updateFoodUi lncYn : \(lncYn)")
            if lncYn == "Y" {
                cbLaunch.isSelected = true
            } else {
                cbLaunch.isSelected = false
            }
        }
        if let lncLoc = result.data?.lncLoc {
            if lncLoc == "100" {
                launchDropDown.lblTitle.text = "본사".localized
            } else if lncLoc == "200" {
                launchDropDown.lblTitle.text = "공장".localized
            }
            selectedlncLoc = lncLoc
        }
        
        if let dnrYn = result.data?.dnrYn {
            if dnrYn == "Y" {
                cbDinner.isSelected = true
            } else {
                cbDinner.isSelected = false
            }
        }
        if let dnrLoc = result.data?.dnrLoc {
            if dnrLoc == "100" {
                dinnerDropDown.lblTitle.text = "본사".localized
            } else if dnrLoc == "200" {
                dinnerDropDown.lblTitle.text = "공장".localized
            }
            selecteddnrLoc = dnrLoc
        }
        
        if let list = result.data?.list{
            for item in list {
                if item.ldCd == "L" {
                    launchShowFoodArray.append(FoodStruct(ldCd: item.ldCd, addNm: item.addNm, addNum: item.addNum))
                } else if item.ldCd == "D"{
                    dinnerShowFoodArray.append(FoodStruct(ldCd: item.ldCd, addNm: item.addNm, addNum: item.addNum))
                }
            }
        }
        
        updateLaunchSum()
        updateDinnerSum()
        
        cvReload()
        
        self.setBtnStatus()
    }

    
    func onSelectChange(name: String, isSelected: Bool) {
        if name == "cbLaunch" {
            launchDropDown.isUserInteractionEnabled = isSelected
            btnLaunchAdd.isEnabled = isSelected
            for i in 0..<launchShowFoodArray.count {
                launchShowFoodArray[i].edit = isSelected
            }
            if(!isSelected) {
                launchDropDown.lblTitle.text = "식당 선택".localized
                selectedlncLoc = ""
                launchShowFoodArray.removeAll()
                updateLaunchSum()
            }
            cvReload()
        }
        if name == "cbDinner" {
            dinnerDropDown.isUserInteractionEnabled = isSelected
            btnDinnerAdd.isEnabled = isSelected
            for i in 0..<dinnerShowFoodArray.count {
                dinnerShowFoodArray[i].edit = isSelected
            }
            if(!isSelected) {
                dinnerDropDown.lblTitle.text = "식당 선택".localized
                selecteddnrLoc = ""
                dinnerShowFoodArray.removeAll()
                updateDinnerSum()
            }
            cvReload()
        }
    }
    
    func cvReload() {
        let cvLaunchTotalHeight = Double(launchShowFoodArray.count*51+8*(launchShowFoodArray.count-1))
        cvLaunchHeightAnchor?.isActive = false
        cvLaunchHeightAnchor = cvLaunch.heightAnchor.constraint(equalToConstant: CGFloat(cvLaunchTotalHeight))
        cvLaunchHeightAnchor?.isActive = true
        cvLaunch.reloadData()
        
        let cvDinnerTotalHeight = Double(dinnerShowFoodArray.count*51+8*(dinnerShowFoodArray.count-1))
        cvDinnerHeightAnchor?.isActive = false
        cvDinnerHeightAnchor = cvDinner.heightAnchor.constraint(equalToConstant: CGFloat(cvDinnerTotalHeight))
        cvDinnerHeightAnchor?.isActive = true
        cvDinner.reloadData()
    }
}

extension MainWaterRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvInOut {
            return 2
        } else if collectionView == cvLaunch {
            return launchShowFoodArray.count
        } else {
            return dinnerShowFoodArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvInOut {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterRegisterInOutCollectionViewCell.ID, for: indexPath) as! WaterRegisterInOutCollectionViewCell
            if indexPath.row < inoutArray.count {
                cell.lblTitle.text = inoutArray[indexPath.row].title
                let stDate = inoutArray[indexPath.row].date
                print("stDate : \(stDate)")
                if stDate.count > 10 {
                    let fromIndex = stDate.index(stDate.endIndex, offsetBy: -8)
                    let endIndex = stDate.index(stDate.endIndex,offsetBy:-3)
                    let finalDate = String(stDate[fromIndex..<endIndex])
                    cell.lblTime.text = finalDate
                }
            }
            return cell
        } else if collectionView == cvLaunch {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.ID, for: indexPath) as! LaunchCollectionViewCell
            cell.btnMinus.tag = indexPath.row
            cell.btnMinus.addTarget(self, action: #selector(btnLunchListMinusClicked), for: .touchUpInside)
            // cvLaunch tag = 101, 102, 103
            let stTag = "10\(indexPath.row)"
            cell.tfAddNm.tag = Int(stTag)!
            cell.tfAddNm.delegate = self
            
            let stNumTag = "11\(indexPath.row)"
            cell.tfAddNum.tag = Int(stNumTag)!
            cell.tfAddNum.delegate = self
            if indexPath.row < launchShowFoodArray.count {
                if let addNm = launchShowFoodArray[indexPath.row].addNm, !addNm.isEmpty {
                    cell.tfAddNm.text = addNm
                } else {
                    cell.tfAddNm.text = ""
                }
                
                if let addNum = launchShowFoodArray[indexPath.row].addNum {
                    cell.tfAddNum.text = String(addNum)
                } else {
                    cell.tfAddNum.text = ""
                }
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DinnerCollectionViewCell.ID, for: indexPath) as! DinnerCollectionViewCell
            cell.btnMinus.tag = indexPath.row
            cell.btnMinus.addTarget(self, action: #selector(btnDinnerListMinusClicked), for: .touchUpInside)
            // cvLaunch tag = 101, 102, 103
            let stTag = "20\(indexPath.row)"
            cell.tfAddNm.tag = Int(stTag)!
            cell.tfAddNm.delegate = self
            
            let stNumTag = "21\(indexPath.row)"
            cell.tfAddNum.tag = Int(stNumTag)!
            cell.tfAddNum.delegate = self
            if indexPath.row < dinnerShowFoodArray.count {
                if let addNm = dinnerShowFoodArray[indexPath.row].addNm, !addNm.isEmpty {
                    cell.tfAddNm.text = addNm
                } else {
                    cell.tfAddNm.text = ""
                }
                
                if let addNum = dinnerShowFoodArray[indexPath.row].addNum {
                    cell.tfAddNum.text = String(addNum)
                } else {
                    cell.tfAddNum.text = ""
                }
            }
            print("dinnerShowFoodArray : \(dinnerShowFoodArray)")
            cell.tfAddNm.isEnabled = dinnerShowFoodArray[indexPath.row].edit ?? true
            cell.tfAddNum.isEnabled = dinnerShowFoodArray[indexPath.row].edit ?? true
            cell.btnMinus.isEnabled = dinnerShowFoodArray[indexPath.row].edit ?? true
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvInOut {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 56)
        } else {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        }
        
    }
}

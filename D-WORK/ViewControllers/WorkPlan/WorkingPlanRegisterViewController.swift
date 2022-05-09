//
//  WorkingPlanRegisterViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit
import JGProgressHUD

class WorkingPlanRegisterViewController: UIViewController, CheckBoxProtocol, DropDownViewProtocol, UITextFieldDelegate, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    var previousViewController:UIViewController?
    var workPlanReportInfoData:WorkPlanReportInfoListData?
    
    let hud = JGProgressHUD()
    let scrollView = UIScrollView()
    let util = Util()
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "근무일자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let lblTotalTime: UILabel = {
        let label = UILabel()
        label.text = "총 계획시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    let lblDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    let lblTotalTimeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    //    let cvPlan = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let lblHeaderDate: UILabel = {
        let label = UILabel()
        label.text = "일자".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblTime: UILabel = {
        let label = UILabel()
        label.text = "시간".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkingHour: UILabel = {
        let label = UILabel()
        label.text = "근무시간".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblCdat: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblDelete: UILabel = {
        let label = UILabel()
        label.text = "삭제".localized
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblHeaderDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        return label
    }()
    
    let lblHeaderTimeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        return label
    }()
    
    let lblHeaderWorkingHourValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        return label
    }()
    
    let lblHeaderCdatValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 14)
        return label
    }()
    let lblHeaderDeleteValue: UIButton = {
        let button = UIButton()
        button.setTitle("삭제".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let lblEditTitle: UILabel = {
        let label = UILabel()
        label.text = "근무 계획 수정".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size:20)
        label.textColor = .black
        return label
    }()
    
    let lblTimeSeparate: UILabel = {
        let label = UILabel()
        label.text = "구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let ivOneDay:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-selected")
        return imageView
    }()
    let lblOneDay: UILabel = {
        let label = UILabel()
        label.text = "해당일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let ivPeriod:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    
    let lblPeriod: UILabel = {
        let label = UILabel()
        label.text = "기간설정".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblStartDate: UILabel = {
        let label = UILabel()
        label.text = "시작일자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblStartDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblEndDate: UILabel = {
        let label = UILabel()
        label.text = "종료일자".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblEndDateValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    // 적용구분
    let lblAdjust: UILabel = {
        let label = UILabel()
        label.text = "적용구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let cbHoliday:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblHoliday: UILabel = {
        let label = UILabel()
        label.text = "명절 포함".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let cbSaturDay:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblSaturDay: UILabel = {
        let label = UILabel()
        label.text = "토요일 포함".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let cbRestDay:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblRest: UILabel = {
        let label = UILabel()
        label.text = "공휴일 포함".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let cbEtcDay:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblEtcDay: UILabel = {
        let label = UILabel()
        label.text = "기타 포함".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let lblStartTime: UILabel = {
        let label = UILabel()
        label.text = "시작시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfStartTime: UITextField = {
        let textField = UITextField()
        textField.placeholder = "시작시간을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let lblEndTime: UILabel = {
        let label = UILabel()
        label.text = "종료시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfEndTime: UITextField = {
        let textField = UITextField()
        textField.placeholder = "종료시간을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let lblPlanTime: UILabel = {
        let label = UILabel()
        label.text = "계획시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblPlanTimeValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblCdat1: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblCdat2: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblCdat3: UILabel = {
        let label = UILabel()
        label.text = "근태".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var cdat1DropDown = DropDownBtn()
    var cdat2DropDown = DropDownBtn()
    var cdat3DropDown = DropDownBtn()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let summaryView = UIView()
        scrollView.addSubview(summaryView)
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        
        summaryView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        summaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        summaryView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        summaryView.layer.borderWidth = 1
        summaryView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        summaryView.layer.cornerRadius = 8
        
        scrollView.addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 24).isActive = true
        lblDate.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 23).isActive = true
        lblDate.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(lblTotalTime)
        lblTotalTime.translatesAutoresizingMaskIntoConstraints = false
        lblTotalTime.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -24).isActive = true
        lblTotalTime.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 23).isActive = true
        lblTotalTime.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        scrollView.addSubview(lblDateValue)
        lblDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblDateValue.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -25).isActive = true
        lblDateValue.centerYAnchor.constraint(equalTo: lblDate.centerYAnchor).isActive = true
        
        scrollView.addSubview(lblTotalTimeValue)
        lblTotalTimeValue.translatesAutoresizingMaskIntoConstraints = false
        lblTotalTimeValue.centerYAnchor.constraint(equalTo: lblTotalTime.centerYAnchor).isActive = true
        lblTotalTimeValue.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -25).isActive = true
        
        let headerView = UIView()
        scrollView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 24).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 83).isActive = true
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        headerView.layer.cornerRadius = 8
        
        headerView.addSubview(lblHeaderDate)
        lblHeaderDate.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderDate.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        lblHeaderDate.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 14).isActive = true
        lblHeaderDate.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        headerView.addSubview(lblTime)
        lblTime.translatesAutoresizingMaskIntoConstraints = false
        lblTime.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        lblTime.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 73).isActive = true
        lblTime.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        headerView.addSubview(lblWorkingHour)
        lblWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingHour.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        lblWorkingHour.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 120).isActive = true
        lblWorkingHour.widthAnchor.constraint(equalToConstant: 104).isActive = true
        
        headerView.addSubview(lblCdat)
        lblCdat.translatesAutoresizingMaskIntoConstraints = false
        lblCdat.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        lblCdat.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 224).isActive = true
        lblCdat.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        headerView.addSubview(lblDelete)
        lblDelete.translatesAutoresizingMaskIntoConstraints = false
        lblDelete.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 17).isActive = true
        lblDelete.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -22).isActive = true
        lblDelete.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        headerView.addSubview(lblHeaderDateValue)
        lblHeaderDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderDateValue.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46).isActive = true
        lblHeaderDateValue.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        lblHeaderDateValue.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        headerView.addSubview(lblHeaderTimeValue)
        lblHeaderTimeValue.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderTimeValue.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46).isActive = true
        lblHeaderTimeValue.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 73).isActive = true
        lblHeaderTimeValue.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        headerView.addSubview(lblHeaderWorkingHourValue)
        lblHeaderWorkingHourValue.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderWorkingHourValue.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46).isActive = true
        lblHeaderWorkingHourValue.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 120).isActive = true
        lblHeaderWorkingHourValue.widthAnchor.constraint(equalToConstant: 104).isActive = true
        
        headerView.addSubview(lblHeaderCdatValue)
        lblHeaderCdatValue.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderCdatValue.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 46).isActive = true
        lblHeaderCdatValue.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 224).isActive = true
        lblHeaderCdatValue.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        headerView.addSubview(lblHeaderDeleteValue)
        lblHeaderDeleteValue.translatesAutoresizingMaskIntoConstraints = false
        lblHeaderDeleteValue.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 39).isActive = true
        lblHeaderDeleteValue.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15).isActive = true
        lblHeaderDeleteValue.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lblHeaderDeleteValue.heightAnchor.constraint(equalToConstant: 31).isActive = true
        lblHeaderDeleteValue.isUserInteractionEnabled = true
        lblHeaderDeleteValue.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        
        scrollView.addSubview(lblEditTitle)
        lblEditTitle.translatesAutoresizingMaskIntoConstraints = false
        lblEditTitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32).isActive = true
        lblEditTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblEditTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let divider1 = UIView()
        scrollView.addSubview(divider1)
        divider1.translatesAutoresizingMaskIntoConstraints = false
        divider1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider1.topAnchor.constraint(equalTo: lblEditTitle.bottomAnchor, constant: 16).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider1.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(lblTimeSeparate)
        lblTimeSeparate.translatesAutoresizingMaskIntoConstraints = false
        lblTimeSeparate.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 17).isActive = true
        lblTimeSeparate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblTimeSeparate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(ivOneDay)
        ivOneDay.translatesAutoresizingMaskIntoConstraints = false
        ivOneDay.centerYAnchor.constraint(equalTo: lblTimeSeparate.centerYAnchor).isActive = true
        ivOneDay.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        ivOneDay.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivOneDay.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivOneDay.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido1))
        ivOneDay.addGestureRecognizer(tap)
        
        scrollView.addSubview(lblOneDay)
        lblOneDay.translatesAutoresizingMaskIntoConstraints = false
        lblOneDay.centerYAnchor.constraint(equalTo: ivOneDay.centerYAnchor).isActive = true
        lblOneDay.leadingAnchor.constraint(equalTo: ivOneDay.trailingAnchor, constant: 8).isActive = true
        lblOneDay.isUserInteractionEnabled = true
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido1))
        lblOneDay.addGestureRecognizer(tap2)
        
        scrollView.addSubview(ivPeriod)
        ivPeriod.translatesAutoresizingMaskIntoConstraints = false
        ivPeriod.centerYAnchor.constraint(equalTo: lblOneDay.centerYAnchor).isActive = true
        ivPeriod.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 241).isActive = true
        ivPeriod.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivPeriod.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivPeriod.isUserInteractionEnabled = true
        let tap3: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido2))
        ivPeriod.addGestureRecognizer(tap3)
        
        scrollView.addSubview(lblPeriod)
        lblPeriod.translatesAutoresizingMaskIntoConstraints = false
        lblPeriod.centerYAnchor.constraint(equalTo: ivOneDay.centerYAnchor).isActive = true
        lblPeriod.leadingAnchor.constraint(equalTo: ivPeriod.trailingAnchor, constant: 8).isActive = true
        lblPeriod.isUserInteractionEnabled = true
        let tap4: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido2))
        lblPeriod.addGestureRecognizer(tap4)
        
        let divider2 = UIView()
        scrollView.addSubview(divider2)
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.topAnchor.constraint(equalTo: lblTimeSeparate.bottomAnchor, constant: 19).isActive = true
        divider2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider2.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        // 시작일자
        scrollView.addSubview(lblStartDate)
        lblStartDate.translatesAutoresizingMaskIntoConstraints = false
        lblStartDate.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 16).isActive = true
        lblStartDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblStartDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblStartDateValue)
        lblStartDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblStartDateValue.centerYAnchor.constraint(equalTo: lblStartDate.centerYAnchor).isActive = true
        lblStartDateValue.leadingAnchor.constraint(equalTo: lblStartDate.trailingAnchor, constant: 38).isActive = true
        lblStartDateValue.isUserInteractionEnabled = true
        let lblStartDateValueTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lblStartDateValueClicked))
        lblStartDateValue.addGestureRecognizer(lblStartDateValueTap)
        
        // 종료일자
        let divider3 = UIView()
        scrollView.addSubview(divider3)
        divider3.translatesAutoresizingMaskIntoConstraints = false
        divider3.topAnchor.constraint(equalTo: lblStartDate.bottomAnchor, constant: 18).isActive = true
        divider3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider3.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(lblEndDate)
        lblEndDate.translatesAutoresizingMaskIntoConstraints = false
        lblEndDate.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 16).isActive = true
        lblEndDate.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblEndDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblEndDateValue)
        lblEndDateValue.translatesAutoresizingMaskIntoConstraints = false
        lblEndDateValue.centerYAnchor.constraint(equalTo: lblEndDate.centerYAnchor).isActive = true
        lblEndDateValue.leadingAnchor.constraint(equalTo: lblEndDate.trailingAnchor, constant: 38).isActive = true
        lblEndDateValue.isUserInteractionEnabled = true
        let lblEndDateValueTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lblEndDateValueClicked))
        lblEndDateValue.addGestureRecognizer(lblEndDateValueTap)
        
        
        // 적용구분
        let divider4 = UIView()
        scrollView.addSubview(divider4)
        divider4.translatesAutoresizingMaskIntoConstraints = false
        divider4.topAnchor.constraint(equalTo: lblEndDate.bottomAnchor, constant: 18).isActive = true
        divider4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider4.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(lblAdjust)
        lblAdjust.translatesAutoresizingMaskIntoConstraints = false
        lblAdjust.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 16).isActive = true
        lblAdjust.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        //        lblAdjust.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(cbRestDay)
        cbRestDay.translatesAutoresizingMaskIntoConstraints = false
        //        cbHoliday.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 13).isActive = true
        cbRestDay.centerYAnchor.constraint(equalTo: lblAdjust.centerYAnchor).isActive = true
        cbRestDay.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        cbRestDay.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbRestDay.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbRestDay.delegate = self
        cbRestDay.name = "cbRestDay"
        
        scrollView.addSubview(lblRest)
        lblRest.translatesAutoresizingMaskIntoConstraints = false
        lblRest.centerYAnchor.constraint(equalTo: cbRestDay.centerYAnchor).isActive = true
        lblRest.leadingAnchor.constraint(equalTo: cbRestDay.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(cbSaturDay)
        cbSaturDay.translatesAutoresizingMaskIntoConstraints = false
        cbSaturDay.centerYAnchor.constraint(equalTo: lblAdjust.centerYAnchor).isActive = true
        cbSaturDay.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 241).isActive = true
        cbSaturDay.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbSaturDay.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbSaturDay.delegate = self
        cbSaturDay.name = "cbSaturDay"
        
        scrollView.addSubview(lblSaturDay)
        lblSaturDay.translatesAutoresizingMaskIntoConstraints = false
        lblSaturDay.centerYAnchor.constraint(equalTo: cbSaturDay.centerYAnchor).isActive = true
        lblSaturDay.leadingAnchor.constraint(equalTo: cbSaturDay.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(cbHoliday)
        cbHoliday.translatesAutoresizingMaskIntoConstraints = false
        //        cbHoliday.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 13).isActive = true
        cbHoliday.topAnchor.constraint(equalTo: cbRestDay.bottomAnchor, constant: 16).isActive = true
        cbHoliday.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        cbHoliday.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbHoliday.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbHoliday.delegate = self
        cbHoliday.name = "cbHoliday"
        
        scrollView.addSubview(lblHoliday)
        lblHoliday.translatesAutoresizingMaskIntoConstraints = false
        lblHoliday.centerYAnchor.constraint(equalTo: cbHoliday.centerYAnchor).isActive = true
        lblHoliday.leadingAnchor.constraint(equalTo: cbHoliday.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(cbEtcDay)
        cbEtcDay.translatesAutoresizingMaskIntoConstraints = false
        cbEtcDay.centerYAnchor.constraint(equalTo: cbHoliday.centerYAnchor).isActive = true
        cbEtcDay.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 241).isActive = true
        cbEtcDay.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbEtcDay.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbEtcDay.delegate = self
        cbEtcDay.name = "cbEtcDay"
        
        scrollView.addSubview(lblEtcDay)
        lblEtcDay.translatesAutoresizingMaskIntoConstraints = false
        lblEtcDay.centerYAnchor.constraint(equalTo: cbEtcDay.centerYAnchor).isActive = true
        lblEtcDay.leadingAnchor.constraint(equalTo: cbEtcDay.trailingAnchor, constant: 8).isActive = true
        
        // 시작시간, 종료시간
        let divider5 = UIView()
        scrollView.addSubview(divider5)
        divider5.translatesAutoresizingMaskIntoConstraints = false
        divider5.topAnchor.constraint(equalTo: cbEtcDay.bottomAnchor, constant: 16).isActive = true
        divider5.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider5.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider5.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(lblStartTime)
        lblStartTime.translatesAutoresizingMaskIntoConstraints = false
        lblStartTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblStartTime.topAnchor.constraint(equalTo: divider5.bottomAnchor, constant: 33).isActive = true
        lblStartTime.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfStartTime)
        tfStartTime.delegate = self
        tfStartTime.translatesAutoresizingMaskIntoConstraints = false
        tfStartTime.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tfStartTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        tfStartTime.centerYAnchor.constraint(equalTo: lblStartTime.centerYAnchor).isActive = true
        tfStartTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfStartTime.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        scrollView.addSubview(lblEndTime)
        lblEndTime.translatesAutoresizingMaskIntoConstraints = false
        lblEndTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblEndTime.topAnchor.constraint(equalTo: tfStartTime.bottomAnchor, constant: 42).isActive = true
        lblEndTime.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(tfEndTime)
        tfEndTime.delegate = self
        tfEndTime.translatesAutoresizingMaskIntoConstraints = false
        tfEndTime.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tfEndTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        tfEndTime.centerYAnchor.constraint(equalTo: lblEndTime.centerYAnchor).isActive = true
        tfEndTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfEndTime.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        scrollView.addSubview(lblPlanTime)
        lblPlanTime.translatesAutoresizingMaskIntoConstraints = false
        lblPlanTime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblPlanTime.topAnchor.constraint(equalTo: lblEndTime.bottomAnchor, constant: 33).isActive = true
        lblPlanTime.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblPlanTimeValue)
        lblPlanTimeValue.translatesAutoresizingMaskIntoConstraints = false
        lblPlanTimeValue.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 117).isActive = true
        lblPlanTimeValue.centerYAnchor.constraint(equalTo: lblPlanTime.centerYAnchor).isActive = true
        
        let divider6 = UIView()
        scrollView.addSubview(divider6)
        divider6.translatesAutoresizingMaskIntoConstraints = false
        divider6.topAnchor.constraint(equalTo: lblPlanTime.bottomAnchor, constant: 24).isActive = true
        divider6.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider6.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider6.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider6.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(lblCdat1)
        lblCdat1.translatesAutoresizingMaskIntoConstraints = false
        lblCdat1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblCdat1.topAnchor.constraint(equalTo: divider6.bottomAnchor, constant: 34).isActive = true
        lblCdat1.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblCdat2)
        lblCdat2.translatesAutoresizingMaskIntoConstraints = false
        lblCdat2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblCdat2.topAnchor.constraint(equalTo: divider6.bottomAnchor, constant: 93).isActive = true
        lblCdat2.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        scrollView.addSubview(lblCdat3)
        lblCdat3.translatesAutoresizingMaskIntoConstraints = false
        lblCdat3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblCdat3.topAnchor.constraint(equalTo: divider6.bottomAnchor, constant: 152).isActive = true
        lblCdat3.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let divider7 = UIView()
        scrollView.addSubview(divider7)
        divider7.translatesAutoresizingMaskIntoConstraints = false
        divider7.topAnchor.constraint(equalTo: lblCdat3.bottomAnchor, constant: 33).isActive = true
        divider7.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider7.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider7.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.topAnchor.constraint(equalTo: divider7.bottomAnchor, constant: 16).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        
        initial()
    }
    
    //    var planList:[WorkingPlanDetailListResponse] = []
    var monthPlanList:[WorkingPlanDetailListResponse] = []
    var monthPlan:WorkingPlanDetailListResponse?
    var prsnCdParam: String?
    //    var selectedDate = ""
    
    var cdatList:[String] = []
    var getCdatList:[CodeListDetailResponse] = []
    var restReadData:WorkingPlanRestReadDetailResponse?
    
    
    var isOneDay = true
    var selectedStartDate = Date()
    var selectedEndDate = Date()
    //    var stStartTime = ""
    //    var stEndTime = ""
    //    var finalHours = 0.0
    //    var yyyymm = ""
    
    let dateFormatter = DateFormatter()
    let yyyymmddFormatter = DateFormatter()
    let yyyyTmmTddTFormatter = DateFormatter()
    let yyyyDmmDddTFormatter = DateFormatter()
    let yyyymmFormatter = DateFormatter()
    let hhmmFormatter = DateFormatter()
    let ddFormatter = DateFormatter()
    
    func initial() {
        getRestRead()
        updateDropDown()
        
        yyyymmddFormatter.dateFormat = "yyyyMMdd"
        yyyymmddFormatter.locale = Locale(identifier:"ko_KR")
        yyyyTmmTddTFormatter.dateFormat = "yyyy년 MM월 dd일".localized
        yyyyDmmDddTFormatter.dateFormat = "yyyy-MM-dd"
        hhmmFormatter.dateFormat = "HHmm"
        ddFormatter.dateFormat = "dd"
        
        setData()
        
        hideKeyboardWhenTappedAround()
    }
    
    func setData() {
        if let selectedDate = yyyymmddFormatter.date(from: monthPlan?.yyyymmdd ?? "") {
            let weekday = Calendar.current.component(.weekday, from: selectedDate)
            lblHeaderDateValue.text = "\(String(ddFormatter.string(from: selectedDate)))(\(util.getWeekDayFromNum(num: weekday)))"
            if monthPlan?.week == "S" {
                lblHeaderDateValue.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
            } else if monthPlan?.week == "M" || monthPlan?.week == "H" {
                lblHeaderDateValue.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            }
            
            let d = yyyyTmmTddTFormatter.string(from: selectedDate)
            lblDateValue.text = d
            selectedStartDate = selectedDate
            selectedEndDate = selectedDate
            
            let ymd = yyyyDmmDddTFormatter.string(from: selectedDate)
            lblStartDateValue.text = ymd
            lblEndDateValue.text = ymd
        }
        
        if let comeTime = monthPlan?.comeTime, let leaveTime = monthPlan?.leaveTime {
            let editComeStart = String(comeTime.prefix(2))
            let editComeEnd = (comeTime.suffix(2))
            let editLeaveStart = String(leaveTime.prefix(2))
            let editLeaveEnd = String(leaveTime.suffix(2))
            lblHeaderWorkingHourValue.text = "\(editComeStart):\(editComeEnd)~\(editLeaveStart):\(editLeaveEnd)"
            
            tfStartTime.text = monthPlan?.comeTime
            tfEndTime.text = monthPlan?.leaveTime
            
            toggleRaido1()
        }else {
            lblHeaderWorkingHourValue.text = ""
            
            tfStartTime.text = ""
            tfEndTime.text = ""
        }
        
        if let workTime = monthPlan?.workTime {
            lblTotalTimeValue.text = "\(workTime)"
            lblHeaderTimeValue.text = "\(workTime)"
            lblPlanTimeValue.text = String(monthPlan?.workTime ?? 0) + "시간".localized
        }else {
            lblTotalTimeValue.text = ""
            lblHeaderTimeValue.text = ""
            lblPlanTimeValue.text = ""
        }
        
        if monthPlan?.cdat1 != nil || monthPlan?.cdat2 != nil || monthPlan?.cdat3 != nil{
            if let cdat3 = monthPlan?.cdat3 {
                for item in getCdatList {
                    if item.subCd == cdat3 {
                        lblHeaderCdatValue.text = item.subNm
                    }
                }
            }
            if let cdat2 = monthPlan?.cdat2 {
                for item in getCdatList {
                    if item.subCd == cdat2 {
                        lblHeaderCdatValue.text = item.subNm
                    }
                }
            }
            
            if let cdat1 = monthPlan?.cdat1 {
                for item in getCdatList {
                    if item.subCd == cdat1 {
                        lblHeaderCdatValue.text = item.subNm
                    }
                }
            }
        }else {
            lblHeaderCdatValue.text = ""
        }
    }
    
    //휴게시간 조회
    func getRestRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        if let yyyymmdd: String = monthPlan?.yyyymmdd {
            let yyyymm = yyyymmdd.left(6)
            ApiService.request(router: WorkPlanApi.restRead(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingPlanRestReadResponse>) in
                self.hud.dismiss()
                if let result = response.value {
                    if let list = result.data {
                        self.restReadData = list
                    }
                }
            }) { (error) in
                self.hud.dismiss()
            }
        }
    }
    
    //구분 선택
    @objc func toggleRaido1(){
        isOneDay = true
        ivOneDay.image = UIImage(named: "radio-selected")
        ivPeriod.image = UIImage(named: "radio-unselected")
        lblOneDay.textColor = .black
        lblPeriod.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        if let data = yyyymmddFormatter.date(from: monthPlan?.yyyymmdd ?? "") {
            let ymd = yyyyDmmDddTFormatter.string(from: data)
            lblStartDateValue.text = ymd
            lblEndDateValue.text = ymd
        }
        lblStartDateValue.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        lblEndDateValue.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        lblRest.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        self.onSelectChange(name: "cbRestDay", isSelected: false)
        self.onSelectChange(name: "cbHoliday", isSelected: false)
        self.onSelectChange(name: "cbSaturDay", isSelected: false)
        self.onSelectChange(name: "cbEtcDay", isSelected: false)
    }
    @objc func toggleRaido2(){
        isOneDay = false
        ivOneDay.image = UIImage(named: "radio-unselected")
        ivPeriod.image = UIImage(named: "radio-selected")
        lblOneDay.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        lblPeriod.textColor = .black
        
        lblStartDateValue.textColor = .black
        lblEndDateValue.textColor = .black
        lblRest.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        self.onSelectChange(name: "cbRestDay", isSelected: true)
        self.onSelectChange(name: "cbHoliday", isSelected: true)
        self.onSelectChange(name: "cbSaturDay", isSelected: true)
        self.onSelectChange(name: "cbEtcDay", isSelected: true)
    }
    
    //시작일자 선택
    @objc func lblStartDateValueClicked(){
        if self.isOneDay {
            return
        }
        let timePicker = UIDatePicker()
        timePicker.setDate(selectedStartDate, animated: false)
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
        
        if let ymd:String = monthPlan?.yyyymmdd, let d = self.yyyymmddFormatter.date(from: ymd) {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month], from: d)
            
            let startOfMonth = calendar.date(from: components)!
            let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
            let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
            let en = calendar.dateComponents([.year, .month, .day, .weekday, .weekOfMonth], from: endOfMonth!)
            
            timePicker.minimumDate = self.yyyymmddFormatter.date(from: (ymd.left(6) + "01"))
            if let maxDay = en.day {
                let maxDate = ymd.left(6) + String(maxDay)
                timePicker.maximumDate = self.yyyymmddFormatter.date(from: maxDate)
            }
        }
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            self.lblStartDateValue.text = self.yyyyDmmDddTFormatter.string(from: self.selectedStartDate)
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
    
    //종료일자 선택
    @objc func lblEndDateValueClicked(){
        if self.isOneDay {
            return
        }
        let timePicker = UIDatePicker()
        timePicker.setDate(self.selectedEndDate, animated: false)
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        timePicker.datePickerMode = .date
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        timePicker.minuteInterval = 30
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
        timePicker.backgroundColor = alert.view.backgroundColor
        
        if let ymd:String = monthPlan?.yyyymmdd, let d = self.yyyymmddFormatter.date(from: ymd) {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month], from: d)
            
            let startOfMonth = calendar.date(from: components)!
            let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
            let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
            let en = calendar.dateComponents([.year, .month, .day, .weekday, .weekOfMonth], from: endOfMonth!)
            
            timePicker.minimumDate = self.yyyymmddFormatter.date(from: (ymd.left(6) + "01"))
            if let maxDay = en.day {
                let maxDate = ymd.left(6) + String(maxDay)
                timePicker.maximumDate = self.yyyymmddFormatter.date(from: maxDate)
            }
        }
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            self.lblEndDateValue.text = self.yyyyDmmDddTFormatter.string(from: self.selectedEndDate)
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
    
    //적용구분 선택
    func onSelectChange(name: String, isSelected: Bool) {
        switch name {
        case "cbRestDay":
            if cbRestDay.isSelected {
                lblRest.textColor = .black
            } else {
                lblRest.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            }
        case "cbHoliday":
            if cbHoliday.isSelected {
                lblHoliday.textColor = .black
            } else {
                lblHoliday.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            }
        case "cbSaturDay":
            if cbSaturDay.isSelected {
                lblSaturDay.textColor = .black
            } else {
                lblSaturDay.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            }
        case "cbEtcDay":
            if cbEtcDay.isSelected {
                lblEtcDay.textColor = .black
            } else {
                lblEtcDay.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            }
        default:
            print("")
        }
    }
    
    //근태 설정
    func updateDropDown(){
        self.cdatList.append("내용을 선택하세요".localized)
        for item in getCdatList {
            self.cdatList.append(item.subNm ?? "")
        }
        
        cdat1DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cdat1DropDown.name = "cdat1DropDown"
        if (self.monthPlan?.cdat1 ?? "") != "" {
            for item in getCdatList {
                if let subCd = item.subCd {
                    if(subCd == self.monthPlan?.cdat1) {
                        cdat1DropDown.stTitle = item.subNm!
                    }
                }
            }
        }else {
            cdat1DropDown.stTitle = cdatList[0]
            cdat1DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        cdat1DropDown.delegate = self
        cdat1DropDown.dropView.dropDownOptions = self.cdatList
        
        scrollView.addSubview(cdat1DropDown)
        cdat1DropDown.translatesAutoresizingMaskIntoConstraints = false
        cdat1DropDown.centerYAnchor.constraint(equalTo: lblCdat1.centerYAnchor).isActive = true
        cdat1DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        cdat1DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdat1DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cdat2DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cdat2DropDown.name = "cdat2DropDown"
        if (self.monthPlan?.cdat2 ?? "") != "" {
            for item in getCdatList {
                if let subCd = item.subCd {
                    if(subCd == self.monthPlan?.cdat2) {
                        cdat2DropDown.stTitle = item.subNm!
                    }
                }
            }
        }else {
            cdat2DropDown.stTitle = cdatList[0]
            cdat2DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        cdat2DropDown.delegate = self
        cdat2DropDown.dropView.dropDownOptions = self.cdatList
        
        scrollView.addSubview(cdat2DropDown)
        cdat2DropDown.translatesAutoresizingMaskIntoConstraints = false
        cdat2DropDown.centerYAnchor.constraint(equalTo: lblCdat2.centerYAnchor).isActive = true
        cdat2DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        cdat2DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdat2DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cdat3DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cdat3DropDown.name = "cdat3DropDown"
        if (self.monthPlan?.cdat3 ?? "") != "" {
            for item in getCdatList {
                if let subCd = item.subCd {
                    if(subCd == self.monthPlan?.cdat3) {
                        cdat3DropDown.stTitle = item.subNm!
                    }
                }
            }
        }else {
            cdat3DropDown.stTitle = cdatList[0]
            cdat3DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        
        cdat3DropDown.delegate = self
        cdat3DropDown.dropView.dropDownOptions = self.cdatList
        
        scrollView.addSubview(cdat3DropDown)
        cdat3DropDown.translatesAutoresizingMaskIntoConstraints = false
        cdat3DropDown.centerYAnchor.constraint(equalTo: lblCdat3.centerYAnchor).isActive = true
        cdat3DropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 118).isActive = true
        cdat3DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdat3DropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func dropDownPressed(name: String, string: String) {
        if name == "cdat1DropDown" {
            cdat1DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getCdatList {
                if item.subNm == string {
                    monthPlan?.cdat1 = item.subCd ?? ""
                    cdat1DropDown.lblTitle.textColor = .black
                    calculatePlanTIme()
                }
            }
        } else if name == "cdat2DropDown" {
            cdat2DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getCdatList {
                if item.subNm == string {
                    monthPlan?.cdat2 = item.subCd ?? ""
                    cdat2DropDown.lblTitle.textColor = .black
                    calculatePlanTIme()
                }
            }
        } else if name == "cdat3DropDown"{
            cdat3DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getCdatList {
                if item.subNm == string {
                    monthPlan?.cdat3 = item.subCd ?? ""
                    cdat3DropDown.lblTitle.textColor = .black
                    calculatePlanTIme()
                }
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let time = textField.text {
            if time.count > 4 {
                textField.text = time.left(4)
            }
            if time.count == 4 {
                let timeRegExp = "^([1-9]|[01][0-9]|2[0-3])([0-5][0-9])$";
                let regex = try? NSRegularExpression(pattern: timeRegExp)
                guard let _ = regex!.firstMatch(in: time, options: [], range: NSRange(location: 0, length: time.count)) else {
                    textField.text = ""
                    return
                }
                calculatePlanTIme()
            }else {
                lblPlanTimeValue.text = ""
            }
        }
    }
    
    //근무시간 계산
    func calculatePlanTIme(){
        if monthPlan?.cdat1 == "94" || monthPlan?.cdat2 == "94" || monthPlan?.cdat3 == "94" {
            tfStartTime.text = restReadData?.stba23
            tfStartTime.isEnabled = false
            tfEndTime.text = restReadData?.enba23
            tfEndTime.isEnabled = false
        }
        if monthPlan?.cdat1 == "95" || monthPlan?.cdat2 == "95" || monthPlan?.cdat3 == "95" {
            tfStartTime.text = restReadData?.stbm23
            tfStartTime.isEnabled = false
            tfEndTime.text = restReadData?.stba23
            tfEndTime.isEnabled = false
        }
        
        let nonEditCdat = ["50", "51", "53", "90", "91"];
        if nonEditCdat.contains(monthPlan?.cdat1 ?? "") || nonEditCdat.contains(monthPlan?.cdat2 ?? "") || nonEditCdat.contains(monthPlan?.cdat3 ?? "") {
            tfStartTime.text = ""
            tfStartTime.isEnabled = false
            tfEndTime.text = ""
            tfEndTime.isEnabled = false
        }
        
        if let stStartTime = tfStartTime.text, stStartTime != "", let stEndTime = tfEndTime.text, stEndTime != "" {
            let tripEditCdat = ["17", "18", "19", "61"];
            let fr = stStartTime
            let to = stEndTime
            var mealTime:[String] = []
            var restTime:[String] = []
            var frMin = 0
            var toMin = 0
            
            if tripEditCdat.contains(monthPlan?.cdat1 ?? "") || tripEditCdat.contains(monthPlan?.cdat2 ?? "") || tripEditCdat.contains(monthPlan?.cdat3 ?? "") {
                //"17", "18", "19", "61" 중에 속할 경우 출장으로 판단.
                frMin = util.fnCalcFureHHMM2Min(time: fr); //시작시간 분으로 변환(출장의 경우 최초 출근가능시간 07:30 미적용)
                toMin = util.fnCalcHHMM2Min(str: to, getComeTime: frMin); //종료시간 분으로 변환
                mealTime = [util.fnCalcMin2HHMM(getMin: frMin + 240), util.fnCalcMin2HHMM(getMin: frMin + 540)]; //1시간 휴식시간
                restTime = [util.fnCalcMin2HHMM(getMin:frMin + 730), util.fnCalcMin2HHMM(getMin:frMin + 1050), util.fnCalcMin2HHMM(getMin: frMin + 1320)]; //30분 휴식시간
            } else {
                //출장이 아닐 경우
                //출근시간이 7시 30분 이전일 수 없다.
                let timeOver = "0730"
                if hhmmFormatter.date(from: stStartTime)! < hhmmFormatter.date(from: timeOver)! {
                    tfStartTime.text = ""
                    monthPlan?.comeTime = ""
                    return
                }
                
                mealTime = [restReadData?.stTLs ?? "", restReadData?.stTDs ?? ""]; //"3.4.3 근무계획 휴게시간 조회"의 stTLs, stTDs
                restTime = [restReadData?.stTBs ?? "", restReadData?.stTNs ?? "", restReadData?.stTMs ?? ""]; //"3.4.3 근무계획 휴게시간 조회"의 stTBs, stTNs, stTMs
                frMin = util.fnCalcHHMM2Min(str: fr, getComeTime: nil); //시작시간 분으로 변환
                toMin = util.fnCalcHHMM2Min(str: to, getComeTime: frMin); //종료시간 분으로 변환
            }
            var min = toMin - frMin; //휴게시간 제외 전 근무시간 계산
            //1시간 휴게시간 계산
            for item in mealTime {
                let s = util.fnCalcHHMM2Min(str: item, getComeTime: nil); //휴게시작시간 분
                let e = s + 60; //휴게종료시간 분
                let ss = [frMin, s].max() ?? 0
                let ee = [toMin, e].min() ?? 0
                min -= [ee-ss, 0].max() ?? 0
            }
            //30분 휴게시간 계산
            for item in restTime {
                let s = util.fnCalcHHMM2Min(str: item, getComeTime: nil); //휴게시작시간 분
                let e = s + 30; //휴게종료시간 분
                let ss = [frMin, s].max() ?? 0
                let ee = [toMin, e].min() ?? 0
                min -= [ee-ss, 0].max() ?? 0
            }
            monthPlan?.comeTime = stStartTime
            monthPlan?.leaveTime = stEndTime
            monthPlan?.workTime = util.fnCalcMinToHdotM(min: min)
            lblPlanTimeValue.text = (String(monthPlan?.workTime ?? 0)  + "시간".localized)
        }else {
            monthPlan?.comeTime = ""
            monthPlan?.leaveTime = ""
            monthPlan?.workTime = 0
            lblPlanTimeValue.text = ""
        }
    }
    
    @objc func btnDeleteClicked(){
        monthPlan?.workTime = nil
        monthPlan?.comeTime = nil
        monthPlan?.leaveTime = nil
        monthPlan?.cdat1 = nil
        monthPlan?.cdat2 = nil
        monthPlan?.cdat3 = nil
        cdat1DropDown.stTitle = cdatList[0]
        cdat1DropDown.lblTitle.text = self.cdatList[0]
        cdat1DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        cdat2DropDown.stTitle = cdatList[0]
        cdat2DropDown.lblTitle.text = self.cdatList[0]
        cdat2DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        cdat3DropDown.stTitle = cdatList[0]
        cdat3DropDown.lblTitle.text = self.cdatList[0]
        cdat3DropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        setData()
    }
    
    @objc func btnSaveClicked(){
        let yyyymmdd = monthPlan?.yyyymmdd ?? ""
        var list:[WorkingPlanUpdateListRequest] = [
            WorkingPlanUpdateListRequest(
                yyyymmdd: yyyymmdd,
                comeTime: monthPlan?.comeTime ?? "",
                leaveTime: monthPlan?.leaveTime ?? "",
                workTime: String(monthPlan?.workTime ?? 0),
                cdat1: monthPlan?.cdat1 ?? "",
                cdat2: monthPlan?.cdat2 ?? "",
                cdat3: monthPlan?.cdat3 ?? "")
        ]
        
        if !isOneDay {
            let elapsedTime = selectedEndDate.timeIntervalSince(selectedStartDate)
            let diffDays = Int(elapsedTime / (60*60*24) )
            let calendar = Calendar.current
            var periodStartDate = selectedStartDate
            for _ in 0..<diffDays {
                periodStartDate = calendar.date(byAdding: .day, value: 1, to: periodStartDate)!
                let newStDate = yyyymmddFormatter.string(from: periodStartDate)
                var newItem = list[0]
                newItem.yyyymmdd = newStDate
                list.append(newItem)
            }
            for monthPlanDay in monthPlanList {
                list = list.filter({(requestIem: WorkingPlanUpdateListRequest) -> Bool in
                    if let yyyymmdd = monthPlanDay.yyyymmdd, yyyymmdd == requestIem.yyyymmdd {
                        if (!cbRestDay.isSelected && monthPlanDay.week == "H")
                            || (!cbHoliday.isSelected && monthPlanDay.week == "M")
                            || (!cbSaturDay.isSelected && monthPlanDay.week == "S")
                            || (!cbEtcDay.isSelected && monthPlanDay.week == "E") {
                            return false
                        }
                    }
                    return true})
            }
        }
        
        if let previousViewController = previousViewController as? WorkPlanReportStep2ViewController{
            ApiService.request(router: WorkPlanReportApi.update(
                param: WorkingPlanReportUpdateRequest(
                    yyyymm: yyyymmdd.left(6),
                    prsnCdParam: self.prsnCdParam ?? "",
                    list: list)), success: { (response: ApiResponse<WorkingPlanListResponse>) in
                    self.hud.dismiss()
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
        } else {
            ApiService.request(router: WorkPlanApi.update(
                param: WorkingPlanUpdateRequest(yyyymm: yyyymmdd.left(6), list: list)), success: { (response: ApiResponse<WorkingPlanListResponse>) in
                    self.hud.dismiss()
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    func getWorkingplan(){
    //        hud.textLabel.text = "Loading"
    //        hud.show(in: self.view)
    //        self.planList.removeAll()
    //
    //        if let previousViewController = previousViewController as? WorkPlanReportStep2ViewController {
    //
    //            ApiService.request(router: WorkPlanReportApi.detailList(param: WorkPlanResultInfoListRequest(yyyymm: yyyymm, divCdParam: workPlanReportInfoData?.divCd ?? "", prsnCdParam: workPlanReportInfoData?.prsnCd ?? "")), success: { (response: ApiResponse<WorkingPlanListResponse>) in
    //                self.hud.dismiss()
    //                if let result = response.value {
    //                    if let list = result.data {
    //                        //                    self.planList = list
    //                        //                        print("self.planList : \(self.planList)")
    //                        var totalWorkingTime = 0
    //
    //                        for item in list {
    //                            if let yyyymmdd = item.yyyymmdd, yyyymmdd == self.selectedDate {
    //                                totalWorkingTime += item.workTime ?? 0
    //                                self.planList.append(item)
    //                            }
    //
    //                        }
    //                        self.lblTotalTimeValue.text = "\(totalWorkingTime)H"
    //                        self.cvPlan.reloadData()
    //                    }
    //                }
    //
    //            }) { (error) in
    //                self.hud.dismiss()
    //                //            print("error : \(error)")
    //
    //                //          return
    //            }
    //        } else {
    //            // 근무 계획 등록에서 온 경우
    //            ApiService.request(router: WorkPlanApi.workPlanList(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingPlanListResponse>) in
    //                self.hud.dismiss()
    //                if let result = response.value {
    //                    if let list = result.data {
    //                        //                    self.planList = list
    //                        //                        print("self.planList : \(self.planList)")
    //                        var totalWorkingTime = 0
    //
    //                        for item in list {
    //                            if let yyyymmdd = item.yyyymmdd, yyyymmdd == self.selectedDate {
    //                                totalWorkingTime += item.workTime ?? 0
    //                                self.planList.append(item)
    //                            }
    //
    //                        }
    //                        self.lblTotalTimeValue.text = "\(totalWorkingTime)H"
    //                        self.cvPlan.reloadData()
    //                    }
    //                }
    //
    //            }) { (error) in
    //                self.hud.dismiss()
    //
    //            }
    //        }
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

//extension WorkingPlanRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
//            return self.planList.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingPlanRegisterCollectionViewCell.ID, for: indexPath) as! WorkingPlanRegisterCollectionViewCell
//        switch indexPath.section {
//        case 0:
//            //            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
//            cell.lblDate.text = "일자".localized
//            cell.lblDate.textColor = .black
//            cell.lblTime.text = "시간".localized
//            cell.lblTime.textColor = .black
//            cell.lblWorkingHour.text = "근무시간".localized
//            cell.lblCdat.text = "근태".localized
//            cell.lblDelete.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
//            cell.lblDelete.backgroundColor = .white
//
//        default:
//            cell.lblTime.text = ""
//            cell.lblCdat.text = ""
//            cell.lblWorkingHour.text = ""
//
//            //            if let cdat1 = planList[indexPath.row].cdat1 {
//            //                for item in codeList {
//            //                    if item.subCd == cdat1 {
//            //
//            //                    }
//            //                }
//            //            }
//            //            if let cdat2 = planList[indexPath.row].cdat2 {
//            //
//            //            }
//            //            if let cdat3 = planList[indexPath.row].cdat3 {
//            //
//            //            }
//            cell.lblDelete.textColor = .white
//            cell.lblDelete.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
//            cell.lblDelete.layer.cornerRadius = 8
//            cell.lblDelete.layer.masksToBounds = true
//
//            if indexPath.row < planList.count {
//                if let yyyymmdd = planList[indexPath.row].yyyymmdd {
//                    //                let index = yyyymmdd.index(yyyymmdd.endIndex, offsetBy: -2)
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.locale = Locale(identifier:"ko_KR")
//                    dateFormatter.dateFormat = "yyyyMMdd" // 월 표시 포맷 설정
//                    if let getDate = dateFormatter.date(from: yyyymmdd) {
//                        let today = Calendar.current.component(.weekday, from: Date())
//                        print("today : \(Date())")
//                        let weekday = Calendar.current.component(.weekday, from: getDate)
//                        //                    let weekday = Calendar.current.dateComponents(in: .current, from: getDate)
//                        //                    print("yyyymmdd : \(yyyymmdd), getDate : \(getDate), weekday : \(weekday)")
//                        //                    print("util.getWeekDayFromNum(num: weekday) : \(util.getWeekDayFromNum(num: weekday))")
//                        cell.lblDate.text = "\(String(yyyymmdd.suffix(2)))(\(util.getWeekDayFromNum(num: weekday)))"
//                        if weekday == 1 {
//                            cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
//                        } else if weekday == 7 {
//                            cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
//                        }
//                    }
//                }
//
//
//                if let comeTime = planList[indexPath.row].comeTime, let leaveTime = planList[indexPath.row].leaveTime {
//                    let editComeStart = String(comeTime.prefix(2))
//                    let editComeEnd = (comeTime.suffix(2))
//                    let editLeaveStart = String(leaveTime.prefix(2))
//                    let editLeaveEnd = String(leaveTime.suffix(2))
//                    cell.lblWorkingHour.text = "\(editComeStart):\(editComeEnd)~\(editLeaveStart):\(editLeaveEnd)"
//                }
//
//                if let workTime = planList[indexPath.row].workTime {
//                    cell.lblTime.text = "\(workTime)"
//                }
//                if let cdat3 = planList[indexPath.row].cdat3 {
//                    for item in getCdatList {
//                        if item.subCd == cdat3 {
//                            cell.lblCdat.text = item.subNm
//                        }
//                    }
//                }
//                if let cdat2 = planList[indexPath.row].cdat2 {
//                    for item in getCdatList {
//                        if item.subCd == cdat2 {
//                            cell.lblCdat.text = item.subNm
//                        }
//                    }
//                }
//
//                if let cdat1 = planList[indexPath.row].cdat1 {
//                    for item in getCdatList {
//                        if item.subCd == cdat1 {
//                            cell.lblCdat.text = item.subNm
//                        }
//                    }
//                }
//            }
//
//
//
//
//
//
//            cell.backgroundColor = .white
//            //            if indexPath.row % 7 == 0 { // 일요일
//            //                cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
//            //            } else if indexPath.row % 7 == 6 { // 토요일
//            //                cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
//            //            }
//
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let plan = planList[indexPath.row]
//        //        print("selected : \(indexPath.row), plan  : \(plan)")
//        //        if let previousViewController = previousViewController as? WorkingPlanViewController {
//        planList.remove(at: indexPath.row)
//        cvPlan.reloadData()
//        //        } else {
//        //            self.dismiss(animated: true, completion: nil)
//        ////            if let getVc = util.getViewControllerFromText(label: "근무 계획 등록 상세".localized) {
//        ////                print("WorkingPlan didSelectRowAt getVc : \(getVc)")
//        ////                if let getVc2 = getVc as? WorkingPlanRegisterViewController {
//        ////                    getVc2.selectedDate = plan.yyyymmdd!
//        ////                    NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
//        ////                }
//        ////
//        ////            }
//        //        }
//
//
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewSize = collectionView.frame.size.width
//        //        print("collectionViewSize : \(collectionViewSize)")
//        return CGSize(width: collectionViewSize, height: 41)
//
//
//    }
//}

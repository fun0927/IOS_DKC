//
//  MainWorkingStatusViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import UIKit
import JGProgressHUD
import SQLite

class MainWorkingStatusViewController: UIViewController {
  
    
    let hud = JGProgressHUD()
    
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "2021년 10월"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblDateNoti: UILabel = {
        let label = UILabel()
        label.text = "승인 기준 데이터입니다".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        return label
    }()
    
    
    let lblWorkingDayLabel: UILabel = {
        let label = UILabel()
        label.text = "근무일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()

    let lblDayOffLabel: UILabel = {
        let label = UILabel()
        label.text = "휴(무)일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblWorkingDay: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    let lblDayOff: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblTotalWorkingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "총 근로시간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let lblWorkingGrade: UILabel = {
        let label = UILabel()
        label.text = "양호".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 32)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblTotalWorkingTime: UILabel = {
        let label = UILabel()
        label.text = "130 H"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblWorkingGrade0: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWorkingGrade1: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWorkingGrade2: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWorkingGrade3: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblWorkingGrade4: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let scrollView = UIScrollView()
    
    
    let ivWorkingGrade0: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade0")
        return imageView
    }()
    let ivWorkingGrade1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade1")
        return imageView
    }()
    let ivWorkingGrade2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade2")
        return imageView
    }()
    let ivWorkingGrade3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade3")
        return imageView
    }()
    let ivWorkingGrade4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade4")
        return imageView
    }()
    
    let ivWorkingGrade5: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workingGrade5")
        return imageView
    }()
    
    let baseWorkinghourLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblbaseWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let addWorkingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lbladdWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let maxWorkingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    let lblmaxWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    
    let workingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "실근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let lblWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    
    let etcWorkingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "잔여 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let lblEtcWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let cvShortCut = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let btnShortCutEdit: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-32, height: 51))
        button.setTitle("바로가기 편집".localized,for: .normal)
        button.setTitleColor(UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
//        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)

        return button
    }()
    
    let util = Util()
    var selectedArray:[Util.ShortCutContent] = []
    
    let summaryView2 = UIView()
    
    var cvShortcutHeightAnchor:NSLayoutConstraint?
    
    
    // 관리직용 cv 선언
    
    let cvManageSummary1 = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var manageWorkingHourLabelArray = ["기본 근로시간".localized, "추가 근로시간".localized, "최대 근로시간".localized]
    var manageWorkingHourArray:[Int] = []
   
    
    let cvManageGrade = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var manageGradeLabelArray = ["양호".localized, "경계".localized, "주의".localized,"위험".localized,"법위반".localized]
    var manageGradeArray:[Int] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        scrollView.backgroundColor = .blue
        
        
        let summaryView = UIView()
        summaryView.backgroundColor = .white
        scrollView.addSubview(summaryView)
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        summaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        summaryView.heightAnchor.constraint(equalToConstant: 166).isActive = true
        summaryView.layer.cornerRadius = 8
        
        scrollView.addSubview(lblDate)
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblDate.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 19).isActive = true
        lblDate.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 32).isActive = true
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월".localized
        let stDate = dateFormatter.string(from: date)
        lblDate.text = stDate
        
        scrollView.addSubview(lblDateNoti)
        lblDateNoti.translatesAutoresizingMaskIntoConstraints = false
        lblDateNoti.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 19).isActive = true
        lblDateNoti.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -31).isActive = true
        
        
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        scrollView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: lblDateNoti.bottomAnchor, constant: 20).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor).isActive = true
        
        scrollView.addSubview(lblWorkingDayLabel)
        lblWorkingDayLabel.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingDayLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24).isActive = true
        lblWorkingDayLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 99).isActive = true
        
        scrollView.addSubview(lblWorkingDay)
        lblWorkingDay.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingDay.topAnchor.constraint(equalTo: lblWorkingDayLabel.bottomAnchor).isActive = true
        lblWorkingDay.centerXAnchor.constraint(equalTo: lblWorkingDayLabel.centerXAnchor).isActive = true
        
        scrollView.addSubview(lblDayOffLabel)
        lblDayOffLabel.translatesAutoresizingMaskIntoConstraints = false
        lblDayOffLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -99).isActive = true
        lblDayOffLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24).isActive = true
        
        scrollView.addSubview(lblDayOff)
        lblDayOff.translatesAutoresizingMaskIntoConstraints = false
        lblDayOff.topAnchor.constraint(equalTo: lblDayOffLabel.bottomAnchor).isActive = true
        lblDayOff.centerXAnchor.constraint(equalTo: lblDayOffLabel.centerXAnchor).isActive = true
      
        // 일반직, 관리직 양호 표시 분기
        if Environment.IS_MANAGE == "0"{
            // 일반직
            scrollView.addSubview(lblTotalWorkingTimeLabel)
            lblTotalWorkingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            lblTotalWorkingTimeLabel.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 89).isActive = true
            lblTotalWorkingTimeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            lblTotalWorkingTimeLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
            
            scrollView.addSubview(lblWorkingGrade)
            lblWorkingGrade.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade.topAnchor.constraint(equalTo: lblTotalWorkingTimeLabel.bottomAnchor, constant: 8).isActive = true
            lblWorkingGrade.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            lblWorkingGrade.heightAnchor.constraint(equalToConstant: 34).isActive = true
            
            scrollView.addSubview(lblTotalWorkingTime)
            lblTotalWorkingTime.translatesAutoresizingMaskIntoConstraints = false
            lblTotalWorkingTime.topAnchor.constraint(equalTo: lblWorkingGrade.bottomAnchor, constant: 12).isActive = true
            lblTotalWorkingTime.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
            scrollView.addSubview(lblWorkingGrade0)
            lblWorkingGrade0.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 39).isActive = true
            lblWorkingGrade0.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 156).isActive = true
            
            scrollView.addSubview(lblWorkingGrade1)
            lblWorkingGrade1.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 45).isActive = true
            lblWorkingGrade1.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 83).isActive = true
            
            scrollView.addSubview(lblWorkingGrade2)
            lblWorkingGrade2.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 112).isActive = true
            lblWorkingGrade2.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 32).isActive = true
            
            scrollView.addSubview(lblWorkingGrade3)
            lblWorkingGrade3.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade3.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 32).isActive = true
            lblWorkingGrade3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -103).isActive = true
            
            scrollView.addSubview(lblWorkingGrade4)
            lblWorkingGrade4.translatesAutoresizingMaskIntoConstraints = false
            lblWorkingGrade4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            lblWorkingGrade4.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 83).isActive = true
            
            print("Authorization : \(Environment.AUTHORIZATOIN)")
            
            scrollView.addSubview(ivWorkingGrade0)
            ivWorkingGrade0.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            ivWorkingGrade0.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 46.86).isActive = true
            ivWorkingGrade0.widthAnchor.constraint(equalToConstant: 259.45).isActive = true
            ivWorkingGrade0.heightAnchor.constraint(equalToConstant: 129.14).isActive = true
            
            scrollView.addSubview(ivWorkingGrade5)
            ivWorkingGrade5.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            ivWorkingGrade5.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 46.86).isActive = true
            ivWorkingGrade5.widthAnchor.constraint(equalToConstant: 259.45).isActive = true
            ivWorkingGrade5.heightAnchor.constraint(equalToConstant: 129.14).isActive = true
            
            scrollView.addSubview(ivWorkingGrade4)
            ivWorkingGrade4.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade4.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 46.86).isActive = true
            ivWorkingGrade4.leadingAnchor.constraint(equalTo: ivWorkingGrade5.leadingAnchor).isActive = true
            ivWorkingGrade4.widthAnchor.constraint(equalToConstant: 234.45).isActive = true
            ivWorkingGrade4.heightAnchor.constraint(equalToConstant: 129.14).isActive = true
            
            scrollView.addSubview(ivWorkingGrade3)
            ivWorkingGrade3.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade3.leadingAnchor.constraint(equalTo: ivWorkingGrade5.leadingAnchor).isActive = true
            ivWorkingGrade3.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 46.86).isActive = true
            ivWorkingGrade3.widthAnchor.constraint(equalToConstant: 178.42).isActive = true
            ivWorkingGrade3.heightAnchor.constraint(equalToConstant: 129.14).isActive = true
            
            scrollView.addSubview(ivWorkingGrade2)
            ivWorkingGrade2.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade2.leadingAnchor.constraint(equalTo: ivWorkingGrade5.leadingAnchor).isActive = true
            ivWorkingGrade2.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 53.17).isActive = true
            ivWorkingGrade2.widthAnchor.constraint(equalToConstant: 96.13).isActive = true
            ivWorkingGrade2.heightAnchor.constraint(equalToConstant: 122.83).isActive = true
            
            scrollView.addSubview(ivWorkingGrade1)
            ivWorkingGrade1.translatesAutoresizingMaskIntoConstraints = false
            ivWorkingGrade1.leadingAnchor.constraint(equalTo: ivWorkingGrade5.leadingAnchor).isActive = true
            ivWorkingGrade1.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 100.28).isActive = true
            ivWorkingGrade1.widthAnchor.constraint(equalToConstant: 33.28).isActive = true
            ivWorkingGrade1.heightAnchor.constraint(equalToConstant: 75.72).isActive = true
            
            
            // 하단 하얀 근로시간 표시 뷰
            scrollView.addSubview(summaryView2)
            summaryView2.translatesAutoresizingMaskIntoConstraints = false
            summaryView2.topAnchor.constraint(equalTo: lblTotalWorkingTime.bottomAnchor, constant: 32).isActive = true
            summaryView2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            summaryView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            summaryView2.layer.cornerRadius = 8
            summaryView2.backgroundColor = .white
            summaryView2.heightAnchor.constraint(equalToConstant: 93).isActive = true
            
            summaryView2.isUserInteractionEnabled = true
            let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(summaryView2Clicked))
            summaryView2.addGestureRecognizer(tap1)
          
            
            let blueView = UIView()
            scrollView.addSubview(blueView)
            blueView.backgroundColor = UIColor(red: 0.039, green: 0.559, blue: 0.851, alpha: 1)
            blueView.translatesAutoresizingMaskIntoConstraints = false
            blueView.topAnchor.constraint(equalTo: lblTotalWorkingTime.bottomAnchor, constant: 32).isActive = true
            blueView.widthAnchor.constraint(equalToConstant: 132).isActive = true
            blueView.heightAnchor.constraint(equalToConstant: 93).isActive = true
            blueView.trailingAnchor.constraint(equalTo: summaryView2.trailingAnchor).isActive = true
            blueView.layer.cornerRadius = 8
            
            blueView.isUserInteractionEnabled = true
            let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(summaryView2Clicked))
            blueView.addGestureRecognizer(tap2)
            
            //기본 근로
            scrollView.addSubview(baseWorkinghourLabel)
            baseWorkinghourLabel.translatesAutoresizingMaskIntoConstraints = false
            baseWorkinghourLabel.leadingAnchor.constraint(equalTo: summaryView2.leadingAnchor, constant: 16).isActive = true
            baseWorkinghourLabel.topAnchor.constraint(equalTo: summaryView2.topAnchor, constant: 23).isActive = true
            baseWorkinghourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
            
            scrollView.addSubview(maxWorkingHourLabel)
            maxWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
            maxWorkingHourLabel.trailingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: -16).isActive = true
            maxWorkingHourLabel.topAnchor.constraint(equalTo: summaryView2.topAnchor, constant: 23).isActive = true
            maxWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
            
            scrollView.addSubview(addWorkingHourLabel)
            addWorkingHourLabel.textAlignment = .center
            addWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
            addWorkingHourLabel.leadingAnchor.constraint(equalTo: summaryView2.leadingAnchor).isActive = true
            addWorkingHourLabel.trailingAnchor.constraint(equalTo: blueView.leadingAnchor).isActive = true
            addWorkingHourLabel.topAnchor.constraint(equalTo: summaryView2.topAnchor, constant: 23).isActive = true
            addWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
            
            scrollView.addSubview(lblbaseWorkinghourValue)
            lblbaseWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
            lblbaseWorkinghourValue.centerXAnchor.constraint(equalTo: baseWorkinghourLabel.centerXAnchor).isActive = true
            lblbaseWorkinghourValue.topAnchor.constraint(equalTo: baseWorkinghourLabel.bottomAnchor, constant: 2).isActive = true
            
            scrollView.addSubview(lblmaxWorkinghourValue)
            lblmaxWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
            lblmaxWorkinghourValue.centerXAnchor.constraint(equalTo: maxWorkingHourLabel.centerXAnchor).isActive = true
            lblmaxWorkinghourValue.topAnchor.constraint(equalTo: maxWorkingHourLabel.bottomAnchor, constant: 2).isActive = true
            
            scrollView.addSubview(lbladdWorkinghourValue)
            lbladdWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
            lbladdWorkinghourValue.centerXAnchor.constraint(equalTo: addWorkingHourLabel.centerXAnchor).isActive = true
            lbladdWorkinghourValue.topAnchor.constraint(equalTo: addWorkingHourLabel.bottomAnchor, constant: 2).isActive = true
            
            
            // 실근로, 잔여근로
            scrollView.addSubview(workingHourLabel)
            workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
            workingHourLabel.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 23).isActive = true
            workingHourLabel.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 17).isActive = true
            workingHourLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            scrollView.addSubview(etcWorkingHourLabel)
            etcWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
            etcWorkingHourLabel.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 23).isActive = true
            etcWorkingHourLabel.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -17).isActive = true
            etcWorkingHourLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            scrollView.addSubview(lblWorkinghourValue)
            lblWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
            lblWorkinghourValue.centerXAnchor.constraint(equalTo: workingHourLabel.centerXAnchor).isActive = true
            lblWorkinghourValue.topAnchor.constraint(equalTo: workingHourLabel.bottomAnchor, constant: 4).isActive = true
            
            scrollView.addSubview(lblEtcWorkinghourValue)
            lblEtcWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
            lblEtcWorkinghourValue.centerXAnchor.constraint(equalTo: etcWorkingHourLabel.centerXAnchor).isActive = true
            lblEtcWorkinghourValue.topAnchor.constraint(equalTo: etcWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
            
        } else {
            let manageSummaryView1 = UIView()
            manageSummaryView1.backgroundColor = .white
            scrollView.addSubview(manageSummaryView1)
            manageSummaryView1.translatesAutoresizingMaskIntoConstraints = false
            manageSummaryView1.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: 16).isActive = true
            manageSummaryView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            manageSummaryView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            manageSummaryView1.heightAnchor.constraint(equalToConstant: 174).isActive = true
            manageSummaryView1.layer.cornerRadius = 8
            
            
            let cvManageLayout1 = UICollectionViewFlowLayout()
            cvManageLayout1.minimumLineSpacing = 0
            cvManageLayout1.minimumInteritemSpacing = 0
            cvManageLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cvManageSummary1.collectionViewLayout = cvManageLayout1
            cvManageSummary1.delegate = self
            cvManageSummary1.dataSource = self
            scrollView.addSubview(cvManageSummary1)
            cvManageSummary1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
            cvManageSummary1.topAnchor.constraint(equalTo: manageSummaryView1.topAnchor).isActive = true
            cvManageSummary1.translatesAutoresizingMaskIntoConstraints = false
            cvManageSummary1.leadingAnchor.constraint(equalTo: manageSummaryView1.leadingAnchor, constant: 32).isActive = true
            cvManageSummary1.trailingAnchor.constraint(equalTo: manageSummaryView1.trailingAnchor, constant: -32).isActive = true
            cvManageSummary1.heightAnchor.constraint(equalToConstant: CGFloat(174)).isActive = true
            cvManageSummary1.register(ManManageSummaryCollectionViewCell.self, forCellWithReuseIdentifier: ManManageSummaryCollectionViewCell.ID)
            cvManageSummary1.isScrollEnabled = false
//            cvManageSummary1.backgroundColor = .red
//            cvManageSummary1.layer.cornerRadius = 8
           
            let cvManageGradeLayout = UICollectionViewFlowLayout()
            cvManageGradeLayout.minimumLineSpacing = 0
            cvManageGradeLayout.minimumInteritemSpacing = 0
            cvManageGradeLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            cvManageGradeLayout.scrollDirection = .horizontal
            cvManageGrade.collectionViewLayout = cvManageGradeLayout
            cvManageGrade.delegate = self
            cvManageGrade.dataSource = self
            scrollView.addSubview(cvManageGrade)
            cvManageGrade.backgroundColor = .white
            cvManageGrade.layer.cornerRadius = 8
            cvManageGrade.translatesAutoresizingMaskIntoConstraints = false
            cvManageGrade.topAnchor.constraint(equalTo: manageSummaryView1.bottomAnchor, constant: 16).isActive = true
            cvManageGrade.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
            cvManageGrade.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            cvManageGrade.heightAnchor.constraint(equalToConstant: CGFloat(93)).isActive = true
            cvManageGrade.register(MainManageGradeCollectionViewCell.self, forCellWithReuseIdentifier: MainManageGradeCollectionViewCell.ID)
            cvManageGrade.isScrollEnabled = false
        }
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 16
        cvLayout.minimumInteritemSpacing = 16
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        cvShortCut.collectionViewLayout = cvLayout
        
        cvShortCut.delegate = self
        cvShortCut.dataSource = self
        scrollView.addSubview(cvShortCut)
        cvShortCut.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        cvShortCut.translatesAutoresizingMaskIntoConstraints = false
        if Environment.IS_MANAGE == "0"{
            cvShortCut.topAnchor.constraint(equalTo: summaryView2.bottomAnchor, constant: 16).isActive = true
        } else {
            cvShortCut.topAnchor.constraint(equalTo: cvManageGrade.bottomAnchor, constant: 16).isActive = true
        }
        cvShortCut.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvShortCut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        cvShortCut.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
        let cvHeight = 51*3+16*2
        cvShortcutHeightAnchor = cvShortCut.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
        cvShortcutHeightAnchor?.isActive = true
        cvShortCut.register(ShortcutCollectionViewCell.self, forCellWithReuseIdentifier: ShortcutCollectionViewCell.ID)        
        cvShortCut.isScrollEnabled = false
        
        
        scrollView.addSubview(btnShortCutEdit)
        btnShortCutEdit.translatesAutoresizingMaskIntoConstraints = false
        btnShortCutEdit.topAnchor.constraint(equalTo: cvShortCut.bottomAnchor, constant: 16).isActive = true
        btnShortCutEdit.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        
        btnShortCutEdit.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnShortCutEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        btnShortCutEdit.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        let border = CAShapeLayer()
        border.strokeColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
        border.lineWidth = 1
        border.lineDashPattern = [2, 2] as [NSNumber]
        border.frame = btnShortCutEdit.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: btnShortCutEdit.bounds, cornerRadius: 8).cgPath
        btnShortCutEdit.layer.addSublayer(border)
        btnShortCutEdit.addTarget(self, action: #selector(btnShortCutEditClicked), for: .touchUpInside)
        
//        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
//        testView.backgroundColor = .lightGray
//        scrollView.addSubview(testView)
//        testView.translatesAutoresizingMaskIntoConstraints = false
//        testView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        testView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        testView.topAnchor.constraint(equalTo: cvShortCut.bottomAnchor, constant: 16).isActive = true
//        testView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        print("testView.bounds : \(testView.bounds)")
//        let border = CAShapeLayer()
//        border.strokeColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
//        border.lineWidth = 1
//        border.lineDashPattern = [2, 2] as [NSNumber]
//        border.frame = testView.bounds
//        border.fillColor = nil
//        border.path = UIBezierPath(roundedRect: testView.bounds, cornerRadius: 8).cgPath
//        testView.layer.addSublayer(border)
        
        if Environment.IS_MANAGE == "0"{
            getWorkingInfoRead()
        } else {
            getManageWorkingInfoRead()
        }
    }
    
    @objc func summaryView2Clicked(){
        if let getVc = util.getViewControllerFromText(label: "나의 근무 현황".localized) {
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
        }
    }
    
    func setNormalWorkerView(){
        
    }
    func setManageWorkerView(){
        
    }
    
    func getManageWorkingInfoRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: MainApi.ManageInfoRead, success: { (response: ApiResponse<ManageInfoResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("result : \(result)")
                if let workingDay = result.data?.workingDay {
                    self.lblWorkingDay.text = String(workingDay)
                }
                if let dayOff = result.data?.dayOff {
                    self.lblDayOff.text = String(dayOff)
                }
                if let baseWorkingHour = result.data?.baseWorkingHour, let addWorkingHour = result.data?.addWorkingHour, let maxWorkingHour = result.data?.maxWorkingHour {
                    self.manageWorkingHourArray.removeAll()
                    self.manageWorkingHourArray.append(baseWorkingHour)
                    self.manageWorkingHourArray.append(addWorkingHour)
                    self.manageWorkingHourArray.append(maxWorkingHour)
                    self.cvManageSummary1.reloadData()
                }
                if let grade1 = result.data?.grade1, let grade2 = result.data?.grade2, let grade3 = result.data?.grade3,
                   let grade4 = result.data?.grade4, let grade5 = result.data?.grade5 {
                    self.manageGradeArray.removeAll()
                    self.manageGradeArray = [grade1, grade2, grade3, grade4, grade5]
                    self.cvManageGrade.reloadData()
                }
            }

        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
          
          return
        }
        
    }
    
    
    func getWorkingInfoRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: MainApi.WorkingInfoRead, success: { (response: ApiResponse<WorkingInfoResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("result : \(result)")
                
                if let workingDay = result.data?.workingDay, let dayOff = result.data?.dayOff, let workingGrade = result.data?.workingGrade, let workingGrade1 = result.data?.workingGrade1, let workingGrade2 = result.data?.workingGrade2, let workingGrade3 = result.data?.workingGrade3, let workingGrade4 = result.data?.workingGrade4 {
                    self.lblWorkingDay.text = String(workingDay)
                    self.lblDayOff.text = String(dayOff)
                    self.lblWorkingGrade1.text = String(workingGrade1)
                    self.lblWorkingGrade2.text = String(workingGrade2)
                    self.lblWorkingGrade3.text = String(workingGrade3)
                    self.lblWorkingGrade4.text = String(workingGrade4)
                    switch workingGrade {
                    case 1:
                        self.lblWorkingGrade.text = "양호".localized
                        self.ivWorkingGrade1.isHidden = false
                        self.ivWorkingGrade2.isHidden = true
                        self.ivWorkingGrade3.isHidden = true
                        self.ivWorkingGrade4.isHidden = true
                        self.ivWorkingGrade5.isHidden = true
                    case 2:
                        self.lblWorkingGrade.text = "경계".localized
                        self.ivWorkingGrade1.isHidden = false
                        self.ivWorkingGrade2.isHidden = false
                        self.ivWorkingGrade3.isHidden = true
                        self.ivWorkingGrade4.isHidden = true
                        self.ivWorkingGrade5.isHidden = true
                    case 3:
                        self.lblWorkingGrade.text = "주의".localized
                        self.ivWorkingGrade1.isHidden = false
                        self.ivWorkingGrade2.isHidden = false
                        self.ivWorkingGrade3.isHidden = false
                        self.ivWorkingGrade4.isHidden = true
                        self.ivWorkingGrade5.isHidden = true
                    case 4:
                        self.lblWorkingGrade.text = "위험".localized
                        self.ivWorkingGrade1.isHidden = false
                        self.ivWorkingGrade2.isHidden = false
                        self.ivWorkingGrade3.isHidden = false
                        self.ivWorkingGrade4.isHidden = false
                        self.ivWorkingGrade5.isHidden = true
                    default:
                        self.lblWorkingGrade.text = "법위반".localized
                        self.ivWorkingGrade1.isHidden = false
                        self.ivWorkingGrade2.isHidden = false
                        self.ivWorkingGrade3.isHidden = false
                        self.ivWorkingGrade4.isHidden = false
                        self.ivWorkingGrade5.isHidden = false
                    }
                    if let baseWorkingHour = result.data?.baseWorkingHour {
                        self.lblbaseWorkinghourValue.text = "\(baseWorkingHour)"
                    }
                    
                    if let maxWorkingHour = result.data?.maxWorkingHour {
                        self.lblmaxWorkinghourValue.text = "\(maxWorkingHour)"
                    }
                    if let addWorkingHour = result.data?.addWorkingHour {
                        self.lbladdWorkinghourValue.text = "\(addWorkingHour)"
                    }
                    
                    if let etcWorkingHour = result.data?.etcWorkingHour {
                        self.lblEtcWorkinghourValue.text = "\(etcWorkingHour)"
                    }
                    
                    if let workingHour = result.data?.workingHour {
                        self.lblTotalWorkingTime.text = "\(workingHour) H"
                        self.lblWorkinghourValue.text = "\(workingHour)"
                    }                
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }

    @objc func btnShortCutEditClicked(){
        let vc = MainShorCutEditViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSelectedArray()
    }
    
    func getSelectedArray(){
        selectedArray.removeAll()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)

        do {
            let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
            let title = Expression<String>("title")
            let shorcuts = Table("shorcuts")
//            let id = Expression<Int64>("id")
            
            for shortcut in try db.prepare(shorcuts) {
                print("title: \(shortcut[title])")
                for (_, item) in util.shorCutArray.enumerated() {
                    if item.title == shortcut[title] {
                        selectedArray.append(item)
                    }
                }
            }
            cvShortCut.reloadData()
            hud.dismiss()
        } catch {
            print(error)
            hud.dismiss()
        }
        setShortcutHeight()
    }
    
    func setShortcutHeight() {
        cvShortcutHeightAnchor?.isActive = false
        print("selectedArray.count : \(selectedArray.count)")
        if(selectedArray.count == 0) {
            cvShortcutHeightAnchor = cvShortCut.heightAnchor.constraint(equalToConstant: 0)
        }else {
            let cvRowCnt:Int = Int(ceil(Double(selectedArray.count) / 2))
            let cvHeight = (51 * cvRowCnt) + (16 * (cvRowCnt-1))
            cvShortcutHeightAnchor = cvShortCut.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
        }
        cvShortcutHeightAnchor?.isActive = true
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

extension MainWorkingStatusViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvShortCut {
            return selectedArray.count
        } else if collectionView == cvManageSummary1 {
            //if collectionView == cvManageSummary1
            return manageWorkingHourLabelArray.count
        } else {
            return manageGradeLabelArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvShortCut {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortcutCollectionViewCell.ID, for: indexPath) as! ShortcutCollectionViewCell
            if indexPath.row < selectedArray.count {
                cell.lblTitle.text = selectedArray[indexPath.row].title
                cell.ivIcon.image = selectedArray[indexPath.row].mainIcon
                cell.ivIcon.isHidden = false
                cell.lblTitle.isHidden = false
            } else {
                cell.lblTitle.text = ""
                cell.lblTitle.isHidden = true
                cell.ivIcon.isHidden = true
            }
            return cell
        } else if collectionView == cvManageSummary1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManManageSummaryCollectionViewCell.ID, for: indexPath) as! ManManageSummaryCollectionViewCell
            cell.lblTitle.text = ""
            cell.lblValue.text = ""
            if indexPath.row < manageWorkingHourArray.count {
                cell.lblValue.text = String(manageWorkingHourArray[indexPath.row])
            }
            if indexPath.row < manageWorkingHourLabelArray.count {
                print("manageWorkingHourLabelArray add :\(manageWorkingHourLabelArray[indexPath.row])")
                cell.lblTitle.text = manageWorkingHourLabelArray[indexPath.row]
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainManageGradeCollectionViewCell.ID, for: indexPath) as! MainManageGradeCollectionViewCell
            cell.lblTitle.text = ""
            cell.lblValue.text = ""
            if indexPath.row < manageGradeArray.count {
                cell.lblValue.text = String(manageGradeArray[indexPath.row])
            }
            if indexPath.row < manageGradeLabelArray.count {
//                print("manageGradeLabelArray add :\(manageGradeLabelArray[indexPath.row])")
                cell.lblTitle.text = manageGradeLabelArray[indexPath.row]
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvShortCut {
            if indexPath.row < selectedArray.count {
                if let getVc = util.getViewControllerFromText(label: selectedArray[indexPath.row].title) {
                    print("getVc : \(getVc)")
                    
                    if let getVc2 = getVc as?  NoticeListViewController {
                        //공지사항 분류에 따라 구분을 다르게 함
                        switch selectedArray[indexPath.row].title {
                        case "사내공지사항".localized:
                            getVc2.dvs = "1"
                        case "안전공지사항".localized:
                            getVc2.dvs = "2"
                        case "노동조합공지사항".localized:
                            getVc2.dvs = "3"
                        default:
                            getVc2.dvs = "1"
                        }
                        NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
                    }
                }
            }
        }
//        loginStep2ViewController?.setMbtiFromBodal(getMbti: mbtiList[indexPath.row])
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvShortCut {
            let collectionViewSize = collectionView.frame.size.width / 2 - 8
//            print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        } else if collectionView == cvManageSummary1 {
            let height = 174/3
            let width = 343-64
            return CGSize(width: width, height: height)
        } else {
            let height = 174
            let width = (343-32)/5
            return CGSize(width: width, height: height)
        }
        
    }
}

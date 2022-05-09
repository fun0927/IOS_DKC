//
//  MyWorkingListViewController.swift
//  D-WORK
//
//  Created by on 2021/11/22.
//

import UIKit
import JGProgressHUD

class MyWorkingListViewController: UIViewController {
    let hud = JGProgressHUD()
    let cvCalendar = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일".localized, "월".localized, "화".localized, "수".localized, "목".localized, "금".localized, "토".localized]
    var days: [String] = []
    var workingList:[WorkingListDetailResponse] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
    let lblWorkingGrade: UILabel = {
        let label = UILabel()
        label.text = "양호".localized
        label.backgroundColor = UIColor(red: 0.039, green: 0.851, blue: 0.686, alpha: 1)
        label.layer.cornerRadius = 28
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 0.263, green: 0.275, blue: 0.62, alpha: 1)
        return label
    }()
    
    let baseWorkinghourLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let lblbaseWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let addWorkingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let lbladdWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let maxWorkingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    let lblmaxWorkinghourValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    
    let workingHourLabel: UILabel = {
        let label = UILabel()
        label.text = "실근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
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
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
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
    
    let lblMonth: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    
    let btnPrevious: UIButton = {
        let button = UIButton()

        return button
    }()
    let ivPrevious:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previous")
        return imageView
    }()
    let btnNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    
    let lblInfoBlue: UILabel = {
        let label = UILabel()
        label.text = "청색".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
        return label
    }()
    
    let lblInfoBlueValue: UILabel = {
        let label = UILabel()
        label.text = "휴(무)일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblInfoRed: UILabel = {
        let label = UILabel()
        label.text = "적색".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0.992, green: 0.451, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblInfoRedValue: UILabel = {
        let label = UILabel()
        label.text = "휴일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =   UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var getCdatList:[CodeListDetailResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let rightSummaryView = UIView()
        scrollView.addSubview(rightSummaryView)
        rightSummaryView.translatesAutoresizingMaskIntoConstraints = false
        rightSummaryView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        rightSummaryView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        rightSummaryView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rightSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightSummaryView.backgroundColor = UIColor(red: 0.039, green: 0.559, blue: 0.851, alpha: 1)
     
        
        let leftSummaryView = UIView()
        scrollView.addSubview(leftSummaryView)
        leftSummaryView.translatesAutoresizingMaskIntoConstraints = false
        leftSummaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        leftSummaryView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        leftSummaryView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let leftSumViewWidth = view.frame.width * (375/495)
//        leftSummaryView.widthAnchor.constraint(equalToConstant: leftSumViewWidth).isActive = true
        leftSummaryView.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor).isActive = true
        leftSummaryView.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        
       
        scrollView.addSubview(lblWorkingGrade)
        lblWorkingGrade.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingGrade.centerYAnchor.constraint(equalTo: leftSummaryView.centerYAnchor).isActive = true
        lblWorkingGrade.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        lblWorkingGrade.widthAnchor.constraint(equalToConstant: 56).isActive = true
        lblWorkingGrade.heightAnchor.constraint(equalToConstant: 56).isActive = true
     
        
        scrollView.addSubview(baseWorkinghourLabel)
        baseWorkinghourLabel.translatesAutoresizingMaskIntoConstraints = false
        baseWorkinghourLabel.leadingAnchor.constraint(equalTo: leftSummaryView.leadingAnchor, constant: 80).isActive = true
        baseWorkinghourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        baseWorkinghourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        scrollView.addSubview(maxWorkingHourLabel)
        maxWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        maxWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor, constant: -16).isActive = true
        maxWorkingHourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        maxWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        scrollView.addSubview(addWorkingHourLabel)
        addWorkingHourLabel.textAlignment = .center
        addWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        addWorkingHourLabel.leadingAnchor.constraint(equalTo: lblWorkingGrade.trailingAnchor).isActive = true
        addWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor).isActive = true
        addWorkingHourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        addWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        scrollView.addSubview(lblbaseWorkinghourValue)
        lblbaseWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblbaseWorkinghourValue.centerXAnchor.constraint(equalTo: baseWorkinghourLabel.centerXAnchor).isActive = true
        lblbaseWorkinghourValue.topAnchor.constraint(equalTo: baseWorkinghourLabel.bottomAnchor, constant: 4).isActive = true
        
        scrollView.addSubview(lblmaxWorkinghourValue)
        lblmaxWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblmaxWorkinghourValue.centerXAnchor.constraint(equalTo: maxWorkingHourLabel.centerXAnchor).isActive = true
        lblmaxWorkinghourValue.topAnchor.constraint(equalTo: maxWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        scrollView.addSubview(lbladdWorkinghourValue)
        lbladdWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lbladdWorkinghourValue.centerXAnchor.constraint(equalTo: addWorkingHourLabel.centerXAnchor).isActive = true
        lbladdWorkinghourValue.topAnchor.constraint(equalTo: addWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        
        // 실근로, 잔여근로
        scrollView.addSubview(workingHourLabel)
        workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        workingHourLabel.topAnchor.constraint(equalTo: rightSummaryView.topAnchor, constant: 24).isActive = true
        workingHourLabel.leadingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor, constant: 17).isActive = true
        workingHourLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        scrollView.addSubview(etcWorkingHourLabel)
        etcWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        etcWorkingHourLabel.topAnchor.constraint(equalTo: rightSummaryView.topAnchor, constant: 24).isActive = true
        etcWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.trailingAnchor, constant: -17).isActive = true
        etcWorkingHourLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        scrollView.addSubview(lblWorkinghourValue)
        lblWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkinghourValue.centerXAnchor.constraint(equalTo: workingHourLabel.centerXAnchor).isActive = true
        lblWorkinghourValue.topAnchor.constraint(equalTo: workingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        scrollView.addSubview(lblEtcWorkinghourValue)
        lblEtcWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblEtcWorkinghourValue.centerXAnchor.constraint(equalTo: etcWorkingHourLabel.centerXAnchor).isActive = true
        lblEtcWorkinghourValue.topAnchor.constraint(equalTo: etcWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        
        // 달력
        scrollView.addSubview(lblMonth)
        lblMonth.translatesAutoresizingMaskIntoConstraints = false
        lblMonth.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lblMonth.topAnchor.constraint(equalTo: leftSummaryView.bottomAnchor, constant: 31).isActive = true
        
//        scrollView.addSubview(btnPrevious)
//        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
//        btnPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
//        btnPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
//        btnPrevious.widthAnchor.constraint(equalToConstant: 10).isActive = true
//        btnPrevious.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        
        
        scrollView.addSubview(ivPrevious)
        ivPrevious.translatesAutoresizingMaskIntoConstraints = false
        ivPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        ivPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        ivPrevious.widthAnchor.constraint(equalToConstant: 10).isActive = true
        ivPrevious.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        scrollView.addSubview(btnPrevious)
        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
        btnPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        btnPrevious.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
    
        scrollView.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnNext.leadingAnchor.constraint(equalTo: lblMonth.trailingAnchor, constant: 18).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        
        
        let infoView = UIView()
        scrollView.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.widthAnchor.constraint(equalToConstant: 91).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        infoView.topAnchor.constraint(equalTo: rightSummaryView.bottomAnchor, constant: 16).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        infoView.layer.borderWidth = 1
        infoView.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        
        scrollView.addSubview(lblInfoBlue)
        lblInfoBlue.translatesAutoresizingMaskIntoConstraints = false
        lblInfoBlue.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 8).isActive = true
        lblInfoBlue.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
        lblInfoBlue.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblInfoBlue.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        scrollView.addSubview(lblInfoBlueValue)
        lblInfoBlueValue.translatesAutoresizingMaskIntoConstraints = false
        lblInfoBlueValue.centerYAnchor.constraint(equalTo: lblInfoBlue.centerYAnchor).isActive = true
        lblInfoBlueValue.leadingAnchor.constraint(equalTo: lblInfoBlue.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(lblInfoRed)
        lblInfoRed.translatesAutoresizingMaskIntoConstraints = false
        lblInfoRed.topAnchor.constraint(equalTo: lblInfoBlue.bottomAnchor, constant: 6).isActive = true
        lblInfoRed.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
        lblInfoRed.heightAnchor.constraint(equalToConstant: 16).isActive = true
        lblInfoRed.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        scrollView.addSubview(lblInfoRedValue)
        lblInfoRedValue.translatesAutoresizingMaskIntoConstraints = false
        lblInfoRedValue.centerYAnchor.constraint(equalTo: lblInfoRed.centerYAnchor).isActive = true
        lblInfoRedValue.leadingAnchor.constraint(equalTo: lblInfoRed.trailingAnchor, constant: 8).isActive = true
       
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvCalendar.collectionViewLayout = cvLayout
        
        cvCalendar.delegate = self
        cvCalendar.dataSource = self
        cvCalendar.backgroundColor = .white
        scrollView.addSubview(cvCalendar)
        cvCalendar.translatesAutoresizingMaskIntoConstraints = false
        cvCalendar.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 34).isActive = true
        
        cvCalendar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvCalendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        let cvHeight = 120*7+32
        cvCalendar.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight)).isActive = true
        cvCalendar.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.ID)
        cvCalendar.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70).isActive = true
        cvCalendar.isScrollEnabled = false
        // Do any additional setup after loading the view.
        
        dateFormatter.dateFormat = "yyyy.MM" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1

        getCdatCode()
        self.calculation()
        self.getWorkRead()
        self.getWorkList()
        
    }
    
    @objc func btnPreviousClicked(){
        components.month = components.month! - 1
//        print("components.month : \(components.month)")
        self.calculation()
        getWorkRead()
        getWorkList()
//        self.cvCalendar.reloadData()
        
    }
    
    @objc func btnNextClicked(){
        components.month = components.month! + 1
        self.calculation()
        getWorkRead()
        getWorkList()
//        self.cvCalendar.reloadData()
    }
    
    func calculation() { // 월 별 일 수 계산
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!) // 해당 수로 반환이 됩니다. 1은 일요일 ~ 7은 토요일
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        //1  일요일 2 - 1  -> 0번 인덱스부터 1일 시작
        //2 월요일 2 - 2  -> 1번 인덱스부터 1일 시작
        //3 화요일 2 - 3  -> 2번 인덱스부터 1일 시작
        //4 수요일 2 - 4  -> 3번 인덱스부터 1일 시작
        //5 목요일 2 - 5  -> 4번 인덱스부터 1일 시작
        //6 금요일 2 - 6  -> 5번 인덱스부터 1일 시작
        //7 토요일 2 - 7  -> 6번 인덱스부터 1일 시작
//       self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        self.lblMonth.text = dateFormatter.string(from: firstDayOfMonth!)
//        print("dateFormatter.string(from: firstDayOfMonth!) : \(dateFormatter.string(from: firstDayOfMonth!))")
        self.days.removeAll()
        self.workingList.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 { // 1보다 작을 경우는 비워줘야 하기 때문에 빈 값을 넣어준다.
                self.days.append("")
                self.workingList.append(WorkingListDetailResponse())
            } else {
                self.days.append(String(day))
            }

        }
//        print("days  \(days)")
//        print("workingList in calculation  \(workingList)")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getCdatCode(){
        
         hud.textLabel.text = "Loading"
         hud.show(in: self.view)
        // 근태코드
         ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HT016_ATS")), success: { (response: ApiResponse<CodeListResponse>) in
 //            print("response : \(response)")
             self.hud.dismiss()
             if let result = response.value {
                 if let list = result.data {
                     self.getCdatList = list
                     if Environment.SYS_LANG == "ja" {
                         for index in self.getCdatList.indices {
                             self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                         }
                     }
                 }
             }

         }) { (error) in
             self.hud.dismiss()
         }
    }
    
    
    func getWorkRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
//        print("getWorkRead yyyymm : \(yyyymm)")
        ApiService.request(router: WorkingApi.workingRead(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingReadResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("getWorkRead result : \(result)")
                if let baseWorkingHour = result.data?.baseWorkingHour {
                    self.lblbaseWorkinghourValue.text = String(Int(baseWorkingHour))
                }
                if let addWorkingHour = result.data?.addWorkingHour {
                    self.lbladdWorkinghourValue.text = String(Int(addWorkingHour))
                }
                
                if let maxWorkingHour = result.data?.maxWorkingHour {
                    self.lblmaxWorkinghourValue.text = String(Int(maxWorkingHour))
                }
                if let workingHour = result.data?.workingHour {
                    self.lblWorkinghourValue.text = String(Int(workingHour))
                }
                if let etcWorkingHour = result.data?.etcWorkingHour {
                    self.lblEtcWorkinghourValue.text = String(Int(etcWorkingHour))
                }
                if let workingGrade = result.data?.workingGrade {
                    switch workingGrade {
                    case 1:
                        self.lblWorkingGrade.text = "양호".localized
                        self.lblWorkingGrade.textColor = UIColor(red: 0.039, green: 0.559, blue: 0.851, alpha: 1)
                    case 2:
                        self.lblWorkingGrade.text = "경계".localized
                        self.lblWorkingGrade.textColor = UIColor(red: 0.039, green: 0.851, blue: 0.686, alpha: 1)
                    case 3:
                        self.lblWorkingGrade.text = "주의".localized
                        self.lblWorkingGrade.textColor = UIColor(red: 0.946, green: 0.698, blue: 0.059, alpha: 1)
                        
                    case 4:
                        self.lblWorkingGrade.text = "위험".localized
                        self.lblWorkingGrade.textColor = UIColor(red: 0.946, green: 0.538, blue: 0.059, alpha: 1)
                    default:
                        self.lblWorkingGrade.text = "법위반".localized
                        self.lblWorkingGrade.textColor = UIColor(red: 0.851, green: 0.137, blue: 0.039, alpha: 1)
                    }
                }
            }

        }) { (error) in
            self.hud.dismiss()
            
        }
        
    }
    
    func getWorkList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
//        print("getWorkList yyyymm : \(yyyymm)")
        ApiService.request(router: WorkingApi.workingList(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
//                print("WorkingPlanRequest result : \(result)")
                if let list = result.data {
                    
                    self.workingList = self.workingList+list
//                    print("self.workingList in getworklist : \(self.workingList)")
                    self.cvCalendar.reloadData()
                }
            }

        }) { (error) in
            self.hud.dismiss()
            
        }
        
    }
}

extension MyWorkingListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 7
        } else {
            return days.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.ID, for: indexPath) as! CalendarCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.dayLabel.text = weeks[indexPath.row]
            cell.dayLabel.textColor = .black
//            print("cell.dayLabel.text : \(cell.dayLabel.text)")
            if indexPath.row % 7 == 0 { // 일요일
                cell.dayLabel.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            } else if indexPath.row % 7 == 6 { // 토요일
                cell.dayLabel.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
            } else {
                cell.dayLabel.textColor = .black
            }
            cell.dayLabel.isHidden = false
            cell.lblDayValue.isHidden = true
            cell.lblcdat21.isHidden = true
            cell.lbluphma3.isHidden = true
            cell.lblwPlan.isHidden = true
            
            
        default:
            cell.lblDayValue.text = days[indexPath.row]
            cell.lblDayValue.textColor = .black
          
            if indexPath.row % 7 == 0 { // 일요일
                cell.lblDayValue.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
            } else if indexPath.row % 7 == 6 { // 토요일
                cell.lblDayValue.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
            } else {
                cell.lblDayValue.textColor = .black
            }
            cell.dayLabel.isHidden = true
            cell.lblDayValue.isHidden = false
            cell.lblcdat21.isHidden = true
            if indexPath.row < workingList.count {
                
                if let cdtx95 = workingList[indexPath.row].cdtx95 {
                    if cdtx95 == "S" {
                        cell.lblDayValue.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
                    } else if cdtx95 == "H" || cdtx95 == "M" {
                        cell.lblDayValue.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
                    }
                }
                
                if let cdat21 = workingList[indexPath.row].cdat21, cdat21 != "0", !cdat21.isEmpty{
                    for item in getCdatList {
                        if item.subCd == cdat21 {
                            cell.lblcdat21.text = String(item.subNm ?? "")
                        }
                    }
                    cell.lblcdat21.isHidden = false
                }
                if let uphma3 = workingList[indexPath.row].uphma3, uphma3 != 0 {
                    cell.lbluphma3.isHidden = false
                    cell.lbluphma3.text = String(Int(uphma3))
                } else {
                    cell.lbluphma3.isHidden = true
                }
                
                if let wPlan = workingList[indexPath.row].wPlan, wPlan != 0  {
                    cell.lblwPlan.isHidden = false
                    cell.lblwPlan.text = String(Int(wPlan))
                } else {
                    cell.lblwPlan.isHidden = true
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
//        print("selected cell : \(cell)")
//        print("selected : \(indexPath.row)")
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let collectionViewSize = collectionView.frame.size.width/7
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 32)
        } else {
            let collectionViewSize = collectionView.frame.size.width/7
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 120)
        }
        
    }
}

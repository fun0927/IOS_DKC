//
//  WorkingPlanViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import UIKit
import JGProgressHUD

class WorkingPlanViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
    
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
    let ivNext:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "next")
        return imageView
    }()
    let btnNext: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let cvPlan = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvPlanHeightAnchor:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WorkingPlanViewController viewdidload")
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
        //        let leftSumViewWidth = view.frame.width * (375/495)
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
        workingHourLabel.leadingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor, constant: 10).isActive = true
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
        
        scrollView.addSubview(ivNext)
        ivNext.translatesAutoresizingMaskIntoConstraints = false
        ivNext.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        ivNext.leadingAnchor.constraint(equalTo: lblMonth.trailingAnchor, constant: 18).isActive = true
        ivNext.widthAnchor.constraint(equalToConstant: 10).isActive = true
        ivNext.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        scrollView.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnNext.leadingAnchor.constraint(equalTo: lblMonth.trailingAnchor, constant: 18).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnNext.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvPlan.collectionViewLayout = cvLayout
        
        cvPlan.delegate = self
        cvPlan.dataSource = self
        cvPlan.backgroundColor = .white
        scrollView.addSubview(cvPlan)
        cvPlan.translatesAutoresizingMaskIntoConstraints = false
        cvPlan.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 24).isActive = true
        cvPlan.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvPlan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        let cvHeight = 120*7+32
        //        cvCalendar.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight)).isActive = true
        cvPlanHeightAnchor = cvPlan.heightAnchor.constraint(equalToConstant: 51)
        cvPlanHeightAnchor?.isActive = true
        cvPlan.register(WorkingPlanCollectionViewCell.self, forCellWithReuseIdentifier: WorkingPlanCollectionViewCell.ID)
        cvPlan.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        cvPlan.isScrollEnabled = false
        // Do any additional setup after loading the view.
        
        initial()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: Notification.Name(rawValue: "callReload"),
            object: nil)
    }
    @objc func reload() {
        getRead()
        getList()
    }
    
    var codeList:[CodeListDetailResponse] = []
    var planList:[WorkingPlanDetailListResponse] = []
    
    var cal = Calendar.current
    let yyyymmFormatter = DateFormatter()
    let yyyyDotmmFormatter = DateFormatter()
    var components = DateComponents()
    
    func initial() {
        yyyymmFormatter.dateFormat = "yyyyMM"
        yyyyDotmmFormatter.dateFormat = "yyyy.MM"
        
        let now = Date()
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        
        calculation()
        getCodeList(mainCd: "HT016_ATS")
        getRead()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        getRead()
        //        getList()
    }
    
    @objc func btnPreviousClicked(){
        components.month = components.month! - 1
        self.calculation()
        getRead()
        getList()
//        self.cvPlan.reloadData()
    }
    
    @objc func btnNextClicked(){
        components.month = components.month! + 1
        self.calculation()
        getRead()
        getList()
//        self.cvPlan.reloadData()
        
    }
    func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        self.lblMonth.text = yyyyDotmmFormatter.string(from: firstDayOfMonth!)
    }
    
    func getCodeList(mainCd:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: mainCd)), success: { (response: ApiResponse<CodeListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.codeList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.codeList.indices {
                            self.codeList[index].subNm = self.codeList[index].jpnSubNm
                        }
                    }
                    self.getList()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    func getRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        print("getWorkRead yyyymm : \(yyyymm)")
        ApiService.request(router: WorkPlanApi.workPlan(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingReadResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let baseWorkingHour = result.data?.baseWorkingHour {
                    if baseWorkingHour == Double(Int(baseWorkingHour)) {
                        self.lblbaseWorkinghourValue.text = String(Int(baseWorkingHour))
                    }else {
                        self.lblbaseWorkinghourValue.text = String(baseWorkingHour)
                    }
                }
                if let addWorkingHour = result.data?.addWorkingHour {
                    if addWorkingHour == Double(Int(addWorkingHour)) {
                        self.lbladdWorkinghourValue.text = String(Int(addWorkingHour))
                    }else {
                        self.lbladdWorkinghourValue.text = String(addWorkingHour)
                    }
                }
                if let maxWorkingHour = result.data?.maxWorkingHour {
                    if maxWorkingHour == Double(Int(maxWorkingHour)) {
                        self.lblmaxWorkinghourValue.text = String(Int(maxWorkingHour))
                    }else {
                        self.lblmaxWorkinghourValue.text = String(maxWorkingHour)
                    }
                }
                if let workingHour = result.data?.workingHour {
                    if workingHour == Double(Int(workingHour)) {
                        self.lblWorkinghourValue.text = String(Int(workingHour))
                    }else {
                        self.lblWorkinghourValue.text = String(format: "%.1f", workingHour)
                    }
                }
                if let etcWorkingHour = result.data?.etcWorkingHour {
                    if etcWorkingHour == Double(Int(etcWorkingHour)) {
                        self.lblEtcWorkinghourValue.text = String(Int(etcWorkingHour))
                    }else {
                        self.lblEtcWorkinghourValue.text = String(format: "%.1f", etcWorkingHour)
                    }
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
    func getList(){
        print("getWorkingplan")
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        print("getWorkingplan yyyymm : \(yyyymm)")
        ApiService.request(router: WorkPlanApi.workPlanList(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkingPlanListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.planList = list
                    self.cvPlanHeightAnchor?.isActive = false
                    let cvPlanHeight = 51 + self.planList.count*51
                    self.cvPlanHeightAnchor = self.cvPlan.heightAnchor.constraint(equalToConstant: CGFloat(cvPlanHeight))
                    self.cvPlanHeightAnchor?.isActive = true
                    self.cvPlan.reloadData()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
}

extension WorkingPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return planList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingPlanCollectionViewCell.ID, for: indexPath) as! WorkingPlanCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblDate.text = "일자".localized
            cell.lblDate.textColor = .black
            cell.lblTime.text = "시간".localized
            cell.lblTime.textColor = .black
            cell.lblWorkingHour.text = "근무시간".localized
            cell.lblCdat.text = "근태".localized
            cell.lblStat.text = "상태".localized
            
        default:
            cell.lblTime.text = ""
            cell.lblCdat.text = ""
            cell.lblWorkingHour.text = ""
            cell.lblStat.text = ""
            
            if let cdatCd = planList[indexPath.row].cdat3 {
                for item in codeList {
                    if let subCd = item.subCd, subCd == cdatCd {
                        cell.lblCdat.text = item.subNm
                    }
                }
            }
            if let cdatCd = planList[indexPath.row].cdat2 {
                for item in codeList {
                    if let subCd = item.subCd, subCd == cdatCd {
                        cell.lblCdat.text = item.subNm
                    }
                }
            }
            if let cdatCd = planList[indexPath.row].cdat1 {
                for item in codeList {
                    if let subCd = item.subCd, subCd == cdatCd {
                        cell.lblCdat.text = item.subNm
                    }
                }
            }
            
            if let yyyymmdd = planList[indexPath.row].yyyymmdd {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier:"ko_KR")
                dateFormatter.dateFormat = "yyyyMMdd" // 월 표시 포맷 설정
                if let getDate = dateFormatter.date(from: yyyymmdd) {
                    let weekday = Calendar.current.component(.weekday, from: getDate)
                    cell.lblDate.text = "\(String(yyyymmdd.suffix(2)))(\(util.getWeekDayFromNum(num: weekday)))"
                    if weekday == 1 {
                        cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
                    } else if weekday == 7 {
                        cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
                    } else {
                        cell.lblDate.textColor = .black
                    }
                }
            }
            
            if let workTime = planList[indexPath.row].workTime {
                cell.lblTime.text = String(workTime)
            }
            if let comeTime = planList[indexPath.row].comeTime, let leaveTime = planList[indexPath.row].leaveTime {
                let editComeStart = String(comeTime.prefix(2))
                let editComeEnd = (comeTime.suffix(2))
                let editLeaveStart = String(leaveTime.prefix(2))
                let editLeaveEnd = String(leaveTime.suffix(2))
                cell.lblWorkingHour.text = "\(editComeStart):\(editComeEnd)~\(editLeaveStart):\(editLeaveEnd)"
            }
            
            if let stat =  planList[indexPath.row].stat {
                switch stat {
                case "1":
                    cell.lblStat.text = "마감".localized
                case "2":
                    cell.lblStat.text =  "등록".localized
                default:
                    cell.lblStat.text =  "미등록".localized
                }
            }
            cell.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plan = planList[indexPath.row]
        print("selected : \(indexPath.row), plan  : \(plan)")
        if let getVc = util.getViewControllerFromText(label: "근무 계획 등록 상세".localized) {
            print("WorkingPlan didSelectRowAt getVc : \(getVc)")
            // stat 1: 마감, 2: 등록, 3: 미등록
            if let getVc2 = getVc as? WorkingPlanRegisterViewController, let stat = plan.stat, stat != "1" {
//                getVc2.selectedDate = plan.yyyymmdd!
                getVc2.monthPlanList = planList
                getVc2.monthPlan = plan
                getVc2.getCdatList = self.codeList
                getVc2.modalPresentationStyle = .fullScreen
                getVc2.previousViewController = self
                self.present(getVc2, animated: true, completion: nil)
            }
        } else {
            print("no vc")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        return CGSize(width: collectionViewSize, height: 51)
    }
}

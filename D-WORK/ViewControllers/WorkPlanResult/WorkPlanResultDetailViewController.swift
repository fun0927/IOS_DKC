//
//  WorkPlanResultDetailViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/17.
//

import UIKit
import JGProgressHUD

class WorkPlanResultDetailViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    enum ViewTypeEnum {
        case WorkOver, WorkResult
    }
    var viewType = ViewTypeEnum.WorkResult
    
    let hud = JGProgressHUD()
    let util = Util()
    var workPlanResultInfoData:WorkPlanResultInfoListData?
    var yyyymm = ""
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 0.8)
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let backGroundViewTwo = UIView()
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
        label.text = "잔여시간".localized
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
    
    var WorkPlanResultDetailList:[WorkPlanResultDetailListData] = []
    let cvWorkPlanResultDetail = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvWorkPlanResultDetailHeightAnchor:NSLayoutConstraint?
    
    var getCdatList:[CodeListDetailResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
        topView.backDelegate = self
        topView.titleDelegate = self
        topView.isShowBtnBack = true
        topView.isShowNoti = true
        
        self.view.addSubview(topView)
        
        view.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 55).isActive = true
        let year = yyyymm.prefix(4)
        var month = yyyymm.suffix(2)
        if month.prefix(1) == "0"{
            month = month.suffix(1)
        }
        if viewType == .WorkResult {
            lblTitle.text = "\(year)" + "년".localized + " \(month)" + "월".localized + " \(workPlanResultInfoData?.prsnNm ?? "") " + "계획 실적 현황".localized
        } else if viewType == .WorkOver {
            lblTitle.text = "\(year)" + "년".localized + " \(month)" + "월".localized + " \(workPlanResultInfoData?.prsnNm ?? "") " + "초과 근로 현황".localized
        }
        
        let rightSummaryView = UIView()
        view.addSubview(rightSummaryView)
        rightSummaryView.translatesAutoresizingMaskIntoConstraints = false
        rightSummaryView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        rightSummaryView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        rightSummaryView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rightSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightSummaryView.backgroundColor = UIColor(red: 0.039, green: 0.559, blue: 0.851, alpha: 1)
        
        let leftSummaryView = UIView()
        view.addSubview(leftSummaryView)
        leftSummaryView.translatesAutoresizingMaskIntoConstraints = false
        leftSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftSummaryView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        leftSummaryView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        let leftSumViewWidth = view.frame.width * (375/495)
        //        leftSummaryView.widthAnchor.constraint(equalToConstant: leftSumViewWidth).isActive = true
        leftSummaryView.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor).isActive = true
        leftSummaryView.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        
        view.addSubview(lblWorkingGrade)
        lblWorkingGrade.translatesAutoresizingMaskIntoConstraints = false
        lblWorkingGrade.centerYAnchor.constraint(equalTo: leftSummaryView.centerYAnchor).isActive = true
        lblWorkingGrade.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        lblWorkingGrade.widthAnchor.constraint(equalToConstant: 56).isActive = true
        lblWorkingGrade.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        view.addSubview(baseWorkinghourLabel)
        baseWorkinghourLabel.translatesAutoresizingMaskIntoConstraints = false
        baseWorkinghourLabel.leadingAnchor.constraint(equalTo: leftSummaryView.leadingAnchor, constant: 80).isActive = true
        baseWorkinghourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        baseWorkinghourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(addWorkingHourLabel)
        addWorkingHourLabel.textAlignment = .center
        addWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        addWorkingHourLabel.leadingAnchor.constraint(equalTo: lblWorkingGrade.trailingAnchor).isActive = true
        addWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor).isActive = true
        addWorkingHourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        addWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(maxWorkingHourLabel)
        maxWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        maxWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor, constant: -16).isActive = true
        maxWorkingHourLabel.topAnchor.constraint(equalTo: leftSummaryView.topAnchor, constant: 24).isActive = true
        maxWorkingHourLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(lblbaseWorkinghourValue)
        lblbaseWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblbaseWorkinghourValue.centerXAnchor.constraint(equalTo: baseWorkinghourLabel.centerXAnchor).isActive = true
        lblbaseWorkinghourValue.topAnchor.constraint(equalTo: baseWorkinghourLabel.bottomAnchor, constant: 4).isActive = true
        
        view.addSubview(lblmaxWorkinghourValue)
        lblmaxWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblmaxWorkinghourValue.centerXAnchor.constraint(equalTo: maxWorkingHourLabel.centerXAnchor).isActive = true
        lblmaxWorkinghourValue.topAnchor.constraint(equalTo: maxWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        view.addSubview(lbladdWorkinghourValue)
        lbladdWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lbladdWorkinghourValue.centerXAnchor.constraint(equalTo: addWorkingHourLabel.centerXAnchor).isActive = true
        lbladdWorkinghourValue.topAnchor.constraint(equalTo: addWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        // 실근로, 잔여근로
        view.addSubview(workingHourLabel)
        workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        workingHourLabel.topAnchor.constraint(equalTo: rightSummaryView.topAnchor, constant: 24).isActive = true
        workingHourLabel.leadingAnchor.constraint(equalTo: rightSummaryView.leadingAnchor, constant: 10).isActive = true
        workingHourLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        view.addSubview(etcWorkingHourLabel)
        etcWorkingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        etcWorkingHourLabel.topAnchor.constraint(equalTo: rightSummaryView.topAnchor, constant: 24).isActive = true
        etcWorkingHourLabel.trailingAnchor.constraint(equalTo: rightSummaryView.trailingAnchor, constant: -17).isActive = true
        etcWorkingHourLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        view.addSubview(lblWorkinghourValue)
        lblWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblWorkinghourValue.centerXAnchor.constraint(equalTo: workingHourLabel.centerXAnchor).isActive = true
        lblWorkinghourValue.topAnchor.constraint(equalTo: workingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        view.addSubview(lblEtcWorkinghourValue)
        lblEtcWorkinghourValue.translatesAutoresizingMaskIntoConstraints = false
        lblEtcWorkinghourValue.centerXAnchor.constraint(equalTo: etcWorkingHourLabel.centerXAnchor).isActive = true
        lblEtcWorkinghourValue.topAnchor.constraint(equalTo: etcWorkingHourLabel.bottomAnchor, constant: 4).isActive = true
        
        backGroundViewTwo.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(backGroundViewTwo)
        backGroundViewTwo.translatesAutoresizingMaskIntoConstraints = false
        backGroundViewTwo.topAnchor.constraint(equalTo: leftSummaryView.bottomAnchor).isActive = true
        backGroundViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundViewTwo.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 8
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvWorkPlanResultDetail.collectionViewLayout = cvLayout
        
        cvWorkPlanResultDetail.delegate = self
        cvWorkPlanResultDetail.dataSource = self
        cvWorkPlanResultDetail.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(cvWorkPlanResultDetail)
        cvWorkPlanResultDetail.translatesAutoresizingMaskIntoConstraints = false
        cvWorkPlanResultDetail.topAnchor.constraint(equalTo: leftSummaryView.bottomAnchor, constant: 24).isActive = true
        cvWorkPlanResultDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvWorkPlanResultDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvWorkPlanResultDetail.register(WorkPlanResultDetailCollectionViewCell.self, forCellWithReuseIdentifier: WorkPlanResultDetailCollectionViewCell.ID)
        cvWorkPlanResultDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        getCdatCode()
        getDetailRead()
    }
    
    
    func getCdatCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        // 근태코드
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HT016_ATS")), success: { (response: ApiResponse<CodeListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.getCdatList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getCdatList.indices {
                            self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                        }
                    }
                    self.getDetailList()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    func getDetailRead(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkPlanResultApi.detailRead(
            param: WorkPlanResultInfoListRequest(
                yyyymm: yyyymm,
                divCdParam: workPlanResultInfoData?.divCd ?? "",
                prsnCdParam: workPlanResultInfoData?.prsnCd ?? "")),
                           success: { (response: ApiResponse<WorkingReadResponse>) in
                    if let result = response.value {
                        if let data = result.data {
                            if let baseWorkingHour = data.baseWorkingHour {
                                if baseWorkingHour == Double(Int(baseWorkingHour)) {
                                    self.lblbaseWorkinghourValue.text = String(Int(baseWorkingHour))
                                }else {
                                    self.lblbaseWorkinghourValue.text = String(format: "%.1f", baseWorkingHour)
                                }
                            }
                            if let addWorkingHour = data.addWorkingHour {
                                if addWorkingHour == Double(Int(addWorkingHour)) {
                                    self.lbladdWorkinghourValue.text = String(Int(addWorkingHour))
                                }else {
                                    self.lbladdWorkinghourValue.text = String(format: "%.1f", addWorkingHour)
                                }
                            }
                            if let maxWorkingHour = data.maxWorkingHour {
                                if maxWorkingHour == Double(Int(maxWorkingHour)) {
                                    self.lblmaxWorkinghourValue.text = String(Int(maxWorkingHour))
                                }else {
                                    self.lblmaxWorkinghourValue.text = String(format: "%.1f", maxWorkingHour)
                                }
                            }
                            if let workingHour = data.workingHour {
                                if workingHour == Double(Int(workingHour)) {
                                    self.lblWorkinghourValue.text = String(Int(workingHour))
                                }else {
                                    self.lblWorkinghourValue.text = String(format: "%.1f", workingHour)
                                }
                            }
                            if let etcWorkingHour = data.etcWorkingHour {
                                if (etcWorkingHour) == Double(Int((etcWorkingHour))) {
                                    self.lblEtcWorkinghourValue.text = String(Int((etcWorkingHour)))
                                }else {
                                    self.lblEtcWorkinghourValue.text = String(format: "%.1f", etcWorkingHour)
                                }
                            }
                            if let workingGrade = data.workingGrade {
                                switch workingGrade {
                                case 1:
                                    self.lblWorkingGrade.text = "양호".localized
                                    self.lblWorkingGrade.backgroundColor = UIColor(red: 0.039, green: 0.559, blue: 0.851, alpha: 1)
                                case 2:
                                    self.lblWorkingGrade.text = "경계".localized
                                    self.lblWorkingGrade.backgroundColor = UIColor(red: 0.039, green: 0.851, blue: 0.686, alpha: 1)
                                case 3:
                                    self.lblWorkingGrade.text = "주의".localized
                                    self.lblWorkingGrade.backgroundColor = UIColor(red: 0.946, green: 0.698, blue: 0.059, alpha: 1)
                                case 4:
                                    self.lblWorkingGrade.text = "위험".localized
                                    self.lblWorkingGrade.backgroundColor = UIColor(red: 0.946, green: 0.538, blue: 0.059, alpha: 1)
                                default:
                                    self.lblWorkingGrade.text = "법위반".localized
                                    self.lblWorkingGrade.backgroundColor = UIColor(red: 0.851, green: 0.137, blue: 0.039, alpha: 1)
                                }
                            }
                        }
                    }
                    self.hud.dismiss()
                }) { (error) in
                    print("getDetailRead error : \(error)")
                    self.hud.dismiss()
                }
    }
    
    func getDetailList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkPlanResultApi.detailList(
            param: WorkPlanResultInfoListRequest(
                yyyymm: yyyymm,
                divCdParam: workPlanResultInfoData?.divCd ?? "",
                prsnCdParam: workPlanResultInfoData?.prsnCd ?? "")), success: { (response: ApiResponse<WorkPlanResultDetailListResponse>) in
                    self.hud.dismiss()
                    if let result = response.value?.data {
                        self.WorkPlanResultDetailList = result
                        self.cvWorkPlanResultDetail.reloadData()
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
    
}

extension WorkPlanResultDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WorkPlanResultDetailList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkPlanResultDetailCollectionViewCell.ID, for: indexPath) as! WorkPlanResultDetailCollectionViewCell
        let item = WorkPlanResultDetailList[indexPath.row]
        
        // 계획근로 매칭
        if let yyyymmdd = WorkPlanResultDetailList[indexPath.row].yyyymmdd {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier:"ko_KR")
            dateFormatter.dateFormat = "yyyyMMdd" // 월 표시 포맷 설정
            if let getDate = dateFormatter.date(from: yyyymmdd) {
                let weekday = Calendar.current.component(.weekday, from: getDate)
                cell.lblDate.text = "\(String(yyyymmdd.suffix(2)))\n(\(util.getWeekDayFromNum(num: weekday)))"
                if let week = WorkPlanResultDetailList[indexPath.row].week {
                    if week == "S" {
                        cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
                    } else if week == "M" || week == "H" {
                        cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
                    }
                }
            }
        }
        if let comeLeaveTimePlan = WorkPlanResultDetailList[indexPath.row].comeLeaveTimePlan {
            cell.lblWorkPlanComeValue.text = "\(comeLeaveTimePlan.prefix(5))"
            cell.lblWorkPlanLeaveValue.text = "\(comeLeaveTimePlan.suffix(5))"
        }
        if let workTimePlan = item.workTimePlan {
            if(workTimePlan == Double(Int(workTimePlan))) {
                cell.lblWorkPlanWorkTimeValue.text = "\(Int(workTimePlan)) H"
            }else {
                cell.lblWorkPlanWorkTimeValue.text = "\(workTimePlan) H"
            }
        }
        if let cdat1 = item.cdat21Plan, cdat1 != "0", !cdat1.isEmpty{
            for item in getCdatList {
                if item.subCd == cdat1 {
                    cell.lblWorkPlanCdatValue1.text = String(item.subNm ?? "")
                }
            }
        }
        if let cdat2 = item.cdat22Plan, cdat2 != "0", !cdat2.isEmpty{
            for item in getCdatList {
                if item.subCd == cdat2 {
                    cell.lblWorkPlanCdatValue2.text = String(item.subNm ?? "")
                }
            }
        }
        
        // 실근로 값 매칭
        if let comeLeaveTime = WorkPlanResultDetailList[indexPath.row].comeLeaveTime {
            cell.lblWorkComeValue.text = "\(comeLeaveTime.prefix(5))"
            cell.lblWorkLeaveValue.text = "\(comeLeaveTime.suffix(5))"
        }
        if let workTime = item.workTime {
            //            cell.lblWorkWorkTimeValue.text = "\(workTime) H"
            if(workTime == Double(Int(workTime))) {
                cell.lblWorkWorkTimeValue.text = "\(Int(workTime)) H"
            }else {
                cell.lblWorkWorkTimeValue.text = "\(workTime) H"
            }
        }
        if let cdat1 = item.cdat21, cdat1 != "0", !cdat1.isEmpty{
            for item in getCdatList {
                if item.subCd == cdat1 {
                    cell.lblWorkCdatValue1.text = String(item.subNm ?? "")
                }
            }
        }
        if let cdat2 = item.cdat22, cdat2 != "0", !cdat2.isEmpty{
            for item in getCdatList {
                if item.subCd == cdat2 {
                    cell.lblWorkCdatValue2.text = String(item.subNm ?? "")
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print("selected : \(indexPath.row)")
        //        let vc = WorkPlanResultDetailViewController()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 254)
        
        
    }
}

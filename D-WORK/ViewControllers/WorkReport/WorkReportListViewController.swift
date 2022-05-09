//
//  WorkReportListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import UIKit
import JGProgressHUD

class WorkReportListViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
    var codeList:[CodeListDetailResponse] = []
    
    let cvReport = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var isClose = false
    var reportList:[WorkReportListDetailResponse] = []
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // 달력
        view.addSubview(lblMonth)
        lblMonth.translatesAutoresizingMaskIntoConstraints = false
        lblMonth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblMonth.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        
        //        view.addSubview(btnPrevious)
        //        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
        //        btnPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        //        btnPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        //        btnPrevious.widthAnchor.constraint(equalToConstant: 10).isActive = true
        //        btnPrevious.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        
        view.addSubview(ivPrevious)
        ivPrevious.translatesAutoresizingMaskIntoConstraints = false
        ivPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        ivPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        ivPrevious.widthAnchor.constraint(equalToConstant: 10).isActive = true
        ivPrevious.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addSubview(btnPrevious)
        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
        btnPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        btnPrevious.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        
        
        view.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnNext.leadingAnchor.constraint(equalTo: lblMonth.trailingAnchor, constant: 18).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvReport.collectionViewLayout = cvLayout
        
        cvReport.delegate = self
        cvReport.dataSource = self
        cvReport.backgroundColor = .white
        view.addSubview(cvReport)
        cvReport.translatesAutoresizingMaskIntoConstraints = false
        cvReport.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 24).isActive = true
        cvReport.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvReport.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvReport.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cvReport.register(WorkReportListCollectionViewCell.self, forCellWithReuseIdentifier: WorkReportListCollectionViewCell.ID)
        
        dateFormatter.dateFormat = "yyyy.MM" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        
        calculation()
        //        getCodeList(mainCd: "HT016_ATS")
        
    }
    
    @objc func btnPreviousClicked(){
        components.month = components.month! - 1
        self.calculation()
        getWorkingReport()
        self.cvReport.reloadData()
    }
    
    @objc func btnNextClicked(){
        components.month = components.month! + 1
        self.calculation()
        getWorkingReport()
        self.cvReport.reloadData()
    }
    func calculation() { // 월 별 일 수 계산
        let firstDayOfMonth = cal.date(from: components)
        self.lblMonth.text = dateFormatter.string(from: firstDayOfMonth!)
    }
    override func viewWillAppear(_ animated: Bool) {
        getWorkingReport()
    }
    
    func getWorkingReport(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        
        ApiService.request(router: WorkReportApi.masterList(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<WorkReportListResponse>) in
            self.hud.dismiss()
            //            print("response : \(response)")
            
            if let result = response.value {
                self.isClose = result.data?.isClose ?? false
                //                print("result : \(result)")
                if let list = result.data?.list {
                    self.reportList = list
                    self.cvReport.reloadData()
                }
                
            }
            
        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
            
            return
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


extension WorkReportListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return reportList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkReportListCollectionViewCell.ID, for: indexPath) as! WorkReportListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblDate.text = "일자".localized
            cell.lblcomeTime.text = "출근".localized
            cell.lblleaveTime.text = "퇴근".localized
            cell.lblafsta3Nm.text = "상태".localized
            cell.lblcdat21Nm.text = "근태".localized
            
        default:
            cell.lblDate.text = reportList[indexPath.row].ddate
            cell.lblcomeTime.text = ""
            cell.lblleaveTime.text = ""
            
            if let comeTime = reportList[indexPath.row].comeTime {
                let editComeStart = String(comeTime.prefix(2))
                let editComeEnd = (comeTime.suffix(2))
                cell.lblcomeTime.text = "\(editComeStart):\(editComeEnd)"
                
            }
            if let leaveTime = reportList[indexPath.row].leaveTime {
                let editLeaveStart = String(leaveTime.prefix(2))
                let editLeaveEnd = String(leaveTime.suffix(2))
                cell.lblleaveTime.text = "\(editLeaveStart):\(editLeaveEnd)"
            }
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm6
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm5
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm4
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm3
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm2
            cell.lblcdat21Nm.text = reportList[indexPath.row].cdat21Nm1
            if let afsta3Nm = reportList[indexPath.row].afsta3Nm {
                cell.lblafsta3Nm.text = afsta3Nm == "" ? "미작성".localized : afsta3Nm
            }
            cell.backgroundColor = .white
            
            if let cdtx95 = reportList[indexPath.row].cdtx95 {
                if cdtx95 == "H" || cdtx95 == "M" {
                    cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
                }else if cdtx95 == "S" {
                    cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
                }else {
                    cell.lblDate.textColor = .black
                }
            }
            
//            let dtnm95 = reportList[indexPath.row].dtnm95
//            if dtnm95 == "일요일".localized {
//                cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
//            } else if dtnm95 == "토요일".localized {
//                cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
//            } else {
//                cell.lblDate.textColor = .black
//            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let report = reportList[indexPath.row]
        //        print("selected : \(indexPath.row), report  : \(report)")
        if let getVc = util.getViewControllerFromText(label: "업무 일지 등록 상세".localized) {
            if let getVc2 = getVc as? WorkReportRegisterViewController {
                let firstDayOfMonth = cal.date(from: components)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
                
                let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
                if let ddate = report.ddate, let dtan95 = report.dtan95 {
                    print("yyyymm : \(yyyymm)")
                    print("ddate : \(ddate)")
                    //                    getVc2.yyyymmdd = yyyymm+ddate
                    getVc2.isClose = self.isClose
                    getVc2.yyyymmdd = dtan95
                    getVc2.comeTime = report.comeTime ?? ""
                    getVc2.cdat21Nm1 = report.cdat21Nm1 ?? ""
                    getVc2.cdat21Nm2 = report.cdat21Nm2 ?? ""
                    getVc2.cdat21Nm3 = report.cdat21Nm3 ?? ""
                    getVc2.cdat21Nm4 = report.cdat21Nm4 ?? ""
                    getVc2.cdat21Nm5 = report.cdat21Nm5 ?? ""
                    getVc2.cdat21Nm6 = report.cdat21Nm6 ?? ""
                    getVc2.reportData = report
                    getVc2.modalPresentationStyle = .fullScreen
                    present(getVc2, animated: true, completion: nil)
                    //                    NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        return CGSize(width: collectionViewSize, height: 51)
    }
}

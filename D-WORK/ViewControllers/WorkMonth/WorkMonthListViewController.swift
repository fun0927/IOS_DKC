//
//  WorkMonthListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/09.
//

import UIKit
import JGProgressHUD
class WorkMonthListViewController: UIViewController {
    let hud = JGProgressHUD()
    let cvCalendar = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일".localized, "월".localized, "화".localized, "수".localized, "목".localized, "금".localized, "토".localized]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    var infoList:[MonthWorkInfoListData] = []
    var getCdatList:[CodeListDetailResponse] = []
    
    let cvInfo = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let lblMonth: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    let util = Util()
    
    let btnPrevious: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(named: "previous"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
//        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
//        button.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
//        button.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
//        button.layer.borderWidth = 1
//        button.layer.cornerRadius = 8
//        button.layer.masksToBounds = true
        
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
        view.backgroundColor = .white
        view.addSubview(lblMonth)
        lblMonth.translatesAutoresizingMaskIntoConstraints = false
        lblMonth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblMonth.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        
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
        cvInfo.collectionViewLayout = cvLayout
        
        cvInfo.delegate = self
        cvInfo.dataSource = self
        cvInfo.backgroundColor = .white
        view.addSubview(cvInfo)
        cvInfo.translatesAutoresizingMaskIntoConstraints = false
        cvInfo.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 24).isActive = true
        cvInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        cvInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        cvInfo.widthAnchor.constraint(equalToConstant: 343).isActive = true
        cvInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cvInfo.register(MonthWorkInfoListCollectionViewCell.self, forCellWithReuseIdentifier: MonthWorkInfoListCollectionViewCell.ID)
      
        // Do any additional setup after loading the view.
        getCdatCode()
        dateFormatter.dateFormat = "yyyy.MM" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        calculation()
        getMonthWorkInfoList()
    }
    
    @objc func btnPreviousClicked(){
        print("btnPreviousClicked")
        components.month = components.month! - 1
        self.calculation()
        getMonthWorkInfoList()
        
    }
    
    @objc func btnNextClicked(){
        components.month = components.month! + 1
        self.calculation()
        getMonthWorkInfoList()
        
    }
    func calculation() { // 월 별 일 수 계산
        let firstDayOfMonth = cal.date(from: components)
        self.lblMonth.text = dateFormatter.string(from: firstDayOfMonth!)
    }
    
    func getMonthWorkInfoList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        
        ApiService.request(router: MonthWorkApi.infoList(param: WorkingPlanRequest(yyyymm: yyyymm)), success: { (response: ApiResponse<MonthWorkInfoListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let list = result.data {
                    self.infoList = list
                    self.cvInfo.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
        }
        
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WorkMonthListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return infoList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthWorkInfoListCollectionViewCell.ID, for: indexPath) as! MonthWorkInfoListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lbldd.text = "일자".localized
            cell.lblsthm21.text = "출근".localized
            cell.lblenhm21.text = "퇴근".localized
            cell.lblcdat1.text = "근태".localized
            cell.lblcdat2.text = "근태".localized
            cell.lblcdat3.text = "근태".localized
            cell.lbldd.textColor = .black
        default:
            cell.lbldd.text = infoList[indexPath.row].dd
            cell.lblsthm21.text = ""
            cell.lblenhm21.text = ""
            cell.lblcdat1.text = ""
            cell.lblcdat2.text = ""
            cell.lblcdat3.text = ""
            if let dd = infoList[indexPath.row].dd {
//                let index = yyyymmdd.index(yyyymmdd.endIndex, offsetBy: -2)
                let firstDayOfMonth = cal.date(from: components)
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyyMM" // 월 표시 포맷 설정
                let yyyymm = dateFormatter1.string(from: firstDayOfMonth!)
                let yyyymmdd = "\(yyyymm)\(dd)"
                print("yyyymmdd : \(yyyymmdd)")
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier:"ko_KR")
                dateFormatter.dateFormat = "yyyyMMdd"
                
                if let getDate = dateFormatter.date(from: yyyymmdd) {
                    let weekday = Calendar.current.component(.weekday, from: getDate)
                    cell.lbldd.text = "\(String(yyyymmdd.suffix(2)))(\(util.getWeekDayFromNum(num: weekday)))"
                    if weekday == 1 {
                        cell.lbldd.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
                    } else if weekday == 7 {
                        cell.lbldd.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
                    } else {
                        cell.lbldd.textColor = .black
                    }
                }
            }
            if let comeTime = infoList[indexPath.row].sthm21 {
                let editComeStart = String(comeTime.prefix(2))
                let editComeEnd = (comeTime.suffix(2))
                cell.lblsthm21.text = "\(editComeStart):\(editComeEnd)"
            }
            if let leaveTime = infoList[indexPath.row].enhm21 {
                let editLeaveStart = String(leaveTime.prefix(2))
                let editLeaveEnd = String(leaveTime.suffix(2))
                cell.lblenhm21.text = "\(editLeaveStart):\(editLeaveEnd)"
            }
            if let cdat1 = infoList[indexPath.row].cdat1, cdat1 != "0", !cdat1.isEmpty{
                for item in getCdatList {
                    if item.subCd == cdat1 {
                        cell.lblcdat1.text = String(item.subNm ?? "")
                    }
                }
            }
            if let cdat2 = infoList[indexPath.row].cdat2, cdat2 != "0", !cdat2.isEmpty{
                for item in getCdatList {
                    if item.subCd == cdat2 {
                        cell.lblcdat2.text = String(item.subNm ?? "")
                    }
                }
            }
            if let cdat3 = infoList[indexPath.row].cdat3, cdat3 != "0", !cdat3.isEmpty{
                for item in getCdatList {
                    if item.subCd == cdat3 {
                        cell.lblcdat3.text = String(item.subNm ?? "")
                    }
                }
            }
            cell.backgroundColor = .white
         
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

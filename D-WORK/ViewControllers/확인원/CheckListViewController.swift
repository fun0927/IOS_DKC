//
//  CheckListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit
import JGProgressHUD
class CheckListViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
    var codeList:[CodeListDetailResponse] = []
    var planList:[WorkingPlanDetailListResponse] = []
    var checkerList:[CheckerMasterListDetailResponse] = []
    var selectedFrom = Date()
    var selectedTo = Date()
    
    let cvChecker = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvCheckerHeightAnchor:NSLayoutConstraint?
    
    let ivLeftDate: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "date")
        return imageView
    }()
    
    let lblLeftDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    let ivRightDate: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "date")
        return imageView
    }()
    
    let lblRightDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    let btnRead: UIButton = {
        let button = UIButton()
        button.setTitle("조회".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    let btnAdd: UIButton = {
        let button = UIButton()
        button.setTitle("추가".localized,for: .normal)
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
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        let dateBoundaryView = UIView()
        scrollView.addSubview(dateBoundaryView)
        dateBoundaryView.translatesAutoresizingMaskIntoConstraints = false
        dateBoundaryView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        dateBoundaryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        dateBoundaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        dateBoundaryView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        dateBoundaryView.layer.borderWidth = 1
        dateBoundaryView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        dateBoundaryView.layer.cornerRadius = 8
        
        let ivArrow = UIImageView()
        scrollView.addSubview(ivArrow)
        ivArrow.image = UIImage(named: "arrow-right")
        ivArrow.translatesAutoresizingMaskIntoConstraints = false
        ivArrow.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivArrow.centerXAnchor.constraint(equalTo: dateBoundaryView.centerXAnchor).isActive = true
        ivArrow.widthAnchor.constraint(equalToConstant: 8).isActive = true
        ivArrow.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
      

        scrollView.addSubview(ivLeftDate)
        ivLeftDate.translatesAutoresizingMaskIntoConstraints = false
        ivLeftDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivLeftDate.leadingAnchor.constraint(equalTo: dateBoundaryView.leadingAnchor, constant: 51).isActive = true
//        ivLeftDate.trailingAnchor.constraint(equalTo: lblLeftDate.leadingAnchor, constant: -8).isActive = true
        ivLeftDate.widthAnchor.constraint(equalToConstant: 14).isActive = true
        ivLeftDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        scrollView.addSubview(lblLeftDate)
        lblLeftDate.translatesAutoresizingMaskIntoConstraints = false
        lblLeftDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        lblLeftDate.leadingAnchor.constraint(equalTo: ivLeftDate.trailingAnchor, constant: 8).isActive = true
//        lblLeftDate.trailingAnchor.constraint(equalTo: ivArrow.leadingAnchor, constant: 26).isActive = true
//        lblLeftDate.widthAnchor.constraint(equalToConstant: 72).isActive = true

        let leftDateView = UIView()
        scrollView.addSubview(leftDateView)
        leftDateView.translatesAutoresizingMaskIntoConstraints = false
        leftDateView.leadingAnchor.constraint(equalTo: dateBoundaryView.leadingAnchor).isActive = true
        leftDateView.topAnchor.constraint(equalTo: dateBoundaryView.topAnchor).isActive = true
        leftDateView.trailingAnchor.constraint(equalTo: ivArrow.leadingAnchor).isActive = true
        leftDateView.bottomAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor).isActive = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftDateViewClicked))
        leftDateView.addGestureRecognizer(tap)
        
        scrollView.addSubview(ivRightDate)
        ivRightDate.translatesAutoresizingMaskIntoConstraints = false
        ivRightDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivRightDate.leadingAnchor.constraint(equalTo: ivArrow.trailingAnchor, constant: 30).isActive = true
        ivRightDate.widthAnchor.constraint(equalToConstant: 14).isActive = true
        ivRightDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        scrollView.addSubview(lblRightDate)
        lblRightDate.translatesAutoresizingMaskIntoConstraints = false
        lblRightDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        lblRightDate.leadingAnchor.constraint(equalTo: ivRightDate.trailingAnchor, constant: 8).isActive = true
        

        let rightDateView = UIView()
        scrollView.addSubview(rightDateView)
        rightDateView.translatesAutoresizingMaskIntoConstraints = false
        rightDateView.leadingAnchor.constraint(equalTo: ivArrow.trailingAnchor).isActive = true
        rightDateView.topAnchor.constraint(equalTo: dateBoundaryView.topAnchor).isActive = true
        rightDateView.trailingAnchor.constraint(equalTo: dateBoundaryView.trailingAnchor).isActive = true
        rightDateView.bottomAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor).isActive = true
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightDateViewClicked))
        rightDateView.addGestureRecognizer(tap2)
        
       
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor, constant:16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnRead)
        stackView.addArrangedSubview(btnAdd)
        
        btnRead.addTarget(self, action: #selector(btnReadClicked), for: .touchUpInside)
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        
       
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvChecker.collectionViewLayout = cvLayout
        
        cvChecker.delegate = self
        cvChecker.dataSource = self
        cvChecker.backgroundColor = .white
        scrollView.addSubview(cvChecker)
        cvChecker.translatesAutoresizingMaskIntoConstraints = false
        cvChecker.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 166).isActive = true
        cvChecker.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvChecker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        let cvHeight = 120*7+32
//        cvCalendar.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight)).isActive = true
        cvCheckerHeightAnchor = cvChecker.heightAnchor.constraint(equalToConstant: 52)
        cvCheckerHeightAnchor?.isActive = true
        cvChecker.register(CheckerListCollectionViewCell.self, forCellWithReuseIdentifier: CheckerListCollectionViewCell.ID)
        cvChecker.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        cvChecker.isScrollEnabled = false
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: startOfMonth)
        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: endOfMonth)
        lblRightDate.text = stEnd
        
        getCodeList(mainCd: "HT016_ATS")
        
        let newYyyymmddFr = stDate.replacingOccurrences(of: "-", with: "")
        print("newYyyymmddFr : \(newYyyymmddFr)")
        let newyyyymmddTo = stEnd.replacingOccurrences(of: "-", with: "")
        getMasterList(yyyymmddFr: newYyyymmddFr, yyyymmddTo: newyyyymmddTo)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: Notification.Name(rawValue: "callReload"),
            object: nil)
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self)
//    }
    @objc func reload() {
        btnReadClicked()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getCodeList(mainCd:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: mainCd)), success: { (response: ApiResponse<CodeListResponse>) in
//            print("response : \(response)")
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.codeList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.codeList.indices {
                            self.codeList[index].subNm = self.codeList[index].jpnSubNm
                        }
                    }
                    print("codeList:\(self.codeList)")
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
            
        }
        
    }
    @objc func leftDateViewClicked(){
        let timePicker = UIDatePicker()
//        timePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
//            timePicker.da
            // Fallback on earlier versions
        }
        timePicker.datePickerMode = .date
        timePicker.frame = CGRect(x: 10, y: 60, width: 280, height: 200.0)
        timePicker.timeZone = .current
        timePicker.minuteInterval = 30
        let alert  = UIAlertController(title: "알림".localized, message: nil, preferredStyle: .alert)
//        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            self.lblLeftDate.text = formatter1.string(from: self.selectedFrom)
            
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
            
            
        })
        timePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        selectedFrom = sender.date
    }
    
    @objc func rightDateViewClicked(){
        let timePicker = UIDatePicker()
//        timePicker.datePickerMode = UIDatePicker.Mode.date
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
//        alert.view.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: 500);
        timePicker.backgroundColor = alert.view.backgroundColor
        
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd"
            self.lblRightDate.text = formatter1.string(from: self.selectedTo)
            
        }))
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        alert.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        alert.view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.present(alert, animated: true, completion: {
            
            
        })
        timePicker.addTarget(self, action: #selector(toTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func toTimeDiveChanged(sender: UIDatePicker) {
        selectedTo = sender.date
    }
    
    @objc func btnReadClicked(){
        if let yyyymmddFr = lblLeftDate.text, let yyyymmddTo = lblRightDate.text {
            if !yyyymmddFr.isEmpty && !yyyymmddTo.isEmpty {
                let newYyyymmddFr = yyyymmddFr.replacingOccurrences(of: "-", with: "")
                print("newYyyymmddFr : \(newYyyymmddFr)")
                let newyyyymmddTo = yyyymmddTo.replacingOccurrences(of: "-", with: "")
                getMasterList(yyyymmddFr: newYyyymmddFr, yyyymmddTo: newyyyymmddTo)
            } else {
                let alert  = UIAlertController(title: "알림".localized, message: "날짜를 빈칸으로 할 수 없습니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }

    
    func getMasterList(yyyymmddFr:String, yyyymmddTo:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CheckerApi.masterList(param: CheckerMasterListRequest(yyyymmddFr: yyyymmddFr, yyyymmddTo: yyyymmddTo)), success: { (response: ApiResponse<CheckerMasterListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let list = result.data {
                    self.checkerList = list
                    print("checkerList.count : \(self.checkerList.count)")
                    self.cvCheckerHeightAnchor?.isActive = false
                    let cvPlanHeight = 52 + self.checkerList.count*52
                    self.cvCheckerHeightAnchor = self.cvChecker.heightAnchor.constraint(equalToConstant: CGFloat(cvPlanHeight))
                    self.cvCheckerHeightAnchor?.isActive = true
                    self.cvChecker.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
            
        }
        
    }

    @objc func btnAddClicked(){
        print("move to 확인원 등록 상세".localized)
        if let getVc = util.getViewControllerFromText(label: "확인원 등록 상세".localized) {
            if let getVc2 = getVc as? CheckerAddViewController {
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
            }
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
        }
        
    }
    
}

extension CheckListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return checkerList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CheckerListCollectionViewCell.ID, for: indexPath) as! CheckerListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblMakeDate.text = "작성일".localized
            cell.lblDutyCodeNm.text = "근태".localized
            cell.lblDate.text = "기간".localized
            cell.lblApprStateNm.text = "상태".localized
            
        default:
//            cell.lblMakeDate.text = checkerList[indexPath.row].makeDate
            // yyyymmdd -> yyyy-mm-dd
            if let makeDate = checkerList[indexPath.row].makeDate {
                let dateformattor = DateFormatter()
                dateformattor.dateFormat = "yyyyMMdd"
                dateformattor.timeZone = .current
                //  here just pass your string that you want to convert into date.
                let dt = makeDate
                let dt1 = dateformattor.date(from: makeDate)
                dateformattor.dateFormat = "yyyy-MM-dd"
                dateformattor.timeZone = NSTimeZone.local
//                print("Time :",dateformattor.string(from: dt1!))
                cell.lblMakeDate.text = dateformattor.string(from: dt1!)
            }
            if let cdat3 = checkerList[indexPath.row].dutyCode {
                for item in codeList {
                    if item.subCd == cdat3 {
                        cell.lblDutyCodeNm.text = item.subNm
                    }
                }
            }
//            cell.lblDate.text = checkerList[indexPath.row].stedDate
            if let stedDate = checkerList[indexPath.row].stedDate {
                cell.lblDate.numberOfLines = 0
                let datePev = stedDate.split(separator: "~")[0]
                if(stedDate.split(separator: "~").count > 1) {
                    let dateEnd = stedDate.split(separator: "~")[1]
                    cell.lblDate.text = "\(datePev)\n~\(dateEnd)"
                }else {
                    cell.lblDate.text = "\(datePev)"
                }
            }
            cell.lblApprStateNm.text = checkerList[indexPath.row].apprStateNm
//            if let yyyymmdd = planList[indexPath.row].yyyymmdd {
////                let index = yyyymmdd.index(yyyymmdd.endIndex, offsetBy: -2)
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier:"ko_KR")
//                dateFormatter.dateFormat = "yyyyMMdd" // 월 표시 포맷 설정
//                if let getDate = dateFormatter.date(from: yyyymmdd) {
//                    let today = Calendar.current.component(.weekday, from: Date())
//                    print("today : \(Date())")
//                    let weekday = Calendar.current.component(.weekday, from: getDate)
////                    let weekday = Calendar.current.dateComponents(in: .current, from: getDate)
////                    print("yyyymmdd : \(yyyymmdd), getDate : \(getDate), weekday : \(weekday)")
////                    print("util.getWeekDayFromNum(num: weekday) : \(util.getWeekDayFromNum(num: weekday))")
//                    cell.lblDate.text = "\(String(yyyymmdd.suffix(2)))(\(util.getWeekDayFromNum(num: weekday)))"
//                    if weekday == 1 {
//                        cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
//                    } else if weekday == 7 {
//                        cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
//                    }
//                }
//            }
//
//
//
//            cell.lblTime.text = "0"
//            if let comeTime = planList[indexPath.row].comeTime, let leaveTime = planList[indexPath.row].leaveTime {
//                let editComeStart = String(comeTime.prefix(2))
//                let editComeEnd = (comeTime.suffix(2))
//                let editLeaveStart = String(leaveTime.prefix(2))
//                let editLeaveEnd = String(leaveTime.suffix(2))
//                cell.lblWorkingHour.text = "\(editComeStart):\(editComeEnd)~\(editLeaveStart):\(editLeaveEnd)"
//            }
//
//            cell.lblCdat.text = planList[indexPath.row].cdat1
//            if let stat =  planList[indexPath.row].stat {
//                switch stat {
//                case "1":
//                    cell.lblStat.text = "마감"
//                case "2":
//                    cell.lblStat.text =  "등록"
//                default:
//                    cell.lblStat.text =  "미등록"
//                }
//            }
            
            cell.backgroundColor = .white
//            if indexPath.row % 7 == 0 { // 일요일
//                cell.lblDate.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
//            } else if indexPath.row % 7 == 6 { // 토요일
//                cell.lblDate.textColor = UIColor(red: 0.318, green: 0.384, blue: 0.98, alpha: 1)
//            }
          
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.row)")
       
        let item = checkerList[indexPath.row]
        if let getVc = util.getViewControllerFromText(label: "확인원 등록 상세".localized) {
            if let getVc2 = getVc as? CheckerAddViewController {
                getVc2.checkerData = item
                getVc2.apprState = item.apprState ?? ""
                getVc2.msgCd = item.msgCd ?? ""
                getVc2.modifiedYn = item.modifiedYn ?? ""
                getVc2.dutyCode = item.dutyCode ?? "" // 근태코드
                getVc2.seq = Int(item.seq ?? 0)
                getVc2.erpStatus = item.erpStatus ?? ""
//                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

//
//  ApprovalWaitListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit
import JGProgressHUD
class ApprovalWaitListViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let hud = JGProgressHUD()
    let util = Util()
    
    var listCateogry = ""
    
    var rows = 30
    var currentPage = 1
    var totalCount = 0
    
    var isLoading = false
    
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
    
    var selectedFrom = Date()
    var selectedTo = Date()
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
    
    var waitList:[ApproveWaitListDetailResponse] = []
    let cvWaitList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 72))
        topView.backDelegate = self
        topView.titleDelegate = self
        topView.isShowBtnBack = true
        topView.isShowNoti = true
        self.view.addSubview(topView)
        
        let dateBoundaryView = UIView()
        view.addSubview(dateBoundaryView)
        dateBoundaryView.translatesAutoresizingMaskIntoConstraints = false
        dateBoundaryView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 24).isActive = true
        dateBoundaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19).isActive = true
        dateBoundaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -104).isActive = true
        dateBoundaryView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        dateBoundaryView.layer.borderWidth = 1
        dateBoundaryView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        dateBoundaryView.layer.cornerRadius = 8
        
        let ivArrow = UIImageView()
        view.addSubview(ivArrow)
        ivArrow.image = UIImage(named: "arrow-right")
        ivArrow.translatesAutoresizingMaskIntoConstraints = false
        ivArrow.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivArrow.centerXAnchor.constraint(equalTo: dateBoundaryView.centerXAnchor).isActive = true
        ivArrow.widthAnchor.constraint(equalToConstant: 8).isActive = true
        ivArrow.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        view.addSubview(ivLeftDate)
        ivLeftDate.translatesAutoresizingMaskIntoConstraints = false
        ivLeftDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivLeftDate.leadingAnchor.constraint(equalTo: dateBoundaryView.leadingAnchor, constant: 18).isActive = true
        //        ivLeftDate.trailingAnchor.constraint(equalTo: lblLeftDate.leadingAnchor, constant: -8).isActive = true
        ivLeftDate.widthAnchor.constraint(equalToConstant: 14).isActive = true
        ivLeftDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        view.addSubview(lblLeftDate)
        lblLeftDate.translatesAutoresizingMaskIntoConstraints = false
        lblLeftDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        lblLeftDate.leadingAnchor.constraint(equalTo: ivLeftDate.trailingAnchor, constant: 8).isActive = true
        //        lblLeftDate.trailingAnchor.constraint(equalTo: ivArrow.leadingAnchor, constant: 26).isActive = true
        //        lblLeftDate.widthAnchor.constraint(equalToConstant: 72).isActive = true
        
        let leftDateView = UIView()
        view.addSubview(leftDateView)
        leftDateView.translatesAutoresizingMaskIntoConstraints = false
        leftDateView.leadingAnchor.constraint(equalTo: dateBoundaryView.leadingAnchor).isActive = true
        leftDateView.topAnchor.constraint(equalTo: dateBoundaryView.topAnchor).isActive = true
        leftDateView.trailingAnchor.constraint(equalTo: ivArrow.leadingAnchor).isActive = true
        leftDateView.bottomAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor).isActive = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftDateViewClicked))
        leftDateView.addGestureRecognizer(tap)
        
        view.addSubview(ivRightDate)
        ivRightDate.translatesAutoresizingMaskIntoConstraints = false
        ivRightDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        ivRightDate.leadingAnchor.constraint(equalTo: ivArrow.trailingAnchor, constant: 12).isActive = true
        ivRightDate.widthAnchor.constraint(equalToConstant: 14).isActive = true
        ivRightDate.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        view.addSubview(lblRightDate)
        lblRightDate.translatesAutoresizingMaskIntoConstraints = false
        lblRightDate.centerYAnchor.constraint(equalTo: dateBoundaryView.centerYAnchor).isActive = true
        lblRightDate.leadingAnchor.constraint(equalTo: ivRightDate.trailingAnchor, constant: 8).isActive = true
        
        
        let rightDateView = UIView()
        view.addSubview(rightDateView)
        rightDateView.translatesAutoresizingMaskIntoConstraints = false
        rightDateView.leadingAnchor.constraint(equalTo: ivArrow.trailingAnchor).isActive = true
        rightDateView.topAnchor.constraint(equalTo: dateBoundaryView.topAnchor).isActive = true
        rightDateView.trailingAnchor.constraint(equalTo: dateBoundaryView.trailingAnchor).isActive = true
        rightDateView.bottomAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor).isActive = true
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightDateViewClicked))
        rightDateView.addGestureRecognizer(tap2)
        
        view.addSubview(btnRead)
        btnRead.translatesAutoresizingMaskIntoConstraints = false
        btnRead.topAnchor.constraint(equalTo: dateBoundaryView.topAnchor).isActive = true
        btnRead.leadingAnchor.constraint(equalTo: dateBoundaryView.trailingAnchor, constant:7).isActive = true
        btnRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        btnRead.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnRead.addTarget(self, action: #selector(btnReadClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvWaitList.collectionViewLayout = cvLayout
        
        cvWaitList.delegate = self
        cvWaitList.dataSource = self
        cvWaitList.backgroundColor = .white
        view.addSubview(cvWaitList)
        cvWaitList.translatesAutoresizingMaskIntoConstraints = false
        cvWaitList.topAnchor.constraint(equalTo: btnRead.bottomAnchor, constant: 24).isActive = true
        cvWaitList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvWaitList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvWaitList.register(ApprovalWaitListCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalWaitListCollectionViewCell.ID)
        cvWaitList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        //        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let today = Date()
        let aMonthAgo = Calendar.current.date(byAdding: .month,value: -1, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: aMonthAgo)
        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: today)
        lblRightDate.text = stEnd
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: Notification.Name(rawValue: "callReload"),
            object: nil)
        
        if let msgCd = self.msgCd, let seqNo = self.seqNo {
            if let getVc = util.getViewControllerFromText(label: "전자 결재함 상세".localized) {
                if let getVc2 = getVc as? ApprovalWaitDetailViewController {
                    getVc2.msgCd = msgCd
                    getVc2.seqNo = Int(seqNo) ?? 0
                    getVc2.listCateogry = listCateogry
                    getVc2.modalPresentationStyle = .fullScreen
                    present(getVc2, animated: true, completion: nil)
                }
            }
        }
    }
    
    var msgCd: String?
    var seqNo: String?
    
    @objc func reload() {
        btnReadClicked()
    }
    
    @objc func leftDateViewClicked(){
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
        waitList.removeAll()
        currentPage = 1
        totalCount = 0
        if listCateogry == "완료문서함".localized {
            getCount()
        }else {
            getData()
        }
    }
    
    func getCount() {
        guard let yyyymmddFr = lblLeftDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        guard let yyyymmddTo = lblRightDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        let approvalCompleteRequest = ApprovalCompleteRequest(
            startDate: yyyymmddFr, endDate: yyyymmddTo, rows: "", page: "")
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(
            router: ApprovalApi.completeCount(param: approvalCompleteRequest),
            success: { (response: ApiResponse<ApproveCompleteCountResponse>) in
                if let result = response.value {
                    print("result : \(result)")
                    if let data = result.data {
                        self.totalCount = data.cnt ?? 0
                        self.getData()
                    }
                }
//                self.hud.dismiss()
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getData(){
        guard let yyyymmddFr = lblLeftDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        guard let yyyymmddTo = lblRightDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        
        var router:ApiRouter?
        
        let approvalWaitListRequest = ApprovalWaitListRequest(startDate: yyyymmddFr, endDate: yyyymmddTo)
        
        if listCateogry == "결재대기함".localized {
            router = ApprovalApi.undecidedList(param: approvalWaitListRequest)
        } else if listCateogry == "결재진행함".localized {
            router = ApprovalApi.progressList(param: approvalWaitListRequest)
        } else if listCateogry == "완료문서함".localized {
            router = ApprovalApi.completeList(param: ApprovalCompleteRequest(
                startDate: yyyymmddFr, endDate: yyyymmddTo, rows: "\(rows)", page: "\(currentPage)"))
        } else if listCateogry == "결재요청함".localized {
            router = ApprovalApi.undecidedFFList(param: approvalWaitListRequest)
        } else if listCateogry == "반려문서함".localized {
            router = ApprovalApi.rejectList(param: approvalWaitListRequest)
        }
        self.isLoading = true
        if let router = router {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            ApiService.request(router: router, success: { (response: ApiResponse<ApproveWaitListResponse>) in
                if let result = response.value {
                    if let list = result.data {
                        self.waitList += list
                        self.cvWaitList.reloadData()
                    }
                }
                self.isLoading = false
                self.hud.dismiss()
            }) { (error) in
                self.isLoading = false
                self.hud.dismiss()
            }
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

extension ApprovalWaitListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return waitList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == waitList.count-1 && waitList.count < totalCount && !self.isLoading {
            currentPage += 1
            self.getData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalWaitListCollectionViewCell.ID, for: indexPath) as! ApprovalWaitListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lbluserType.text = "구분".localized
            cell.lbldraftName.text = "기안자".localized
            cell.lblsubject.text = "제목".localized
            cell.lblstatusCd.text = "상태".localized
            
        default:
            if let userType = waitList[indexPath.row].userType {
                cell.lbluserType.text = util.getApprovalUserType(type: userType)
            }
            
            cell.lbldraftName.text = waitList[indexPath.row].draftName
            cell.lblsubject.text = waitList[indexPath.row].subject
            cell.lblstatusCd.text = waitList[indexPath.row].statusCd
            
            cell.backgroundColor = .white
        }
//        if indexPath.row == waitList.count-1 && waitList.count < totalCount {
//            print("loadMore")
//            currentPage += 1
//            self.getData()
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let getVc = util.getViewControllerFromText(label: "전자 결재함 상세".localized) {
            if let getVc2 = getVc as? ApprovalWaitDetailViewController {
                //                getVc2.listCateogry = label
                
                if indexPath.row < waitList.count {
                    if let msgCd = waitList[indexPath.row].msgCd, let seqNo = waitList[indexPath.row].seqNo {
                        getVc2.msgCd = msgCd
                        getVc2.seqNo = seqNo
                        getVc2.listCateogry = listCateogry
                        getVc2.modalPresentationStyle = .fullScreen
                        present(getVc2, animated: true, completion: nil)
                        //                        NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
                    }
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

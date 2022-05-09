//
//  CertificateViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import UIKit
import JGProgressHUD
class CertificateViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
    var codeList:[CodeListDetailResponse] = []
    var infoList:[CertificateInfoListData] = []
    var selectedFrom = Date()
    var selectedTo = Date()
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    
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
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        scrollView.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 166).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        let cvHeight = 120*7+32
//        cvCalendar.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight)).isActive = true
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 52)
        cvInfoListHeightAnchor?.isActive = true
        cvInfoList.register(CertificateInfoListCollectionViewCell.self, forCellWithReuseIdentifier: CertificateInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        cvInfoList.isScrollEnabled = false
        // Do any additional setup after loading the view.
        
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: startOfMonth)
        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: endOfMonth)
        lblRightDate.text = stEnd
        
        
        getCodeList(mainCd: "HH033")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let newYyyymmddFr = lblLeftDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
//        print("newYyyymmddFr : \(newYyyymmddFr)")
        guard let newyyyymmddTo = lblRightDate.text?.replacingOccurrences(of: "-", with: "") else {
            return
        }
        
        getMasterList(yyyymmddFr: newYyyymmddFr, yyyymmddTo: newyyyymmddTo)
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
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.codeList = list
                    if Environment.SYS_LANG == "ja" {
                        for index in self.codeList.indices {
                            self.codeList[index].subNm = self.codeList[index].jpnSubNm
                        }
                    }
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
        
        ApiService.request(router: CertificateApi.infoList(param: CheckerMasterListRequest(yyyymmddFr: yyyymmddFr, yyyymmddTo: yyyymmddTo)), success: { (response: ApiResponse<CertificateInfoListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let list = result.data {
                    self.infoList = list
                    print("infoList.count : \(self.infoList.count)")
                    self.cvInfoListHeightAnchor?.isActive = false
                    let cvHeight = 52 + self.infoList.count*52
                    self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
                    self.cvInfoListHeightAnchor?.isActive = true
                    self.cvInfoList.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
        }
        
    }

    @objc func btnAddClicked(){
        print("move to 확인원 등록 상세".localized)
        if let getVc = util.getViewControllerFromText(label: "증명서 발급 신청 상세".localized) {
            getVc.modalPresentationStyle = .fullScreen
            present(getVc, animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
        }
        
    }
    
}


extension CertificateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CertificateInfoListCollectionViewCell.ID, for: indexPath) as! CertificateInfoListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblreqDate.text = "신청일".localized
            cell.lblcertifiType.text = "구분".localized
            cell.lblremark.text = "용도".localized
            cell.lblerpStatus.text = "상태".localized
            
        default:
//            cell.lblreqDate.text = infoList[indexPath.row].reqDate
            if let reqDate = infoList[indexPath.row].reqDate {
                let dateformattor = DateFormatter()
                dateformattor.dateFormat = "yyyyMMdd"
                dateformattor.timeZone = .current
                //  here just pass your string that you want to convert into date.
                let dt = reqDate
                let dt1 = dateformattor.date(from: dt as String)
                dateformattor.dateFormat = "yyyy-MM-dd"
                dateformattor.timeZone = NSTimeZone.local
//                print("Time :",dateformattor.string(from: dt1!))
                cell.lblreqDate.text = dateformattor.string(from: dt1!)
            }

            
            if let certifiType = infoList[indexPath.row].certifiType {
                for item in codeList {
                    if item.subCd == certifiType {
                        
                        cell.lblcertifiType.text = String(item.subNm?.split(separator: " ")[0] ?? "")
                    }
                }
            }
            cell.lblremark.text = infoList[indexPath.row].remark
            cell.lblerpStatus.text = infoList[indexPath.row].erpStatus
            cell.backgroundColor = .white
          
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.row)")
       
        let item = infoList[indexPath.row]
        if let getVc = util.getViewControllerFromText(label: "증명서 발급 신청 상세".localized) {
            if let getVc2 = getVc as? CertificateAddViewController {
                getVc2.erpStatus = item.erpStatus ?? ""
                getVc2.certifiCd = item.certifiCd ?? ""
                getVc2.certificateInfo = item
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc, animated: true, completion: nil)
//                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
            }

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

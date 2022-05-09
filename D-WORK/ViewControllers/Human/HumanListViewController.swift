//
//  HumanListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/22.
//

import UIKit
import JGProgressHUD
class HumanListViewController: UIViewController, DropDownViewProtocol, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
   
    
    let hud = JGProgressHUD()
    let util = Util()
    
    var listCateogry = ""
    var currentPage = 1
    
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
    
    
    let lblNotApproved: UILabel = {
        let label = UILabel()
        label.text = "미승인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let ivNotApproved:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-selected")
        return imageView
    }()
    
    let lblApproved: UILabel = {
        let label = UILabel()
        label.text = "승인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let ivApproved:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    var isApproved = false
    
    var cdbrDropDown = DropDownBtn()
    var cdatList:[String] = []
    var getCdatList:[CodeListDetailResponse] = []
    
    var selectedCdbr = ""
    var selectedChek = "N"
    
    
    let btnApprove: UIButton = {
        let button = UIButton()
        button.setTitle("승인".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("취소".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    var infoList:[HumanInfoListResponseData] = []
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    var isListAllChecked = false
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
        
        view.addSubview(ivNotApproved)
        ivNotApproved.translatesAutoresizingMaskIntoConstraints = false
        ivNotApproved.topAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor, constant: 32).isActive = true
        ivNotApproved.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19).isActive = true
        ivNotApproved.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivNotApproved.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivNotApproved.isUserInteractionEnabled = true
        let ivNotApprovedTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido))
        ivNotApproved.addGestureRecognizer(ivNotApprovedTap)
        
        view.addSubview(lblNotApproved)
        lblNotApproved.translatesAutoresizingMaskIntoConstraints = false
        lblNotApproved.centerYAnchor.constraint(equalTo: ivNotApproved.centerYAnchor).isActive = true
        lblNotApproved.leadingAnchor.constraint(equalTo: ivNotApproved.trailingAnchor, constant: 8).isActive = true
        
        view.addSubview(ivApproved)
        ivApproved.translatesAutoresizingMaskIntoConstraints = false
        ivApproved.topAnchor.constraint(equalTo: dateBoundaryView.bottomAnchor, constant: 32).isActive = true
        ivApproved.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 192).isActive = true
        ivApproved.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivApproved.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivApproved.isUserInteractionEnabled = true
        let ivApprovedTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleRaido))
        ivApproved.addGestureRecognizer(ivApprovedTap)
        
        view.addSubview(lblApproved)
        lblApproved.translatesAutoresizingMaskIntoConstraints = false
        lblApproved.centerYAnchor.constraint(equalTo: ivApproved.centerYAnchor).isActive = true
        lblApproved.leadingAnchor.constraint(equalTo: ivApproved.trailingAnchor, constant: 8).isActive = true
        
        
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.spacing = 14
         view.addSubview(stackView)
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.topAnchor.constraint(equalTo: ivApproved.bottomAnchor, constant:75).isActive = true
         stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
         stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
         stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
         
         stackView.addArrangedSubview(btnApprove)
         stackView.addArrangedSubview(btnCancel)
        btnApprove.addTarget(self, action: #selector(btnApproveClicked), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        view.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 52)
        cvInfoListHeightAnchor?.isActive = true
        cvInfoList.register(HumanInfoListCollectionViewCell.self, forCellWithReuseIdentifier: HumanInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        cvInfoList.isScrollEnabled = false
       
        
//        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
//        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let stDate = dateFormatter.string(from: startOfMonth)
//        lblLeftDate.text = stDate
//        let stEnd = dateFormatter.string(from: endOfMonth)
//        lblRightDate.text = stEnd
        let today = Date()
        let aMonthAgo = Calendar.current.date(byAdding: .month,value: -1, to: today)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: aMonthAgo)
        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: today)
        lblRightDate.text = stEnd
        
        getCdatCode()
        // Do any additional setup after loading the view.
    }
    func getCdatCode(){
         hud.textLabel.text = "Loading"
         hud.show(in: self.view)
        // 구분 목록
         ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: "HH030")), success: { (response: ApiResponse<CodeListResponse>) in
 //            print("response : \(response)")
             self.cdatList.removeAll()
             self.hud.dismiss()
             if let result = response.value {
                 if let list = result.data {
                     self.getCdatList = list
                     if Environment.SYS_LANG == "ja" {
                         for index in self.getCdatList.indices {
                             self.getCdatList[index].subNm = self.getCdatList[index].jpnSubNm
                         }
                     }
                     for item in self.getCdatList {
                         self.cdatList.append(item.subNm ?? "")
                     }
                     self.updateDropDown()
                 }
                 
             }

         }) { (error) in
             self.hud.dismiss()
         }
    }
    
    func updateDropDown(){
        cdbrDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cdbrDropDown.name = "cdbrDropDown"
        cdbrDropDown.stTitle = "발령구분을 선택하세요".localized
        cdbrDropDown.delegate = self
        cdbrDropDown.dropView.dropDownOptions = self.cdatList
        view.addSubview(cdbrDropDown)
        cdbrDropDown.translatesAutoresizingMaskIntoConstraints = false
        cdbrDropDown.topAnchor.constraint(equalTo: ivApproved.bottomAnchor, constant: 16).isActive = true
        cdbrDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cdbrDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        cdbrDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "cdbrDropDown" {
            for item in getCdatList {
                if item.subNm == string {
                    selectedCdbr = item.subCd ?? ""
                    
                }
            }
        }
    }
    
    @objc func toggleRaido(){
        isApproved = !isApproved
        if isApproved { // 승인
            selectedChek = "Y"
            ivApproved.image = UIImage(named: "radio-selected")
            ivNotApproved.image = UIImage(named: "radio-unselected")
            lblApproved.textColor = .black
            lblNotApproved.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        } else { // 미승인
            selectedChek = "N"
            ivApproved.image = UIImage(named: "radio-unselected")
            ivNotApproved.image = UIImage(named: "radio-selected")
            lblApproved.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            lblNotApproved.textColor = .black
        }
        
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
        if lblLeftDate.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "시작일을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if lblRightDate.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "종료일을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
//        if selectedCdbr.isEmpty {
//            let alert  = UIAlertController(title: "알림".localized, message: "발령구분을 선택해 주세요".localized, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
        
        getData()
    }
    
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let stDate = dateFormatter.string(from: selectedFrom)
//        let stEnd = dateFormatter.string(from: selectedTo)
        let newYyyymmddFr = lblLeftDate.text!.replacingOccurrences(of: "-", with: "")
        let newyyyymmddTo = lblRightDate.text!.replacingOccurrences(of: "-", with: "")
        ApiService.request(router: HumanApi.infoList(param: HumanInfoListRequest(yyyymmddFr: newYyyymmddFr, yyyymmddTo: newyyyymmddTo, chek04: selectedChek, cdbr04: selectedCdbr)), success: { (response: ApiResponse<HumanInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList = list
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
    @objc func btnApproveClicked() {
        var list:[HumanInfoUpdateRequestList] = []
        for item in infoList {
            if let isSelected = item.isSelected, isSelected {
                list.append(HumanInfoUpdateRequestList(divCdParam: item.divCd ?? "", yybr04: item.yybr04 ?? "", nobr04: item.nobr04 ?? "", sqbr04: item.sqbr04 ?? "", prsnCdParam: item.prsnCd ?? "", cdbr04: item.cdbr04 ?? "", dtfr04: item.dtfr04 ?? ""))
            }
        }
        updateData(list:list, chek04:"Y")
     
    }
    @objc func btnCancelClicked(){
        var list:[HumanInfoUpdateRequestList] = []
        for item in infoList {
            if let isSelected = item.isSelected, isSelected {
                list.append(HumanInfoUpdateRequestList(divCdParam: item.divCd ?? "", yybr04: item.yybr04 ?? "", nobr04: item.nobr04 ?? "", sqbr04: item.sqbr04 ?? "", prsnCdParam: item.prsnCd ?? "", cdbr04: item.cdbr04 ?? "", dtfr04: item.dtfr04 ?? ""))
            }
        }
        updateData(list:list, chek04:"N")
    }
    func updateData(list:[HumanInfoUpdateRequestList], chek04:String ){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        ApiService.request(router: HumanApi.infoUpdate(param: HumanInfoUpdateRequest(chek04: chek04, list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        self.getData()
                        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HumanListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanInfoListCollectionViewCell.ID, for: indexPath) as! HumanInfoListCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblDivNm.text = "사업부문".localized
            cell.lbldtfr04.text = "발령일자".localized
            cell.lblcdbr04.text = "발령구분".localized
            cell.lblprsnNm.text = "성명".localized
            cell.cbCheck.isSelected = isListAllChecked
        default:
            cell.lblDivNm.text = infoList[indexPath.row].divNm
            cell.lbldtfr04.text = infoList[indexPath.row].dtfr04
            cell.lblcdbr04.text = infoList[indexPath.row].cdbr04
            cell.lblprsnNm.text = infoList[indexPath.row].prsnNm
            cell.cbCheck.isSelected = infoList[indexPath.row].isSelected ?? false
            
//            if let certifiType = infoList[indexPath.row].certifiType {
//                for item in codeList {
//                    if item.subCd == certifiType {
//                        cell.lblcertifiType.text = item.subNm
//                    }
//                }
//            }
//            cell.lblremark.text = infoList[indexPath.row].remark
//            cell.lblerpStatus.text = infoList[indexPath.row].erpStatus
            cell.backgroundColor = .white
          
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.row)")
        if indexPath.section == 0 {
            if infoList.count < 1 {
                return
            }
            if let isSelected = infoList[indexPath.row].isSelected {
                
                for (index, item) in infoList.enumerated() {
                    infoList[index].isSelected = !isSelected
                }
                isListAllChecked = !isSelected
            } else {
                for (index, item) in infoList.enumerated() {
                    infoList[index].isSelected = true
                }
                isListAllChecked = true
            }
            cvInfoList.reloadData()
        } else {
            if let isSelected = infoList[indexPath.row].isSelected {
                infoList[indexPath.row].isSelected = !isSelected
                
            } else {
                infoList[indexPath.row].isSelected = true
            }
            cvInfoList.reloadData()
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

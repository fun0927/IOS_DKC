//
//  RegistApprovalViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import UIKit
import JGProgressHUD
class RegistApprovalViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
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
    
    
    let lblUnApproved: UILabel = {
        let label = UILabel()
        label.text = "미승인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    let ivUnApproved = UIImageView()
    
    let lblApproved: UILabel = {
        let label = UILabel()
        label.text = "승인".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    let ivApproved = UIImageView()
    var isApproved = true
    
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
    
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var infoList:[RegistApprovalInfoListResponseData] = []
    var isListAllChecked = false
    let cvInfoCellHeight = 51
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let dateBoundaryView = UIView()
        view.addSubview(dateBoundaryView)
        dateBoundaryView.translatesAutoresizingMaskIntoConstraints = false
        dateBoundaryView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
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
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: startOfMonth)
        lblLeftDate.text = stDate
        selectedFrom = startOfMonth
        let stEnd = dateFormatter.string(from: endOfMonth)
        lblRightDate.text = stEnd
        selectedTo = endOfMonth
        
        view.addSubview(ivUnApproved)
        ivUnApproved.translatesAutoresizingMaskIntoConstraints = false
        ivUnApproved.topAnchor.constraint(equalTo: leftDateView.bottomAnchor, constant: 38).isActive = true
        ivUnApproved.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        ivUnApproved.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivUnApproved.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let ivUnApprovedTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleApprove))
        ivUnApproved.isUserInteractionEnabled = true
        ivUnApproved.addGestureRecognizer(ivUnApprovedTap)
        
        view.addSubview(lblUnApproved)
        lblUnApproved.translatesAutoresizingMaskIntoConstraints = false
        lblUnApproved.centerYAnchor.constraint(equalTo: ivUnApproved.centerYAnchor).isActive = true
        lblUnApproved.leadingAnchor.constraint(equalTo: ivUnApproved.trailingAnchor, constant: 8).isActive = true
        
        view.addSubview(ivApproved)
        ivApproved.translatesAutoresizingMaskIntoConstraints = false
        ivApproved.topAnchor.constraint(equalTo: leftDateView.bottomAnchor, constant: 38).isActive = true
        ivApproved.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 107).isActive = true
        ivApproved.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivApproved.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let ivApproveddTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleApprove))
        ivApproved.addGestureRecognizer(ivApproveddTap)
        ivApproved.isUserInteractionEnabled = true
        
        view.addSubview(lblApproved)
        lblApproved.translatesAutoresizingMaskIntoConstraints = false
        lblApproved.centerYAnchor.constraint(equalTo: ivApproved.centerYAnchor).isActive = true
        lblApproved.leadingAnchor.constraint(equalTo: ivApproved.trailingAnchor, constant: 8).isActive = true
       
        toggleApprove()
        
        view.addSubview(btnCancel)
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.centerYAnchor.constraint(equalTo: ivApproved.centerYAnchor).isActive = true
        btnCancel.trailingAnchor.constraint(equalTo: btnRead.trailingAnchor).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnCancel.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
//
        view.addSubview(btnApprove)
        btnApprove.translatesAutoresizingMaskIntoConstraints = false
        btnApprove.centerYAnchor.constraint(equalTo: ivApproved.centerYAnchor).isActive = true
        btnApprove.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -108).isActive = true
        btnApprove.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnApprove.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnApprove.addTarget(self, action: #selector(btnApproveClicked), for: .touchUpInside)
        
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
        cvInfoList.topAnchor.constraint(equalTo: btnApprove.bottomAnchor, constant: 24).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(HumanInfoListCollectionViewCell.self, forCellWithReuseIdentifier: HumanInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        // Do any additional setup after loading the view.
        getData()
    }
    @objc func toggleApprove(){
        isApproved = !isApproved
        if isApproved {
            ivApproved.image = UIImage(named: "radio-selected")
            lblApproved.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            ivUnApproved.image = UIImage(named: "radio-unselected")
            lblUnApproved.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            btnApprove.setDisable()
            btnCancel.setEnable()
        } else {
            ivApproved.image = UIImage(named: "radio-unselected")
            lblApproved.textColor =  UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
            ivUnApproved.image = UIImage(named: "radio-selected")
            lblUnApproved.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            btnApprove.setEnable()
            btnCancel.setDisable()
        }
        getData()
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
//        infoList.removeAll()
//        currentPage = 1
        getData()
    }
    func getData(){
        if lblLeftDate.text!.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "시작일을 선택해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
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
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: selectedFrom)
        let stEnd = dateFormatter.string(from: selectedTo)
        let newYyyymmddFr = stDate.replacingOccurrences(of: "-", with: "")
        let newyyyymmddTo = stEnd.replacingOccurrences(of: "-", with: "")
        
        var stat = "Y"
        if !isApproved {
            stat = "N"
        }
        ApiService.request(router: RegistApprovalApi.infoList(param: RegistApprovalInfoListRequest(yyyymmddFr: newYyyymmddFr, yyyymmddTo: newyyyymmddTo, stat: stat)), success: { (response: ApiResponse<RegistApprovalInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList = list
                    self.cvInfoList.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    @objc func btnApproveClicked() {
        var list:[RegistApprovalInfoUpdateRequestList] = []
        for item in infoList {
            if let isSelected = item.isSelected, isSelected {
                list.append(RegistApprovalInfoUpdateRequestList(prsnCdParam: item.prsnCd ?? "", reqDate: item.reqDate ?? "", uuid: item.uuid ?? "", stat: "Y"))
            }
        }
        updateData(list:list)
     
    }
    @objc func btnCancelClicked(){
        var list:[RegistApprovalInfoUpdateRequestList] = []
        for item in infoList {
            if let isSelected = item.isSelected, isSelected {
                list.append(RegistApprovalInfoUpdateRequestList(prsnCdParam: item.prsnCd ?? "", reqDate: item.reqDate ?? "", uuid: item.uuid ?? "", stat: "N"))
            }
        }
        updateData(list:list)
    }
    func updateData(list:[RegistApprovalInfoUpdateRequestList] ){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        ApiService.request(router: RegistApprovalApi.infoUpdate(param: RegistApprovalInfoUpdateRequest(list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
//                        self.dismiss(animated: true, completion: nil)
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
extension RegistApprovalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            cell.lblDivNm.text = "신청일".localized
            cell.lbldtfr04.text = "사원명".localized
            cell.lblcdbr04.text = "OS"
            cell.lblprsnNm.text = "승인".localized
            cell.cbCheck.isSelected = isListAllChecked
        default:
            
            if let reqDate = infoList[indexPath.row].reqDate {
                cell.lblDivNm.text = String(reqDate.prefix(10))
            }
            cell.lbldtfr04.text = infoList[indexPath.row].prsnNm
            cell.lblcdbr04.text = infoList[indexPath.row].os
            
            if let stat = infoList[indexPath.row].stat {
                if stat == "Y" {
                    cell.lblprsnNm.text = "승인".localized
                } else {
                    cell.lblprsnNm.text = "미승인".localized
                }
                
            }
            cell.cbCheck.isSelected = infoList[indexPath.row].isSelected ?? false
           
            cell.backgroundColor = .white
          
        }
        
        return cell
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
//            print("section 0")
//            if infoList.count > indexPath.row {
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
//            print("isListAllChecked : \(isListAllChecked)")
//            print("infoList : \(infoList)")
            cvInfoList.reloadData()
//            }
        
        } else {
//            print("section 1")
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
        return CGSize(width: collectionViewSize, height: CGFloat(cvInfoCellHeight))
        
            
        
        
    }
}

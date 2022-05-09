//
//  SurveyViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/06.
//

import UIKit
import JGProgressHUD
class SurveyViewController: UIViewController {
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
    
    let tfSubject: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "제목을 입력하세요".localized
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    var infoList:[SurveyInfoListResponseData] = []
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        
        view.addSubview(tfSubject)
        tfSubject.translatesAutoresizingMaskIntoConstraints = false
        tfSubject.topAnchor.constraint(equalTo: btnRead.bottomAnchor, constant: 8).isActive = true
        tfSubject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tfSubject.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfSubject.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 8
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        view.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: tfSubject.bottomAnchor, constant: 16).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(SurveyInfoListCollectionViewCell.self, forCellWithReuseIdentifier: SurveyInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: startOfMonth)
        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: endOfMonth)
        lblRightDate.text = stEnd
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
       
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: Notification.Name(rawValue: "callReload"),
            object: nil)
    }
    @objc func reload() {
        infoList.removeAll()
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
        infoList.removeAll()
//        currentPage = 1
        getData()
    }
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        guard let yyyymmddFr = lblLeftDate.text else {
            return
        }
        guard let yyyymmddTo = lblRightDate.text else {
            return
        }
        
        ApiService.request(router: SurveyApi.infoList(param: SurveyInfoListRequest(yyyymmddFr: yyyymmddFr, yyyymmddTo: yyyymmddTo, subject: tfSubject.text ?? "")), success: { (response: ApiResponse<SurveyInfoListResponse>) in
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SurveyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return infoList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyInfoListCollectionViewCell.ID, for: indexPath) as! SurveyInfoListCollectionViewCell
        
        cell.lblSubject.text = infoList[indexPath.row].Subject
        
        if let Sys_Date = infoList[indexPath.row].Sys_Date {
            let sys_date = Sys_Date.components(separatedBy: "T")[0]
            cell.lblSys_DateValue.text = sys_date.replacingOccurrences(of: "-", with: ".")
        }
        if let Start_Date = infoList[indexPath.row].Start_Date {
            cell.lblStart_DateValue.text = Start_Date.replacingOccurrences(of: " ", with: " / ").replacingOccurrences(of: "-", with: ".")
        }
        if let Due_Date = infoList[indexPath.row].Due_Date {
            cell.lblDue_DateValue.text = "~ \(Due_Date.replacingOccurrences(of: " ", with: " / "))".replacingOccurrences(of: "-", with: ".")
        }
        
        
        
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let Ans_Count = infoList[indexPath.row].Ans_Count {
            if Ans_Count > 0 {
                let alert  = UIAlertController(title: "알림".localized, message: "이미 참여한 설문입니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        let vc = SurveyDetailViewController()
        vc.infoData = infoList[indexPath.row]
//        vc.Que_Type = infoList[indexPath.row].Que_Type ?? ""
//        vc.dvs = dvs
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 148)
        
        
    }
}

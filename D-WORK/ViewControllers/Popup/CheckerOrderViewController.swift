//
//  CheckerOrderViewController.swift
//  D-WORK
//
//  Created by 유민형 on 2022/03/10.
//
import UIKit
import JGProgressHUD
class CheckerOrderViewController: UIViewController {
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let lblordDate: UILabel = {
        let label = UILabel()
        label.text = "수주기간".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let lblcustomNm: UILabel = {
        let label = UILabel()
        label.text = "수주명".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfcustomNm: UITextField = {
        let textField = UITextField()
        textField.placeholder = "수주명을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        
        return textField
    }()
    
    var selectedFrom = Date()
    var selectedTo = Date()
    
    
    let util = Util()
    var workNoAList:[CheckerOrderListDetailResponse] = []
    let cvWorkNoA = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
    
    
    
    let lblordNm: UILabel = {
        let label = UILabel()
        label.text = "수주처명".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfordNm: UITextField = {
        let textField = UITextField()
        textField.placeholder = "수주처명을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnCLose)
        btnCLose.translatesAutoresizingMaskIntoConstraints = false
        btnCLose.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btnCLose.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btnCLose.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        btnCLose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
        btnCLose.addTarget(self, action: #selector(btnCLoseClicked), for: .touchUpInside)
        
        view.addSubview(lblordDate)
        lblordDate.translatesAutoresizingMaskIntoConstraints = false
        lblordDate.topAnchor.constraint(equalTo: btnCLose.bottomAnchor, constant: 36).isActive = true
        lblordDate.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblordDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        
        let dateBoundaryView = UIView()
        view.addSubview(dateBoundaryView)
        dateBoundaryView.translatesAutoresizingMaskIntoConstraints = false
        dateBoundaryView.centerYAnchor.constraint(equalTo: lblordDate.centerYAnchor).isActive = true
        dateBoundaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 104).isActive = true
        dateBoundaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
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
        
        
        view.addSubview(lblcustomNm)
        lblcustomNm.translatesAutoresizingMaskIntoConstraints = false
        lblcustomNm.topAnchor.constraint(equalTo: lblordDate.bottomAnchor, constant: 35).isActive = true
        lblcustomNm.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblcustomNm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        view.addSubview(tfcustomNm)
        tfcustomNm.translatesAutoresizingMaskIntoConstraints = false
        tfcustomNm.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfcustomNm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        tfcustomNm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfcustomNm.centerYAnchor.constraint(equalTo: lblcustomNm.centerYAnchor).isActive = true
        
        view.addSubview(lblordNm)
        lblordNm.translatesAutoresizingMaskIntoConstraints = false
        lblordNm.topAnchor.constraint(equalTo: lblcustomNm.bottomAnchor, constant: 35).isActive = true
        lblordNm.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblordNm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        view.addSubview(tfordNm)
        tfordNm.translatesAutoresizingMaskIntoConstraints = false
        tfordNm.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfordNm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        tfordNm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfordNm.centerYAnchor.constraint(equalTo: lblordNm.centerYAnchor).isActive = true
        
        view.addSubview(btnRead)
        btnRead.translatesAutoresizingMaskIntoConstraints = false
        btnRead.topAnchor.constraint(equalTo: lblordNm.bottomAnchor, constant:30).isActive = true
        btnRead.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:16).isActive = true
        btnRead.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnRead.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnRead.addTarget(self, action: #selector(btnReadClicked), for: .touchUpInside)
        
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvWorkNoA.collectionViewLayout = cvLayout
        
        cvWorkNoA.delegate = self
        cvWorkNoA.dataSource = self
        cvWorkNoA.backgroundColor = .white
        view.addSubview(cvWorkNoA)
        cvWorkNoA.translatesAutoresizingMaskIntoConstraints = false
        cvWorkNoA.topAnchor.constraint(equalTo: btnRead.bottomAnchor, constant: 24).isActive = true
        cvWorkNoA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvWorkNoA.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvWorkNoA.register(WorkNoACollectionViewCell.self, forCellWithReuseIdentifier: WorkNoACollectionViewCell.ID)
        cvWorkNoA.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stDate = dateFormatter.string(from: startOfMonth)
        //        lblLeftDate.text = stDate
        let stEnd = dateFormatter.string(from: endOfMonth)
        //        lblRightDate.text = stEnd
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
    }
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
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
        var checkerOrderListRequest = CheckerOrderListRequest()
        if let yyyymmddFr = lblLeftDate.text {
            checkerOrderListRequest.ordDateFr = yyyymmddFr
        }
        if let yyyymmddTo = lblRightDate.text {
            checkerOrderListRequest.ordDateTo = yyyymmddTo
        }
        if let customNm = tfcustomNm.text {
            checkerOrderListRequest.customNm = customNm
        }
        if let ordNm = tfordNm.text {
            checkerOrderListRequest.orderNm = ordNm
        }
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        print("checkerOrderListRequest : \(checkerOrderListRequest)")
        
        ApiService.request(router: CheckerApi.orderList(param: checkerOrderListRequest), success: { (response: ApiResponse<CheckerOrderListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.workNoAList = list
                    self.cvWorkNoA.reloadData()
                }
            }
            
        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
        }
        
    }
    func getWorkNoAList(){
        
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

extension CheckerOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return workNoAList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkNoACollectionViewCell.ID, for: indexPath) as! WorkNoACollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblcsNum.text = "수주번호".localized
            cell.lblcustomNm.text = "수주처".localized
            cell.lblordNm.text = "수주명".localized
            
        default:
            cell.lblcsNum.text = workNoAList[indexPath.row].orderNum
            cell.lblcsNum.numberOfLines = 2
            cell.lblcustomNm.text = workNoAList[indexPath.row].customNm
            cell.lblcustomNm.numberOfLines = 2
            cell.lblordNm.text = workNoAList[indexPath.row].orderNm
            cell.lblordNm.numberOfLines = 2
            cell.backgroundColor = .white
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print("selected : \(indexPath.row)")
        if indexPath.section == 0 {
            return
        }
        dismiss(animated: true, completion: {
            if let previousViewController = self.previousViewController as? CheckerAddViewController {
                let item =  self.workNoAList[indexPath.row]
                print("item : \(item)")
                previousViewController.getOrderListFromPopup(checkerOrderListItem: item)
            }
            
        })
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

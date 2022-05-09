//
//  WorkNoZViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/26.
//

import UIKit
import JGProgressHUD
class WorkNoZViewController: UIViewController {
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let lblcustomNm: UILabel = {
        let label = UILabel()
        label.text = "관리항목코드".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfcustomNm: UITextField = {
        let textField = UITextField()
        textField.placeholder = "관리항목코드를 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
    
        return textField
    }()
    
    
    let util = Util()
    var workNoZList:[WorkReportworkNoZListDetailResponse] = []
    let cvWorkNoA = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
   
    
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
        label.text = "관리항목값".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfordNm: UITextField = {
        let textField = UITextField()
        textField.placeholder = "관리항목값을 입력하세요".localized
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
        btnCLose.addTarget(self, action: #selector(btnCloseClicked), for: .touchUpInside)
        
        
        
        
        view.addSubview(lblcustomNm)
        lblcustomNm.translatesAutoresizingMaskIntoConstraints = false
        lblcustomNm.topAnchor.constraint(equalTo: btnCLose.bottomAnchor, constant: 35).isActive = true
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
        cvWorkNoA.register(WorkNoZCollectionViewCell.self, forCellWithReuseIdentifier: WorkNoZCollectionViewCell.ID)
        cvWorkNoA.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        hideKeyboardWhenTappedAround()
        
        btnReadClicked()
    }
    @objc func btnCloseClicked(){
        self.dismiss(animated: true, completion: nil)
    }
  
    
    @objc func btnReadClicked(){
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkReportApi.workNoZList, success: { (response: ApiResponse<WorkReportworkNoZListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let list = result.data {
                    self.workNoZList = list
                    self.cvWorkNoA.reloadData()
                }
            }

        }) { (error) in
            self.hud.dismiss()
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

extension WorkNoZViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return workNoZList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkNoZCollectionViewCell.ID, for: indexPath) as! WorkNoZCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblCd.text = "코드".localized
            cell.lblNm.text = "값".localized
            cell.lblNm.textAlignment = .center
            
            
        default:
            cell.lblCd.text = workNoZList[indexPath.row].vlCd
            cell.lblNm.text = workNoZList[indexPath.row].vlNm
            cell.lblNm.textAlignment = .left
            
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
            if let previousViewController = self.previousViewController as? WorkReportRegisterViewController {
                let item =  self.workNoZList[indexPath.row]
                print("item : \(item)")
                previousViewController.getwWrkNoZListFromPopup(workNoZListItem: item)
            } else {
                print("previousViewController not exist")
            }
            
        })
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

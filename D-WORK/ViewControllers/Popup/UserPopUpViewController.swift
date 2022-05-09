//
//  UserPopUpViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//

import UIKit
import JGProgressHUD
class UserPopUpViewController: UIViewController {
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let lblName: UILabel = {
        let label = UILabel()
        label.text = "이름".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
    
        return textField
    }()
    
    
    let lblNum: UILabel = {
        let label = UILabel()
        label.text = "사번".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfNum: UITextField = {
        let textField = UITextField()
        textField.placeholder = "사번을 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    let btnFind: UIButton = {
        let button = UIButton()
        button.setTitle("조회".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let cvUser = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var userList:[UserListDetailResponse] = []
    
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
        
        view.addSubview(lblName)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.topAnchor.constraint(equalTo: view.topAnchor, constant: 117).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        view.addSubview(tfName)
        tfName.translatesAutoresizingMaskIntoConstraints = false
        tfName.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        tfName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfName.centerYAnchor.constraint(equalTo: lblName.centerYAnchor).isActive = true
        
        view.addSubview(lblNum)
        lblNum.translatesAutoresizingMaskIntoConstraints = false
        lblNum.topAnchor.constraint(equalTo: view.topAnchor, constant: 176).isActive = true
        lblNum.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblNum.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        view.addSubview(tfNum)
        tfNum.translatesAutoresizingMaskIntoConstraints = false
        tfNum.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfNum.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        tfNum.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfNum.centerYAnchor.constraint(equalTo: lblNum.centerYAnchor).isActive = true
        
        view.addSubview(btnFind)
        btnFind.translatesAutoresizingMaskIntoConstraints = false
        btnFind.topAnchor.constraint(equalTo: tfNum.bottomAnchor, constant: 16).isActive = true
        btnFind.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        btnFind.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnFind.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnFind.addTarget(self, action: #selector(btnFindClicked), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvUser.collectionViewLayout = cvLayout
        
        cvUser.delegate = self
        cvUser.dataSource = self
        cvUser.backgroundColor = .white
        view.addSubview(cvUser)
        cvUser.translatesAutoresizingMaskIntoConstraints = false
        cvUser.topAnchor.constraint(equalTo: btnFind.bottomAnchor, constant: 24).isActive = true
        cvUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvUser.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cvUser.register(UserPopupCollectionViewCell.self, forCellWithReuseIdentifier: UserPopupCollectionViewCell.ID)
        
        hideKeyboardWhenTappedAround()
        
    }
    
    @objc func btnFindClicked(){
        guard let stName = tfName.text, let stNum = tfNum.text else {
            return
        }
        
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.userList(param: UserListRequest(prsnCdParam: stNum, prsnNmParam: stName)), success: { (response: ApiResponse<UserListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                if let list = result.data {
                    self.userList = list
                    self.cvUser.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()

        }
    }
    
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
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


extension UserPopUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return userList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserPopupCollectionViewCell.ID, for: indexPath) as! UserPopupCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblName.text = "성명".localized
            cell.lblPrsnCd.text = "사번".localized
            cell.lbldeptNm.text = "부서".localized
            cell.lblpostNm.text = "직위".localized
            
        default:
            cell.lblName.text = userList[indexPath.row].prsnNm
            cell.lblPrsnCd.text = userList[indexPath.row].prsnCd
            cell.lbldeptNm.text = userList[indexPath.row].deptNm
            cell.lblpostNm.text = userList[indexPath.row].postNm
            
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
            if let previousViewController = self.previousViewController as? ApprovalListViewController {
                var item =  self.userList[indexPath.row]
                item.isSelected = false
                previousViewController.getApproveListFromPopup(approveListItem: item)
            }
            
            if let previousViewController = self.previousViewController as? WorkPlanReportViewController {
                var item =  self.userList[indexPath.row]
                item.isSelected = false
                previousViewController.getApproveListFromPopup(approveListItem: item)
            }
            
            
            if let previousViewController = self.previousViewController as? WorkPlanResultViewController {
                var item =  self.userList[indexPath.row]
                item.isSelected = false
                previousViewController.getApproveListFromPopup(approveListItem: item)
            }
            
            if let previousViewController = self.previousViewController as? WorkOverViewController {
                var item =  self.userList[indexPath.row]
                item.isSelected = false
                previousViewController.getApproveListFromPopup(approveListItem: item)
            }
            
            if let previousViewController = self.previousViewController as? AuthViewController {
                var item =  self.userList[indexPath.row]
                item.isSelected = false
                previousViewController.getApproveListFromPopup(approveListItem: item)
            }
        })
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

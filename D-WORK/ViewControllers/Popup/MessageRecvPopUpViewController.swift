//
//  MessageRecvPopUpViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/13.
//

import UIKit
import JGProgressHUD
class MessageRecvPopUpViewController: UIViewController {
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    
    let util = Util()
    struct RecvMenu {
        var title = ""
        var isSelected = false
    }
    var selectedMenu = 0
    var menuList:[RecvMenu] = [RecvMenu(title: "사업부문".localized, isSelected: true),
                               RecvMenu(title: "본부별".localized, isSelected: false),
                               RecvMenu(title: "부서별".localized, isSelected: false),
                               RecvMenu(title: "개인별".localized, isSelected: false)
    ]
    let cvMenu = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var selectedDivCd = "000"
    var upDeptList:[UpDeptListDetailResponse] = []
    let cvUpDept = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var userList:[UserListDetailResponse] = []
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("확인".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        return button
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
        // Do any additional setup after loading the view.
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvMenu.collectionViewLayout = cvLayout
        
        cvMenu.delegate = self
        cvMenu.dataSource = self
        cvMenu.backgroundColor = .white
        view.addSubview(cvMenu)
        cvMenu.translatesAutoresizingMaskIntoConstraints = false
        cvMenu.topAnchor.constraint(equalTo: btnCLose.bottomAnchor, constant: 22).isActive = true
        cvMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        cvMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cvMenu.register(MessageRecvPopupMenuCollectionViewCell.self, forCellWithReuseIdentifier: MessageRecvPopupMenuCollectionViewCell.ID)
        cvMenu.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        let cvUpDeptLayout = UICollectionViewFlowLayout()
        cvUpDeptLayout.minimumLineSpacing = 0
        cvUpDeptLayout.minimumInteritemSpacing = 0
        cvUpDeptLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvUpDept.collectionViewLayout = cvUpDeptLayout
        
        cvUpDept.delegate = self
        cvUpDept.dataSource = self
        cvUpDept.backgroundColor = .white
        view.addSubview(cvUpDept)
        cvUpDept.translatesAutoresizingMaskIntoConstraints = false
        cvUpDept.topAnchor.constraint(equalTo: cvMenu.bottomAnchor, constant: 24).isActive = true
        cvUpDept.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvUpDept.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvUpDept.register(MessageRecvPopupListCollectionViewCell.self, forCellWithReuseIdentifier: MessageRecvPopupListCollectionViewCell.ID)
        cvUpDept.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        view.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        
        getUpDeptList()
    }
    
    func getUpDeptList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        var router  = CommonApi.upDeptList(param: UpDeptListRequest(divCdParam: selectedDivCd))
        switch selectedMenu {
        case 0:
            // 사업부문
            router = CommonApi.divList
        case 1:
            // 본부
            router = CommonApi.upDeptList(param: UpDeptListRequest(divCdParam: selectedDivCd))
        case 2:
            //부서
            router = CommonApi.deptList(param: UpDeptListRequest(divCdParam: selectedDivCd))
        case 3:
            // 개인
            router = CommonApi.userList(param: UserListRequest(prsnCdParam: "", prsnNmParam: ""))
        default:
            router = CommonApi.upDeptList(param: UpDeptListRequest(divCdParam: selectedDivCd))
        }
        
        if selectedMenu != 3 {
            ApiService.request(router: router , success: { (response: ApiResponse<UpDeptListResponse>) in
                self.hud.dismiss()
                if let result = response.value?.data {
                    self.upDeptList = result
                    self.cvUpDept.reloadData()
                }
            }) { (error) in
                self.hud.dismiss()
                return
            }
        }else {
            ApiService.request(router: router , success: { (response: ApiResponse<UserListResponse>) in
                self.hud.dismiss()
                if let result = response.value?.data {
                    self.userList = result
                    self.cvUpDept.reloadData()
                }
            }) { (error) in
                self.hud.dismiss()
                return
            }
        }
    }
    
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnSaveClicked(){
        if let previousViewController = self.previousViewController as? MessageViewController {
            if selectedMenu != 3 {
                let selectList = upDeptList.filter({(item: UpDeptListDetailResponse) -> Bool in return item.isSelected ?? false})
                self.dismiss(animated: true, completion: {
                    previousViewController.setDeptListFromPopup(approveList: selectList, recvType: self.selectedMenu+1)
                })
            }else {
                let selectList = userList.filter({(item: UserListDetailResponse) -> Bool in return item.isSelected ?? false})
                self.dismiss(animated: true, completion: {
                    previousViewController.setPrsnListFromPopup(approveList: selectList, recvType: self.selectedMenu+1)
                })
            }
            
//            for item in upDeptList {
//                if let isSelected = item.isSelected, isSelected {
//                    self.dismiss(animated: true, completion: {
//                        previousViewController.getApproveListFromPopup(approveListItem: item, recvType: self.selectedMenu+1)
//                    })
//                    break
//                }
//            }
        }
    }
}

extension MessageRecvPopUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cvMenu {
            return 1
        } else {
            return 2
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvMenu {
            return menuList.count
        } else {
            if section == 0 {
                return 1
            } else {
                if selectedMenu != 3 {
                    return upDeptList.count
                }else {
                    return userList.count
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvMenu {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageRecvPopupMenuCollectionViewCell.ID, for: indexPath) as! MessageRecvPopupMenuCollectionViewCell
            cell.lblMenu.text = menuList[indexPath.row].title
            
            if menuList[indexPath.row].isSelected {
                cell.lblMenu.textColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
                cell.divider.isHidden = false
            } else {
                cell.lblMenu.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
                cell.divider.isHidden = true
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageRecvPopupListCollectionViewCell.ID, for: indexPath) as! MessageRecvPopupListCollectionViewCell
            switch indexPath.section {
            case 0:
                cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
                cell.lblCheck.isHidden = false
                cell.cbCheck.isHidden = true
                for view in cell.stackView.subviews {
                    view.removeFromSuperview()
                }
                
                switch  selectedMenu {
                case 0:
                    cell.lblDivNm.text = "사업부문명".localized
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                case 1:
                    cell.lblDivNm.text = "사업부문명".localized
                    cell.lblDeptNm.text = "본부명".localized
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                case 2:
                    cell.lblDivNm.text = "사업부문명".localized
                    cell.lblDeptNm.text = "부서명".localized
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                case 3:
                    cell.lblDivNm.text = "부서명".localized
                    cell.lblDeptNm.text = "사원명".localized
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                    
                default:
                    print("")
                }
                
            default:
                cell.lblCheck.isHidden = true
                cell.cbCheck.isHidden = false
                
                for view in cell.stackView.subviews {
                    view.removeFromSuperview()
                }
                switch  selectedMenu {
                case 0:
                    cell.lblDivNm.text =  upDeptList[indexPath.row].divNm
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                case 1:
                    cell.lblDivNm.text =  upDeptList[indexPath.row].divNm
                    cell.lblDeptNm.text =  upDeptList[indexPath.row].deptNm
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                case 2:
                    cell.lblDivNm.text =  upDeptList[indexPath.row].divNm
                    cell.lblDeptNm.text =  upDeptList[indexPath.row].deptNm
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                case 3:
                    cell.lblDivNm.text =  userList[indexPath.row].deptNm
                    cell.lblDeptNm.text =  userList[indexPath.row].prsnNm
                    cell.stackView.addArrangedSubview(cell.lblDivNm)
                    cell.stackView.addArrangedSubview(cell.lblDeptNm)
                default:
                    print("")
                }
                if selectedMenu != 3{
                    cell.cbCheck.isSelected = false
                    if let isSelected = upDeptList[indexPath.row].isSelected {
                        if isSelected {
                            cell.cbCheck.isSelected = true
                        }
                    }
                }else {
                    cell.cbCheck.isSelected = false
                    if let isSelected = userList[indexPath.row].isSelected {
                        if isSelected {
                            cell.cbCheck.isSelected = true
                        }
                    }
                }
                cell.backgroundColor = .white
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.row)")
        if collectionView == cvMenu {
            for (index, item) in menuList.enumerated() {
                menuList[index].isSelected = false
            }
            selectedMenu = indexPath.row
            menuList[indexPath.row].isSelected = true
            cvMenu.reloadData()
            getUpDeptList()
        } else {
            if indexPath.section == 0 {
                return
            }
            
            if selectedMenu != 3 {
                if let isSelected = upDeptList[indexPath.row].isSelected {
                    upDeptList[indexPath.row].isSelected = !isSelected
                } else {
                    upDeptList[indexPath.row].isSelected = true
                }
            }else {
                if let isSelected = userList[indexPath.row].isSelected {
                    userList[indexPath.row].isSelected = !isSelected
                } else {
                    userList[indexPath.row].isSelected = true
                }
            }
            cvUpDept.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == cvMenu {
            let collectionViewSize = collectionView.frame.size.width / 4
            return CGSize(width: collectionViewSize, height: 48)
        } else {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 51)
        }
    }
}

//
//  BudgetListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/26.
//

import UIKit
import JGProgressHUD
class BudgetListViewController: UIViewController, DropDownViewProtocol {
    
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
     let lblprocCd: UILabel = {
        let label = UILabel()
        label.text = "공정구분".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
   
    
    
    let util = Util()
    var budgetList:[BudgetListDetailResponse] = []
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
    
    
    
    let lblbgCd: UILabel = {
        let label = UILabel()
        label.text = "예산코드".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let tfbgCd: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예산코드".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
    
        return textField
    }()
    let tfbgNm: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예산코드명".localized
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
    
        return textField
    }()
    
    var upcda4DropDown = DropDownBtn()
    var upcda4List:[String] = []
    var getupcda4List:[CodeListDetailResponse] = []
    var selectedProcCd = ""
    
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
        
      
        
        view.addSubview(lblprocCd)
        lblprocCd.translatesAutoresizingMaskIntoConstraints = false
        lblprocCd.topAnchor.constraint(equalTo: btnCLose.bottomAnchor, constant: 36).isActive = true
        lblprocCd.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblprocCd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
      
        view.addSubview(lblbgCd)
        lblbgCd.translatesAutoresizingMaskIntoConstraints = false
        lblbgCd.topAnchor.constraint(equalTo: lblprocCd.bottomAnchor, constant: 35).isActive = true
        lblbgCd.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblbgCd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        view.addSubview(tfbgCd)
        tfbgCd.translatesAutoresizingMaskIntoConstraints = false
        tfbgCd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfbgCd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        tfbgCd.widthAnchor.constraint(equalToConstant: 113).isActive = true
        tfbgCd.centerYAnchor.constraint(equalTo: lblbgCd.centerYAnchor).isActive = true
       
        view.addSubview(tfbgNm)
        tfbgNm.translatesAutoresizingMaskIntoConstraints = false
        tfbgNm.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfbgNm.leadingAnchor.constraint(equalTo: tfbgCd.trailingAnchor, constant: 7).isActive = true
        tfbgNm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
        tfbgNm.centerYAnchor.constraint(equalTo: lblbgCd.centerYAnchor).isActive = true
       
        
        view.addSubview(btnRead)
        btnRead.translatesAutoresizingMaskIntoConstraints = false
        btnRead.topAnchor.constraint(equalTo: lblbgCd.bottomAnchor, constant:30).isActive = true
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
        
       
        getCodeList(mainCd: "P00001")
        hideKeyboardWhenTappedAround()
    }
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
   

    
    @objc func btnReadClicked(){
        var workReportworkBudgetListRequest:WorkReportworkBudgetListRequest?
        guard let stBgCd = tfbgCd.text else {
            return
        }
        guard let bgNm = tfbgNm.text else {
            return
        }
        workReportworkBudgetListRequest = WorkReportworkBudgetListRequest()
        workReportworkBudgetListRequest?.bgCd = stBgCd
        workReportworkBudgetListRequest?.bgNm = bgNm
        workReportworkBudgetListRequest?.procCd = selectedProcCd
        if stBgCd.isEmpty && bgNm.isEmpty && selectedProcCd.isEmpty {
            workReportworkBudgetListRequest = nil
        } 
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: WorkReportApi.budgetList(param: workReportworkBudgetListRequest), success: { (response: ApiResponse<BudgetListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let list = result.data {
                    self.budgetList = list
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

    
    func getCodeList(mainCd:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.codeList(param: CommonRequest(mainCd: mainCd)), success: { (response: ApiResponse<CodeListResponse>) in
            print("response : \(response)")
            self.hud.dismiss()
            self.upcda4List.removeAll()
            if let result = response.value {
                if let list = result.data {
                    self.getupcda4List = list // 구분 from code
                    if Environment.SYS_LANG == "ja" {
                        for index in self.getupcda4List.indices {
                            self.getupcda4List[index].subNm = self.getupcda4List[index].jpnSubNm
                        }
                    }
                    self.upcda4List.append("내용을 선택하세요".localized)
                    for item in self.getupcda4List {
                        self.upcda4List.append(item.subNm ?? "")
                    }
                    self.updateupcda4DropDown()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
          return
        }
        
    }
    func updateupcda4DropDown(){
        print("self.upcda4List : \(self.upcda4List)")
        upcda4DropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        upcda4DropDown.name = "upcda4DropDown"
        upcda4DropDown.stTitle = "내용을 선택하세요".localized
        upcda4DropDown.delegate = self
        self.upcda4DropDown.dropView.dropDownOptions = self.upcda4List
        view.addSubview(upcda4DropDown)
        upcda4DropDown.translatesAutoresizingMaskIntoConstraints = false
        upcda4DropDown.centerYAnchor.constraint(equalTo: lblprocCd.centerYAnchor).isActive = true
        upcda4DropDown.leadingAnchor.constraint(equalTo: tfbgCd.leadingAnchor).isActive = true
        upcda4DropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        upcda4DropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    func dropDownPressed(name: String, string: String) {
        selectedProcCd = ""
        for item in getupcda4List {
            if item.subNm == string {
                selectedProcCd = item.subCd ?? ""
            }
        }
    }
}

extension BudgetListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return budgetList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkNoACollectionViewCell.ID, for: indexPath) as! WorkNoACollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblcsNum.text = "사업부문".localized
            cell.lblcustomNm.text = "예산코드".localized
            cell.lblordNm.text = "예산코드명".localized
            
        default:
            cell.lblcsNum.text = budgetList[indexPath.row].divNm
            cell.lblcustomNm.text = budgetList[indexPath.row].bgCd
            cell.lblordNm.text = budgetList[indexPath.row].bgNm
            
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
                let item =  self.budgetList[indexPath.row]
                print("item : \(item)")
                previousViewController.getwBudgetCodeFromPopup(budgetItem: item)
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


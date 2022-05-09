//
//  TeamListPopup.swift
//  D-WORK
//
//  Created by 유민형 on 2022/02/25.
//

import SwiftUI
import JGProgressHUD

class TeamListPopupViewController: UIViewController, DropDownViewProtocol {
    
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let lblDiv: UILabel = {
        let label = UILabel()
        label.text = "사업부문".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    var divNmDropDown = DropDownBtn()
    var divNmList:[String] = []
    var getdivNmList:[WorkReportReqInfoListDetailResponse] = []
    
    var selectedDivCd = ""
    
    let util = Util()
    var upDeptList:[UpDeptListDetailResponse] = []
    let cvUpDept = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
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
        
        view.addSubview(lblDiv)
        lblDiv.translatesAutoresizingMaskIntoConstraints = false
        lblDiv.topAnchor.constraint(equalTo: btnCLose.bottomAnchor, constant: 36).isActive = true
        lblDiv.heightAnchor.constraint(equalToConstant: 24).isActive = true
        lblDiv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvUpDept.collectionViewLayout = cvLayout
        
        cvUpDept.delegate = self
        cvUpDept.dataSource = self
        cvUpDept.backgroundColor = .white
        view.addSubview(cvUpDept)
        cvUpDept.translatesAutoresizingMaskIntoConstraints = false
        cvUpDept.topAnchor.constraint(equalTo: lblDiv.bottomAnchor, constant: 38).isActive = true
        cvUpDept.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvUpDept.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvUpDept.register(WorkNoACollectionViewCell.self, forCellWithReuseIdentifier: WorkNoACollectionViewCell.ID)
        cvUpDept.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      
   
        getDivList()
        // Do any additional setup after loading the view.
    }
    
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDivList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkPlanReportApi.divList , success: { (response: ApiResponse<WorkReportReqInfoListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("divList result : \(result)")
                self.divNmList.removeAll()
                self.hud.dismiss()
                if let result = response.value {
                    let defaultDivCd = result.data?.defaultDivCd ?? ""
                    if let list = result.data?.list {
                        self.getdivNmList = list
                        for item in list {
                            self.divNmList.append(item.divNm ?? "")
                        }
                        self.updateDivDropDown(defaultDivCd: defaultDivCd)
                        self.getUpDeptList()
                    }
                }
            }

        }) { (error) in
            self.hud.dismiss()
//            print("error : \(error)")
          
          return
        }
        
    }
    
    func updateDivDropDown(defaultDivCd: String){
        divNmDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divNmDropDown.name = "divNmDropDown"
        divNmDropDown.stTitle = "내용을 선택하세요".localized
        
        for item in getdivNmList {
            if let subCd = item.divCd {
                if(subCd == defaultDivCd ) {
                    divNmDropDown.stTitle = item.divNm!
                    self.selectedDivCd = item.divCd!
                }
            }
        }
        
        divNmDropDown.delegate = self
        self.divNmDropDown.dropView.dropDownOptions = self.divNmList
        view.addSubview(divNmDropDown)
        divNmDropDown.translatesAutoresizingMaskIntoConstraints = false
        divNmDropDown.centerYAnchor.constraint(equalTo: lblDiv.centerYAnchor).isActive = true
        divNmDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105).isActive = true
        divNmDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        divNmDropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    

    func dropDownPressed(name: String, string: String) {
        if name ==  "divNmDropDown" {
            for item in getdivNmList {
                if item.divNm == string {
                    self.selectedDivCd = item.divCd ?? ""
                    getUpDeptList()
                    
                }
            }
        }
    }
    
    func getUpDeptList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        
        ApiService.request(router: CommonApi.deptList(param: UpDeptListRequest(divCdParam: selectedDivCd)) , success: { (response: ApiResponse<UpDeptListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("getUpDeptList result : \(result)")
//                self.divNmList.removeAll()
                self.hud.dismiss()
                if let result = response.value?.data {
                    self.upDeptList = result
                    self.cvUpDept.reloadData()
                }
                
                
                
            }

        }) { (error) in
            self.hud.dismiss()
//            print("error : \(error)")
          
          return
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

extension TeamListPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return upDeptList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkNoACollectionViewCell.ID, for: indexPath) as! WorkNoACollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblcsNum.text = "사업부문".localized
            cell.lblcustomNm.text = "부서코드".localized
            cell.lblordNm.text = "부서명".localized
            
        default:
            cell.lblcsNum.text = upDeptList[indexPath.row].divNm
            cell.lblcustomNm.text = upDeptList[indexPath.row].deptCd
            cell.lblordNm.text = upDeptList[indexPath.row].deptNm
            
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
            if let previousViewController = self.previousViewController as? WorkPlanReportViewController {
                if indexPath.row < self.upDeptList.count {
                    let item =  self.upDeptList[indexPath.row]
                    print("item : \(item)")
                    previousViewController.getDateFromDivList(upDetpItem: item)
                }
                
            } else if let previousViewController = self.previousViewController as? WorkPlanResultViewController  {
                    if indexPath.row < self.upDeptList.count {
                        let item =  self.upDeptList[indexPath.row]
                        previousViewController.getDateFromDivList(upDetpItem: item)
                    }
            } else if let previousViewController = self.previousViewController as? WorkOverViewController  {
                if indexPath.row < self.upDeptList.count {
                    let item =  self.upDeptList[indexPath.row]
                    previousViewController.getDateFromDivList(upDetpItem: item)
                }
        }
            
            
        })
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}


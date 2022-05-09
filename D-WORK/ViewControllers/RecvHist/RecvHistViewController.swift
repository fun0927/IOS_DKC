//
//  RecvHistViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import UIKit
import JGProgressHUD

class RecvHistViewController: UIViewController, DropDownViewProtocol {

    let hud = JGProgressHUD()
    let util = Util()
    var typeDropDown = DropDownBtn()
    var cdatList:[String] = []
    var getTypeList:[RecvHistTypeListResponseData] = []
    let tfSearchTxt: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력하세요".localized
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        return textField
    }()
    
    let btnSearch: UIButton = {
        let button = UIButton()
        button.setTitle("검색".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var selectedType = ""
    
    var infoList:[SendHistInfoListResponseData] = []
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        view.addSubview(tfSearchTxt)
        tfSearchTxt.translatesAutoresizingMaskIntoConstraints = false
        tfSearchTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 83).isActive = true
        tfSearchTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tfSearchTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tfSearchTxt.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        
        view.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: tfSearchTxt.bottomAnchor, constant: 16).isActive = true
        btnSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        btnSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSearch.addTarget(self, action: #selector(btnSearchClicked), for: .touchUpInside)
       
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
        cvInfoList.topAnchor.constraint(equalTo: btnSearch.bottomAnchor, constant: 32).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(SendHistInfoListCollectionViewCell.self, forCellWithReuseIdentifier: SendHistInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        hideKeyboardWhenTappedAround()
        
        getRecvHistType()
    }
    func getRecvHistType(){
         hud.textLabel.text = "Loading"
         hud.show(in: self.view)
         ApiService.request(router: RecvHistApi.typeList, success: { (response: ApiResponse<RecvHistTypeListResponse>) in
             self.cdatList.removeAll()
             self.hud.dismiss()
             if let result = response.value {
                 if let list = result.data {
                     self.getTypeList = list
                     for index in self.getTypeList.indices {
                         self.getTypeList[index].subNm = self.getTypeList[index].jpnSubNm
                     }
                     self.cdatList.append("구분을 선택하세요".localized)
                     for item in self.getTypeList {
                         self.cdatList.append(item.subNm ?? "")
                     }
                     self.updateTypeDropDown()
                     self.getData()
                 }
             }
         }) { (error) in
             self.hud.dismiss()
         }
    }
    func updateTypeDropDown(){
        typeDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        typeDropDown.name = "typeDropDown"
        typeDropDown.stTitle = cdatList[0]
        typeDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        typeDropDown.delegate = self
        typeDropDown.dropView.dropDownOptions = self.cdatList
        view.addSubview(typeDropDown)
        typeDropDown.translatesAutoresizingMaskIntoConstraints = false
        typeDropDown.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        typeDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        typeDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        typeDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "typeDropDown" {
            selectedType = ""
            typeDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            for item in getTypeList {
                if item.subNm == string {
                    selectedType = item.subCd ?? ""
                    typeDropDown.lblTitle.textColor = .black
                }
            }
        }
    }
    
    @objc func btnSearchClicked() {
        infoList.removeAll()
        currentPage = 1
        isEnd = false
        getData()
    }
    
    let rows = 20
    var currentPage = 1
    var isEnd = false
    
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: RecvHistApi.infoList(
            param: RecvHistInfoListRequest(
                type: selectedType,
                searchTxt: tfSearchTxt.text ?? "",
                rows: String(self.rows),
                page: String(currentPage))), success: { (response: ApiResponse<SendHistInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    if list.count < self.rows {
                        self.isEnd = true
                        self.infoList += list
                        self.cvInfoList.reloadData()
                    }else {
                        self.isEnd = false
                        self.infoList += list
                        self.cvInfoList.reloadData()
                    }
                }else {
                    self.isEnd = true
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
extension RecvHistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SendHistInfoListCollectionViewCell.ID, for: indexPath) as! SendHistInfoListCollectionViewCell
        
        cell.lblTtl.text = infoList[indexPath.row].ttlKr
        cell.lblsendDtm.text = infoList[indexPath.row].sendDtm
        if let sendPrsnNm = infoList[indexPath.row].sendPrsnNm {
            cell.lblsendPrsnNm.text = sendPrsnNm
        }else {
            cell.lblsendPrsnNm.text = "시스템".localized
        }
        
        if let SYS_LANG = Environment.SYS_LANG {
            if SYS_LANG == "ja" {
                if let ttlJpn = infoList[indexPath.row].ttlJpn, ttlJpn != "" {
                    cell.lblTtl.text = ttlJpn
                }
                if let sendDtm = infoList[indexPath.row].sendDtm, sendDtm != "" {
                    cell.lblsendDtm.text = sendDtm
                }
            }
        }
        
        if let readYn = infoList[indexPath.row].readYn {
            if readYn != "N" {
                let color = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
                cell.lblTtl.textColor = color
                cell.lblsendDtm.textColor = color
                cell.lblsendPrsnNm.textColor = color
            }else {
                let color = UIColor.black
                cell.lblTtl.textColor = color
                cell.lblsendDtm.textColor = color
                cell.lblsendPrsnNm.textColor = color
            }
        }
        
        if indexPath.row == infoList.count-1 && !isEnd {
            currentPage += 1
            self.getData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if infoList[indexPath.row].readYn != "Y" {
            ApiService.request(router: RecvHistApi.infoUpdate(param: RecvHistInfoUpdateRequest(sndGrp: String(infoList[indexPath.row].sendGroup ?? 0))), success: { (response: ApiResponse<RecvHistTypeListResponse>) in
                self.infoList[indexPath.row].readYn = "Y"
                self.cvInfoList.reloadData()
                
                let vc = SendHistDetailViewController()
                vc.infoData = self.infoList[indexPath.row]
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }) { (error) in
            }
        }else {
            let vc = SendHistDetailViewController()
            vc.infoData = infoList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 94)
    }
}

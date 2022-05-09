//
//  GpsConfigViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import UIKit
import JGProgressHUD
class GpsConfigViewController: UIViewController, CheckBoxProtocol {
    
    let hud = JGProgressHUD()
    let util = Util()
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var infoList:[GpsConfigInfoListResponseData] = []
    let cvInfoCellHeight = 57

    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("저장".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    let btnAdd: UIButton = {
        let button = UIButton()
        button.setTitle("추가".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.addArrangedSubview(btnAdd)
        stackView.addArrangedSubview(btnSave)
        
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnAdd.addTarget(self, action: #selector(btnAddClicked), for: .touchUpInside)
        
     
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
        cvInfoList.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(GpsConfigCollectionViewCell.self, forCellWithReuseIdentifier: GpsConfigCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16).isActive = true
      
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: GpsConfigApi.infoList, success: { (response: ApiResponse<GpsConfigInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList.removeAll()
                    for item in list {
                        var isUseYnSeleced = false
                        if let useYn = item.useYn, useYn == "Y" {
                            isUseYnSeleced = true
                        }
                       
                        var newItem = item
                        newItem.isUseYnSeleced = isUseYnSeleced
                        self.infoList.append(newItem)
                        
                    }
                    self.cvInfoList.reloadData()
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
        }
    }
    func onSelectChange(name: String, isSelected: Bool) {
        if let index = Int(name) {
            infoList[index].isUseYnSeleced = isSelected
            if isSelected {
                infoList[index].useYn = "Y"
            } else {
                infoList[index].useYn = "N"
            }
        }
    }
    
    @objc func btnAddClicked(){
        let vc = GpsConfigAddViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnSaveClicked(){
        var list:[GpsConfigUseYnUpdateRequestList] = []
        for item in infoList {

            list.append(GpsConfigUseYnUpdateRequestList(areaCd: item.areaCd ?? "", useYn: item.useYn ?? ""))
        }
        print("list : \(list)")
        updateData(list: list)
    }
    
    func updateData(list:[GpsConfigUseYnUpdateRequestList] ){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        ApiService.request(router: GpsConfigApi.useYnUpdate(param: GpsConfigUseYnUpdateRequest(list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
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

extension GpsConfigViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GpsConfigCollectionViewCell.ID, for: indexPath) as! GpsConfigCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblareaNm.text = "장소명".localized
            cell.lbllttd.text = "위도".localized
            cell.lbllngt.text = "경도".localized
            cell.lblrange.text = "반경(m)".localized
            cell.lbluseYn.text = "사용유무".localized
            cell.lbluseYn.isHidden = false
            cell.cbUesYn.isHidden = true
        default:
            cell.lblareaNm.text = ""
            cell.lbllttd.text = ""
            cell.lbllngt.text = ""
            cell.lblrange.text = ""
            cell.lbluseYn.text = ""
            
            cell.cbUesYn.isHidden = false
            cell.cbUesYn.delegate = self
            cell.cbUesYn.name = "\(indexPath.row)"
            cell.lblareaNm.text = infoList[indexPath.row].areaNm
            cell.lbllttd.text = String(format: "%.2f", (Double(infoList[indexPath.row].lttd ?? "0") ?? 0))
            cell.lbllngt.text = String(format: "%.2f", (Double(infoList[indexPath.row].lngt ?? "0") ?? 0))
            cell.lblrange.text = infoList[indexPath.row].range
            cell.cbUesYn.isSelected = infoList[indexPath.row].isUseYnSeleced ?? false
            
           
            cell.backgroundColor = .white
          
        }
        
        return cell
   
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        } else {
            let vc = GpsConfigAddViewController()
            vc.infoData = infoList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewSize = collectionView.frame.size.width
        if indexPath.section == 0 {
            return CGSize(width: collectionViewSize, height: CGFloat(51))
        } else {
            return CGSize(width: collectionViewSize, height: CGFloat(cvInfoCellHeight))
        }
        
        
        
            
        
        
    }
}

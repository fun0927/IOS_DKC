//
//  MessageConfigViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import UIKit
import JGProgressHUD
class MessageConfigViewController: UIViewController, CheckBoxProtocol {
   
    
    let hud = JGProgressHUD()
    let util = Util()
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var infoList:[MessageConfigInfoListResponseData] = []
    let cvInfoCellHeight = 69
    
    
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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
       
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
        cvInfoList.register(MessageConfigCollectionViewCell.self, forCellWithReuseIdentifier: MessageConfigCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: btnSave.topAnchor, constant: -16).isActive = true
      
        getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: MessageConfigApi.infoList, success: { (response: ApiResponse<MessageConfigInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList.removeAll()
                    for item in list {
                        var isUseYnSeleced = false
                        if let useYn = item.useYn, useYn == "Y" {
                            isUseYnSeleced = true
                        }
                        var isHlYnSeleced = false
                        if let hlYn = item.hlYn, hlYn == "Y" {
                            isHlYnSeleced = true
                        }
                        var newItem = item
                        newItem.isHlYnSeleced = isHlYnSeleced
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
    @objc func btnSaveClicked(){
        var list:[MessageConfigInfoUpdateRequestList] = []
        for item in infoList {
            
//            var isEditable = false
//            var useYn = "N"
//            if let isUseYnSeleced = item.isUseYnSeleced, isUseYnSeleced {
//                useYn = item.useYn
//                isEditable = true
//            }
//
//            var hlYn = "N"
//            if let isHlYnSeleced = item.isHlYnSeleced, isHlYnSeleced {
//                hlYn = item.hlYn
//                isEditable = true
//            }
//
//            if isEditable {
            list.append(MessageConfigInfoUpdateRequestList(pshTp: item.pshTp ?? "", sndDt: item.sndDt ?? "", sndTm: item.sndTm ?? "", hlYn: item.hlYn ?? "", useYn: item.useYn ?? ""))
//            }
        }
        print("list : \(list)")
        updateData(list: list)
    }
    
    func updateData(list:[MessageConfigInfoUpdateRequestList] ){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        ApiService.request(router: MessageConfigApi.infoUpdate(param: MessageConfigInfoUpdateRequest(list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
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
    
    func onSelectChange(name: String, isSelected: Bool) {
        print("onSelectChange name : \(name), isSelected : \(isSelected)")
        
        let prefix = String(name.prefix(5))
        
        if prefix.contains("Hl") {
            let stIndex = name.split(separator: "-")[1]
            if let index = Int(stIndex) {
                infoList[index].isHlYnSeleced = isSelected
                if isSelected {
                    infoList[index].hlYn = "Y"
                } else {
                    infoList[index].hlYn = "N"
                }
            }
            
        } else {
            let stIndex = name.split(separator: "-")[1]
            if let index = Int(stIndex) {
                infoList[index].isUseYnSeleced = isSelected
                if isSelected {
                    infoList[index].useYn = "Y"
                } else {
                    infoList[index].useYn = "N"
                }
            }
            
        }
        
//        cvInfoList.reloadData()
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


extension MessageConfigViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageConfigCollectionViewCell.ID, for: indexPath) as! MessageConfigCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblpshDiv.text = "푸시유형".localized
            cell.lblpshDiv.textAlignment = .center
            cell.pshDivYAnchor?.isActive = false
            cell.pshDivYAnchor = cell.lblpshDiv.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            cell.pshDivYAnchor?.isActive = true
            cell.lblpshTitle.text = ""
            cell.lblsndDt.text = "전송기준일자".localized
            cell.lblsndTm.text = "전송시각".localized
            cell.lblhlYn.text = "휴일전송".localized
            cell.lblhlYn.isHidden = false
            cell.lbluseYn.text = "사용유무".localized
            cell.lbluseYn.isHidden = false
            cell.cbHlYn.isHidden = true
            cell.cbUesYn.isHidden = true
            break
        default:
//            cell.lblhlYn.isHidden = true
//            cell.lbluseYn.isHidden = true
            cell.pshDivYAnchor?.isActive = false
            cell.pshDivYAnchor = cell.lblpshDiv.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: -13)
            cell.pshDivYAnchor?.isActive = true
            cell.lblpshDiv.textAlignment = .left
            
            cell.lblhlYn.text = ""
            cell.lbluseYn.text = ""
            cell.lblpshDiv.text = ""
            cell.lblpshTitle.text = ""
            cell.lblsndDt.text = ""
            cell.lblsndTm.text = ""
            
            cell.cbHlYn.isHidden = false
            cell.cbHlYn.delegate = self
            cell.cbHlYn.name = "cbHlYn-\(indexPath.row)"
            cell.cbUesYn.isHidden = false
            cell.cbUesYn.delegate = self
            cell.cbUesYn.name = "cbUesYn-\(indexPath.row)"
            cell.lblpshDiv.text = infoList[indexPath.row].pshDiv
            cell.lblpshTitle.text = infoList[indexPath.row].pshTitle
            cell.lblsndDt.text = infoList[indexPath.row].sndDt
            cell.lblsndTm.text = infoList[indexPath.row].sndTm
            cell.cbHlYn.isSelected = infoList[indexPath.row].isHlYnSeleced ?? false
            cell.cbUesYn.isSelected = infoList[indexPath.row].isUseYnSeleced ?? false
            
            cell.backgroundColor = .white
          
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        } else {
//            print("section 1")
            
//            if let isHlYnSeleced = infoList[indexPath.row].isHlYnSeleced {
//                infoList[indexPath.row].isHlYnSeleced = !isHlYnSeleced
//
//            } else {
//                infoList[indexPath.row].isHlYnSeleced = true
//            }
//            if let isHlYnSeleced = infoList[indexPath.row].isHlYnSeleced {
//                infoList[indexPath.row].isHlYnSeleced = !isHlYnSeleced
//
//            } else {
//                infoList[indexPath.row].isHlYnSeleced = true
//            }
//            cvInfoList.reloadData()
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

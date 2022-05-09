//
//  ApprovalCountReadViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import UIKit
import JGProgressHUD
class ApprovalCountReadViewController: UIViewController {
    let hud = JGProgressHUD()
    let util = Util()
    let cvApproval = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    struct ApproveStruct {
        var title:String
        var count:Int
    }
    var approvalList:[ApproveStruct] = [
        ApproveStruct(title: "결재대기함".localized, count: 0),
        ApproveStruct(title: "결재진행함".localized, count: 0),
        ApproveStruct(title: "완료문서함".localized, count: 0),
        ApproveStruct(title: "반려문서함".localized, count: 0)
    ]
    var approvalList2:[ApproveStruct] = [
        ApproveStruct(title: "결재요청함".localized, count: 0),
    ]
    var approvalList3:[ApproveStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        view.addSubview(cvApproval)
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvApproval.collectionViewLayout = cvLayout
        cvApproval.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        cvApproval.delegate = self
        cvApproval.dataSource = self
        cvApproval.translatesAutoresizingMaskIntoConstraints = false
        cvApproval.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cvApproval.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cvApproval.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cvApproval.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cvApproval.register(ApprovalCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalCollectionViewCell.ID)
        cvApproval.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        cvApproval.layer.borderWidth = 1
        cvApproval.layer.cornerRadius = 8
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCountList()
//        getHumanInfoCnt()
    }
    
    func getCountList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.countRead, success: { (response: ApiResponse<ApproveCountReadResponse>) in
//            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
//                print("result : \(result)")
                if let undecidedCnt = result.data?.undecidedCnt{
                    for (index, item) in self.approvalList.enumerated() {
                        if item.title == "결재대기함".localized{
                            self.approvalList[index].count = undecidedCnt
                        }
                    }
                }
                if let progressCnt = result.data?.progressCnt{
                    for (index, item) in self.approvalList.enumerated() {
                        if item.title == "결재진행함".localized{
                            self.approvalList[index].count = progressCnt
                        }
                    }
                }
                if let undecidedFfCnt = result.data?.undecidedFfCnt{
                    for (index, item) in self.approvalList2.enumerated() {
                        if item.title == "결재요청함".localized{
                            self.approvalList2[index].count = undecidedFfCnt
//                            self.approvalList2[index].count = 3
                        }
                    }
                }
                
                self.cvApproval.reloadData()
                self.getHumanInfoCnt()
            }

        }) { (error) in
            self.hud.dismiss()
            
        }
        
    }

    
    func getHumanInfoCnt(){
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
        
        ApiService.request(router: HumanApi.infoCnt, success: { (response: ApiResponse<HumanInfoCntdResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                print("result : \(result)")
                if let auth = result.data?.auth, auth == "N" {
                    self.approvalList3.removeAll()
                }else {
                    if let undecidedCnt = result.data?.undecidedCnt{
                        print("undecidedCnt : \(undecidedCnt)")
                        self.approvalList3 = [
                            ApproveStruct(title: "결재요청함".localized, count: Int(undecidedCnt)),
                        ]
//                        for (index, item) in self.approvalList3?.enumerated() {
//                            if item.title == "결재요청함".localized{
//                                self.approvalList3[index].count = Int(undecidedCnt)
//                            }
//                        }
                    }
                }
                self.cvApproval.reloadData()
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
extension ApprovalCountReadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return approvalList.count
        case 2:
            return 1
        case 3:
            return approvalList2.count
        case 4:
            return 1
        case 5:
            return approvalList3.count
        default:
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalCollectionViewCell.ID, for: indexPath) as! ApprovalCollectionViewCell
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 4 {
            
        }
        switch indexPath.section {
        case 0:
            cell.lblTitle.text = "결재".localized
            cell.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            cell.lblTitle.isHidden = false
            cell.lblContent.isHidden = true
            cell.lblCount.isHidden = true
            
        case 1:
            cell.backgroundColor = .white
            cell.lblTitle.isHidden = true
            cell.lblContent.isHidden = false
            cell.lblCount.isHidden = false
            cell.lblContent.text = approvalList[indexPath.row].title
            if approvalList[indexPath.row].count < 1{
                cell.lblCount.isHidden = true
            } else {
                cell.lblCount.isHidden = false
                cell.lblCount.text = String(approvalList[indexPath.row].count)
            }
        case 2:
            cell.lblTitle.text = "기안".localized
            cell.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            cell.lblTitle.isHidden = false
            cell.lblContent.isHidden = true
            cell.lblCount.isHidden = true
        case 3:
            cell.backgroundColor = .white
            cell.lblTitle.isHidden = true
            cell.lblContent.isHidden = false
            cell.lblCount.isHidden = false
            cell.lblContent.text = approvalList2[indexPath.row].title
//            cell.lblCount.text = String(approvalList2[indexPath.row].count)
            if approvalList2[indexPath.row].count < 1{
                cell.lblCount.isHidden = true
            } else {
                cell.lblCount.isHidden = false
                cell.lblCount.text = String(approvalList2[indexPath.row].count)
            }
        case 4:
            if approvalList3.count != 0 {
                cell.lblTitle.text = "인사".localized
                cell.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
                cell.lblTitle.isHidden = false
                cell.lblContent.isHidden = true
                cell.lblCount.isHidden = true
            }else {
                cell.lblTitle.isHidden = true
                cell.lblContent.isHidden = true
                cell.lblCount.isHidden = true
                cell.divider.isHidden = true
            }
        case 5:
            if approvalList3.count != 0 {
                cell.backgroundColor = .white
                cell.lblTitle.isHidden = true
                cell.lblContent.isHidden = false
                cell.lblCount.isHidden = false
                cell.lblContent.text = approvalList3[indexPath.row].title
    //            cell.lblCount.text = String(approvalList3[indexPath.row].count)
                if approvalList3[indexPath.row].count < 1{
                    cell.lblCount.isHidden = true
                } else {
                    cell.lblCount.isHidden = false
                    cell.lblCount.text = String(approvalList3[indexPath.row].count)
                }
            }
        default:
            
            cell.lblContent.isHidden = true
            cell.lblCount.isHidden = true
            cell.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
            
          
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("selected : \(indexPath.row)")
        var label = ""
        switch indexPath.section {
        case 1:
            label = approvalList[indexPath.row].title
        case 3:
            label = approvalList2[indexPath.row].title
        case 5:
            //인사는 안함
            label = "결재대기함 인사".localized
            print("label : \(label)")
        default:
            print("")
        }
//        print("label : \(label)")
        if let getVc = util.getViewControllerFromText(label: label) {
//            print("ApprovalCountReadViewController didSelectRowAt getVc : \(getVc)")
            if let getVc2 = getVc as? ApprovalWaitListViewController {
                getVc2.listCateogry = label
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
//                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
            }
            if let getVc2 = getVc as? HumanListViewController {
//                getVc2.listCateogry = label
                getVc2.modalPresentationStyle = .fullScreen
                present(getVc2, animated: true, completion: nil)
//                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
            }
            
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 4 {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 78)
        } else {
            let collectionViewSize = collectionView.frame.size.width
    //        print("collectionViewSize : \(collectionViewSize)")
            return CGSize(width: collectionViewSize, height: 53)
        }
            
        
        
    }
}

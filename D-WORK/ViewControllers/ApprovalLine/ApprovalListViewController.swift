//
//  ApprovalListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/24.
//[ㄱ-힣]
//

import UIKit
import JGProgressHUD


class ApprovalListViewController: UIViewController, TopViewBackProtocol {
    func btnBackClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let hud = JGProgressHUD()
    var previousViewController:UIViewController?
    let tfApprove: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textField.placeholder = "결재자를 입력하세요".localized
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
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
    
    
    let lblApproveTitle: UILabel = {
        let label = UILabel()
        label.text = "승인자 정보".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let btnDelete: UIButton = {
        let button = UIButton()
        button.setTitle("삭제".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let lblApproveLineTitle: UILabel = {
        let label = UILabel()
        label.text = "결재라인 선택".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    var userList:[UserListDetailResponse] = []
    
    let cvApprove = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var approveList:[UserListDetailResponse] = [] // 실제 화면에 보여지는 리스트
    
    let cvApproveLine = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvApproveLineHeightAnchor:NSLayoutConstraint?
    var stackViewBottonAnchor:NSLayoutConstraint?
    var approveLineList:[ApprovalListDetailResponse] = []
    
    let btnCancel: UIButton = {
        let button = UIButton()
        button.setTitle("닫기".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("적용".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 72))
        topView.backDelegate = self
        topView.isShowBtnBack = true
        topView.isShowNoti = true
        self.view.addSubview(topView)
        
//        if let vc = previousViewController as? CertificateAddViewController{
//            var statusBarHeight:CGFloat = 0
//            if #available(iOS 13.0, *) {
//                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//                statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//            } else {
//                statusBarHeight = UIApplication.shared.statusBarFrame.height
//            }
//            let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
//            topView.backDelegate = self
//            topView.isShowBtnBack = true
//            self.view.addSubview(topView)
//            scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 53).isActive = true
//        } else if let vc = previousViewController as? WorkReportRegisterViewController{
//            var statusBarHeight:CGFloat = 0
//            if #available(iOS 13.0, *) {
//                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//                statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//            } else {
//                statusBarHeight = UIApplication.shared.statusBarFrame.height
//            }
//            let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
//            topView.backDelegate = self
//            topView.isShowBtnBack = true
//            self.view.addSubview(topView)
//            scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 53).isActive = true
//        } else if let vc = previousViewController as? CheckerAddViewController{
//
//        } else {
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        }
        
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(btnFind)
        btnFind.translatesAutoresizingMaskIntoConstraints = false
        btnFind.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        btnFind.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnFind.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnFind.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnFind.addTarget(self, action: #selector(btnFindClicked), for: .touchUpInside)
        
        scrollView.addSubview(tfApprove)
        tfApprove.translatesAutoresizingMaskIntoConstraints = false
        tfApprove.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        tfApprove.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfApprove.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfApprove.trailingAnchor.constraint(equalTo: btnFind.leadingAnchor, constant: -7).isActive = true
        
        
        scrollView.addSubview(lblApproveTitle)
        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
        lblApproveTitle.topAnchor.constraint(equalTo: tfApprove.bottomAnchor, constant: 24).isActive = true
        lblApproveTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
   
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        cvApprove.collectionViewLayout = cvLayout
        
        cvApprove.delegate = self
        cvApprove.dataSource = self
        cvApprove.backgroundColor = .white
        scrollView.addSubview(cvApprove)
        cvApprove.translatesAutoresizingMaskIntoConstraints = false
        cvApprove.topAnchor.constraint(equalTo: lblApproveTitle.bottomAnchor, constant: 16).isActive = true
        cvApprove.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvApprove.widthAnchor.constraint(equalToConstant: 159).isActive = true
        cvApprove.heightAnchor.constraint(equalToConstant: CGFloat(191)).isActive = true
        cvApprove.layer.borderWidth = 1
        cvApprove.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        cvApprove.layer.cornerRadius = 8
        
        cvApprove.register(ApprovalUserCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalUserCollectionViewCell.ID)
        cvApprove.isScrollEnabled = false
        
        scrollView.addSubview(btnDelete)
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        btnDelete.topAnchor.constraint(equalTo: cvApprove.topAnchor).isActive = true
        btnDelete.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDelete.leadingAnchor.constraint(equalTo: cvApprove.trailingAnchor,constant: 17).isActive = true
        btnDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        
        
        scrollView.addSubview(lblApproveLineTitle)
        lblApproveLineTitle.translatesAutoresizingMaskIntoConstraints = false
        lblApproveLineTitle.topAnchor.constraint(equalTo: cvApprove.bottomAnchor, constant: 32).isActive = true
        lblApproveLineTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        let cvLayout2 = UICollectionViewFlowLayout()
        cvLayout2.minimumLineSpacing = 8
        cvLayout2.minimumInteritemSpacing = 0
        cvLayout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvApproveLine.collectionViewLayout = cvLayout2
        
        cvApproveLine.delegate = self
        cvApproveLine.dataSource = self
        cvApproveLine.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.addSubview(cvApproveLine)
        cvApproveLine.translatesAutoresizingMaskIntoConstraints = false
        cvApproveLine.topAnchor.constraint(equalTo: lblApproveLineTitle.bottomAnchor, constant: 16).isActive = true
        cvApproveLine.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
//        cvApproveLine.widthAnchor.constraint(equalToConstant: 159).isActive = true
        cvApproveLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvApproveLineHeightAnchor = cvApproveLine.heightAnchor.constraint(equalToConstant: 0)
        cvApproveLineHeightAnchor?.isActive = true
        cvApproveLine.register(ApprovalLineCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalLineCollectionViewCell.ID)
        cvApproveLine.isScrollEnabled = false
        
        
        
        
        stackView.axis = .horizontal
//        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cvApproveLine.bottomAnchor, constant:16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackViewBottonAnchor = stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)
        stackViewBottonAnchor?.isActive = true
        
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnCancel)
       
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        
        getApprovalLine()
        
        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    func getApproveListFromPopup(approveListItem:UserListDetailResponse){
        
        self.approveList.append(approveListItem)
        cvApprove.reloadData()
        print("getApproveListFromPopup approveList : \(approveList)")
    }
    
    
    @objc func btnSaveClicked(){
        if let previousViewController = previousViewController as? CheckerAddViewController {
            previousViewController.approveList = approveList
            dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
        }
        if let previousViewController = previousViewController as? WorkReportRegisterViewController {
            previousViewController.approveList = approveList
            dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
        }
        if let previousViewController = previousViewController as? CertificateAddViewController {
            previousViewController.approveList = approveList
//            previousViewController.getApproveList(approveList: approveList)
            dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
        }
        if let previousViewController = previousViewController as? CardAddViewController {
            previousViewController.approveList = approveList
            dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
        }
    }
    @objc func btnCancelClicked(){
        dismiss(animated: true, completion: nil)
//        if let previousViewController = previousViewController as? CheckerAddViewController {
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
//        }
//        if let previousViewController = previousViewController as? WorkReportRegisterViewController {
//            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: previousViewController)
//        }
//        if let previousViewController = previousViewController as? CertificateAddViewController {
//           dismiss(animated: true, completion: nil)
//       }
    }
    
    @objc func btnDeleteClicked() {
        approveList = approveList.filter( { (value: UserListDetailResponse) -> Bool in return !(value.isSelected ?? false) } )
        print("approveList : \(approveList)")
        cvApprove.reloadData()
    }
    
    
    @objc func btnFindClicked(){
        guard let stApprove = tfApprove.text else {
            return
        }
//        if stApprove.isEmpty {
//            return
//        }
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.userList(param: UserListRequest(prsnCdParam: "", prsnNmParam: stApprove)), success: { (response: ApiResponse<UserListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                if let list = result.data {
                    self.userList = list
                    if self.userList.count == 1 {
                        var item = self.userList[0]
                        item.isSelected = false
                        self.approveList.append(item)
                        self.cvApprove.reloadData()
                        
                    } else {
                        DispatchQueue.main.async {
                            let vc = UserPopUpViewController()
                            vc.previousViewController = self
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
            
          return
        }
    }
    

    func getApprovalLine(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: CommonApi.approvalList, success: { (response: ApiResponse<ApprovalListResponse>) in
            self.hud.dismiss()
//            print("response : \(response)")
          
            if let result = response.value {
                print("CommonApi result : \(result)")
                if let list = result.data {
                    self.approveLineList = list
                    self.cvApproveLineHeightAnchor?.isActive = false
                    let height = self.approveLineList.count * 86 +  (self.approveLineList.count-1) * 8
                    self.cvApproveLineHeightAnchor = self.cvApproveLine.heightAnchor.constraint(equalToConstant: CGFloat(height))
                    self.cvApproveLineHeightAnchor?.isActive = true
                    self.cvApproveLine.reloadData()
//                    self.stackViewBottonAnchor = self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -100)
//                    self.stackViewBottonAnchor?.isActive = true
                }
                
            }

        }) { (error) in
            self.hud.dismiss()
            print("error : \(error)")
          
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



extension ApprovalListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == cvApprove {
            return approveList.count
        } else {
            return approveLineList.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvApprove {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalUserCollectionViewCell.ID, for: indexPath) as! ApprovalUserCollectionViewCell
            cell.lblTitle.text = approveList[indexPath.row].prsnNm ?? ""
            if let selected = approveList[indexPath.row].isSelected {
                if selected {
                    cell.backgroundColor = .lightGray
                } else {
                    cell.backgroundColor = .white
                }
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalLineCollectionViewCell.ID, for: indexPath) as! ApprovalLineCollectionViewCell
            cell.lblLine.text = approveLineList[indexPath.row].subject
            if let approvalName = approveLineList[indexPath.row].approvalName{
                cell.lblName.text = "결재".localized + " : \(approvalName)"
            }
            
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected : \(indexPath.row)")
        
        if collectionView == cvApprove {
//            print("approveList[indexPath.row].isSelected : \(approveList[indexPath.row].isSelected)")
            if let isSelected = approveList[indexPath.row].isSelected {
                approveList[indexPath.row].isSelected = !isSelected
            } 
             
            cvApprove.reloadData()
        } else {
            if let approvalName = approveLineList[indexPath.row].approvalName, let approvalLine = approveLineList[indexPath.row].approvalLine{
                let lineArray = approvalLine.components(separatedBy : ",")
                let nameArray = approvalName.components(separatedBy : ",")
                for (index, item) in lineArray.enumerated() {
                    approveList.append(UserListDetailResponse(prsnCd: lineArray[index], prsnNm: nameArray[index], isSelected: false))
                }
                cvApprove.reloadData()
            }
            

        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvApprove {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 40)
        } else {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: 86)
        }
            
        
        
    }
}

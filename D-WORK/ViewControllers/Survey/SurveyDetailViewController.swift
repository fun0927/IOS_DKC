//
//  SurveyDetailViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/12.
//

import UIKit
import JGProgressHUD

class SurveyDetailViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let hud = JGProgressHUD()
    let util = Util()
    
    var infoData:SurveyInfoListResponseData?
    var queList:[QueData] = []
    var exmList:[exmData] = []
    var answerExmList:[exmData] = []
    var Que_Type = "R"
    //    var infoList:[SurveyInfoListResponseData] = []
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var answerHeight = 41
    var answerTHeight = 82
    var answerMHeight = 50
    
    
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
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        var statusBarHeight:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 72))
        topView.backDelegate = self
        topView.titleDelegate = self
        topView.isShowBtnBack = true
        topView.isShowNoti = true
        self.view.addSubview(topView)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //        scrollView.backgroundColor = .blue
        
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 8
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
        cvInfoList.isScrollEnabled = false
        scrollView.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        cvInfoList.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 0)
        cvInfoListHeightAnchor?.isActive = true
        cvInfoList.register(SurveyDetailCollectionViewCell.self, forCellWithReuseIdentifier: SurveyDetailCollectionViewCell.ID)
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cvInfoList.bottomAnchor, constant:16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnCancel)
        
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnCancel.addTarget(self, action: #selector(btnCancelClicked), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
        getData()
        hideKeyboardWhenTappedAround()
    }
    
    func calCellHeight(index:Int, que:QueData)->Int {
        var cellHeight = 24+23+40
        for exm in self.exmList {
            //                    if que.Que_Num == exm.Que_Num {
            if let queQue_Num = que.Que_Num,
               let exmQue_Num = exm.Que_Num,
               let exmExmType = exm.Exm_Type,
               Int(queQue_Num) == index+1,
               queQue_Num == exmQue_Num {
                if exmExmType == "T" {
                    cellHeight += self.answerTHeight
                } else if exmExmType == "M" {
                    cellHeight += self.answerMHeight
                } else{
                    cellHeight += 41
                }
                
            }
        }
        return cellHeight
    }
    
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: SurveyApi.infoDetail(param: SurveyInfoDetailRequest(Msg_CD: infoData?.Msg_CD ?? "")), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let que = result.data?.que, let exm = result.data?.exm {
                    self.queList = que
                    self.exmList = exm
                    self.cvInfoList.reloadData()
                    
                    self.cvInfoListHeightAnchor?.isActive = false
                    var totalHeight = 0
                    for (index, que) in self.queList.enumerated() {
                        //                        if index == 0 {
                        //                            self.Que_Type = que.Que_Type ?? ""
                        //                        }
                        //                        var cellHeight = 24+23+40
                        //                        for exm in self.exmList {
                        //        //                    if que.Que_Num == exm.Que_Num {
                        //                            if let queQue_Num = que.Que_Num,
                        //                               let exmQue_Num = exm.Que_Num,
                        //                               let exmExmType = exm.Exm_Type,
                        //                               Int(queQue_Num) == index+1,
                        //                               queQue_Num == exmQue_Num {
                        //                                if exmExmType == "T" {
                        //                                    cellHeight += self.answerTHeight
                        //                                } else{
                        //                                    cellHeight += 41
                        //                                }
                        //
                        //                            }
                        //                        }
                        totalHeight += self.calCellHeight(index: index, que: que)+8
                    }
                    print("totalHeight : \(totalHeight)")
                    self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
                    self.cvInfoListHeightAnchor?.isActive = true
                }
                //
            }
            
        }) { (error) in
            self.hud.dismiss()
        }
    }
    func getAnswers(answer:exmData) {
        //        answerExmList += answer
        print("Que_Type : \(Que_Type)")
        print("Que_Type : \(infoData?.Que_Type)")
        switch Que_Type {
        case "R":
            if answerExmList.count > 0 {
                var isExist = false
                for (index, item) in answerExmList.enumerated() {
                    if item.Que_Num == answer.Que_Num {
                        answerExmList[index] = answer
                        isExist = true
                        break
                    }
                }
                if !isExist {
                    answerExmList.append(answer)
                }
            } else {
                answerExmList.append(answer)
            }
        case "C":
            if answerExmList.count > 0 {
                var isExist = false
                for (index, item) in answerExmList.enumerated() {
                    if item.Que_Num == answer.Que_Num {
                        answerExmList[index] = answer
                        isExist = true
                        break
                    }
                }
                if !isExist {
                    answerExmList.append(answer)
                }
            } else {
                answerExmList.append(answer)
            }
        case "T":
            if answerExmList.count > 0 {
                var isExist = false
                for (index, item) in answerExmList.enumerated() {
                    if item.Que_Num == answer.Que_Num {
                        answerExmList[index] = answer
                        isExist = true
                        break
                    }
                }
                if !isExist {
                    answerExmList.append(answer)
                }
            } else {
                answerExmList.append(answer)
            }
        default:
            if answerExmList.count > 0 {
                var isExist = false
                for (index, item) in answerExmList.enumerated() {
                    if item.Que_Num == answer.Que_Num {
                        answerExmList[index] = answer
                        isExist = true
                        break
                    }
                }
                if !isExist {
                    answerExmList.append(answer)
                }
            } else {
                answerExmList.append(answer)
            }
        }
        
        
        print("answerExmList : \(answerExmList)")
    }
    
    @objc func btnSaveClicked(){
        
        
        var surveyList:[SurveyInfoUpdateRequestList] = []
        for item in answerExmList {
            var Ans_Value = item.Exm_Title ?? ""
            if let exmType = item.Exm_Type {
                if exmType == "R" || exmType == "C", exmType == "RM" {
                    Ans_Value = "\(item.Exm_Num ?? 0)"
                }
            }
            
            let surveyListItem = SurveyInfoUpdateRequestList(Msg_CD: "\(item.Msg_CD ?? "")", Que_Num: "\(item.Que_Num ?? 0)", Que_Type: item.Exm_Type ?? "", Ans_Value: Ans_Value, Ans_Text: item.Exm_Title ?? "")
            if let Exm_Type = item.Exm_Type {
                switch Exm_Type {
                case "R":
                    surveyList.append(surveyListItem)
                case "C":
                    surveyList.append(surveyListItem)
                    
                default:
                    surveyList.append(surveyListItem)
                }
                
            }
            
        }
        print("surveyList : \(surveyList)")
        print("answerExmList : \(answerExmList)")
        print("queList : \(queList)")
        
        if surveyList.count != queList.count {
            var title = "미선택 항목을 선택해 주세요".localized
            if Que_Type == "T" || Que_Type == "F" {
                title = "미입력 항목을 입력해 주세요".localized
            }
            let alert  = UIAlertController(title: "알림".localized, message: title, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        
        ApiService.request(router: SurveyApi.infoUpdate(param: SurveyInfoUpdateRequest(list: surveyList)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
                        NotificationCenter.default.post(name: Notification.Name("callReload"), object: nil)
                        self.dismiss(animated: true, completion: nil)
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
    
    @objc func btnCancelClicked(){
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

extension SurveyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return queList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SurveyDetailCollectionViewCell.ID, for: indexPath) as! SurveyDetailCollectionViewCell
        cell.parentViewController = self
        let num:String = String(queList[indexPath.row].Que_Num ?? 0)
        let title = queList[indexPath.row].Que_Title ?? ""
        cell.lblQue_Title.text = num + ". " + title
        var newExmList: [exmData] = []
        for que in queList {
            for exm in exmList {
                if let queQue_Num = que.Que_Num,
                   let exmQue_Num = exm.Que_Num,
                   Int(queQue_Num) == indexPath.row+1,
                   queQue_Num == exmQue_Num {
                    newExmList.append(exm)
                }
            }
        }
        print("newExmList : \(newExmList)")
        cell.exmList = newExmList
        
        cell.cvExm.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        
        var height = 24+23+40
        for (index, que) in queList.enumerated() {
            height = calCellHeight(index: index, que: que)
        }
        print("height : \(height)")
        return CGSize(width: collectionViewSize, height: CGFloat(height))
        
        
    }
}

//
//  NoticeListViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import UIKit
import JGProgressHUD
class NoticeListViewController: UIViewController, DropDownViewProtocol {
    let hud = JGProgressHUD()
    let util = Util()
    var infoList:[NoticeInfoListResponseData] = []
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    
//    let lblTitle: UILabel = {
//        let label = UILabel()
//        label.text = "사내공지사항"
//        label.font =  UIFont(name: "NotoSansKR-Medium", size: 20)
//        return label
//    }()
    
    var dvsDropDown = DropDownBtn()
    var dvsList = ["사내공지사항".localized, "안전공지사항".localized, "노동조합공지사항".localized]
    
    var searchDvsDropDown = DropDownBtn()
    let searchDvsList = ["구분을 선택하세요".localized, "제목".localized, "내용".localized, "작성자".localized]
    var selectedSearchDvs = ""
    
    let tfText: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.placeholder = "검색어를 입력하세요".localized
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
//        view.addSubview(lblTitle)
//        lblTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
//        lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        lblTitle.isUserInteractionEnabled = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTitleTapped))
//        lblTitle.addGestureRecognizer(tapGestureRecognizer)
        
        updateDropDown()
        
        view.addSubview(tfText)
        tfText.translatesAutoresizingMaskIntoConstraints = false
        tfText.topAnchor.constraint(equalTo: searchDvsDropDown.bottomAnchor, constant: 8).isActive = true
        tfText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tfText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        tfText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Do any additional setup after loading the view.
        
        view.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: tfText.bottomAnchor, constant: 16).isActive = true
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
        cvInfoList.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.topAnchor.constraint(equalTo: btnSearch.bottomAnchor, constant: 24).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.register(NoticeInfoListCollectionViewCell.self, forCellWithReuseIdentifier: NoticeInfoListCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        let defaults: UserDefaults = UserDefaults.standard
        if let listIndex = defaults.string(forKey: "listIndex") {
            defaults.removeObject(forKey: "listIndex")
            defaults.synchronize()
            let listIndexAfterRemove = defaults.string(forKey: "listIndex")
        }
        
        hideKeyboardWhenTappedAround()
        
//        selectedSearchDvs = dvs
        
        getInfo()
        getCount()
        
        if let dataNo = self.dataNo {
            let vc = NoticeDetailViewController()
            vc.infoData = NoticeInfoListResponseData(dataNo: Double(dataNo))
            vc.dvs = dvs
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if directDataNo != nil {
            let vc = NoticeDetailViewController()
            vc.infoData = NoticeInfoListResponseData(dataNo: directDataNo, title: nil, prsnNm: nil, readCnt: nil, regDate: nil, fileYn: nil)
            vc.dvs = dvs
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            directDataNo = nil
        }
    }
    
    func updateDropDown(){
        dvsDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dvsDropDown.name = "dvsDropDown"
        dvsDropDown.stTitle = dvsList[(Int(dvs) ?? 1) - 1]
        dvsDropDown.lblTitle.textColor = .black
        dvsDropDown.delegate = self
        dvsDropDown.dropView.dropDownOptions = self.dvsList
        
        view.addSubview(dvsDropDown)
        dvsDropDown.translatesAutoresizingMaskIntoConstraints = false
        dvsDropDown.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        dvsDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dvsDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        dvsDropDown.heightAnchor.constraint(equalToConstant: 29).isActive = true
        dvsDropDown.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 0)
        dvsDropDown.layer.borderWidth = 0
        dvsDropDown.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 0).cgColor
        dvsDropDown.layer.cornerRadius = 0
        dvsDropDown.btnDown.isHidden = true
        dvsDropDown.lblTitle.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        
        searchDvsDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        searchDvsDropDown.name = "searchDvsDropDown"
        searchDvsDropDown.stTitle = searchDvsList[0]
        searchDvsDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        searchDvsDropDown.delegate = self
        searchDvsDropDown.dropView.dropDownOptions = self.searchDvsList
        
        view.addSubview(searchDvsDropDown)
        searchDvsDropDown.translatesAutoresizingMaskIntoConstraints = false
        searchDvsDropDown.topAnchor.constraint(equalTo: dvsDropDown.bottomAnchor, constant: 21).isActive = true
        searchDvsDropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchDvsDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        searchDvsDropDown.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name == "dvsDropDown" {
            switch string {
            case "사내공지사항".localized:
                dvs = "1"
            case "안전공지사항".localized:
                dvs = "2"
            case "노동조합공지사항".localized:
                dvs = "3"
            default:
                dvs = "1"
            }
            selectedSearchDvs = ""
            searchDvsDropDown.stTitle = searchDvsList[0]
            searchDvsDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            tfText.text = ""
            infoList.removeAll()
            cvInfoList.reloadData()
            currentPage = 1
            getCount()
        }else if name == "searchDvsDropDown" {
            switch string {
            case "제목".localized:
                selectedSearchDvs = "1"
                searchDvsDropDown.lblTitle.textColor = .black
            case "내용".localized:
                selectedSearchDvs = "2"
                searchDvsDropDown.lblTitle.textColor = .black
            case "작성자".localized:
                selectedSearchDvs = "3"
                searchDvsDropDown.lblTitle.textColor = .black
            default:
                selectedSearchDvs = ""
                searchDvsDropDown.lblTitle.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
            }
        }
    }
    
    func getInfo(){
        ApiService.request(router: NoticeApi.infoRead,
                           success: { (response: ApiResponse<NoticeInfoReadResponse>) in
            if let result = response.value {
                if let data = result.data {
                    if data.isDvs3 != "Y" {
                        self.dvsList.remove(at: 2)
                    }
                }
            }
        }) { (error) in
        }
    }
    
    @objc func btnSearchClicked(){
        infoList.removeAll()
        cvInfoList.reloadData()
        currentPage = 1
        getCount()
    }
    
    let rows = 20
    var currentPage = 1
    var dvs = "1"
    var totalCount = 0
    var directDataNo:Double?
    var dataNo: String?
    
    func getCount(){
        ApiService.request(router: NoticeApi.infoCount(
            param: NoticeInfoCountRequest(
                dvs: dvs,
                searchDvs: selectedSearchDvs,
                searchTxt: tfText.text ?? "")), success: { (response: ApiResponse<NoticeInfoCountResponse>) in
            if let result = response.value {
                if let data = result.data {
                    self.totalCount = data.cnt ?? 0
                    self.getList()
                }
            }
        }) { (error) in
        }
    }
    
    func getList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: NoticeApi.infoList(
            param: NoticeInfoListRequest(
                dvs: dvs,
                searchDvs: selectedSearchDvs,
                searchTxt: tfText.text ?? "" ,
                rows: String(self.rows),
                page: String(currentPage))), success: { (response: ApiResponse<NoticeInfoListResponse>) in
            if let result = response.value {
                if let list = result.data {
                    self.infoList += list
                    self.cvInfoList.reloadData()
                }
            }
            self.hud.dismiss()
        }) { (error) in
            self.hud.dismiss()
        }
    }
}

extension NoticeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeInfoListCollectionViewCell.ID, for: indexPath) as! NoticeInfoListCollectionViewCell
        
        cell.lblTitle.text = infoList[indexPath.row].title
        cell.lblprsnNm.text = infoList[indexPath.row].prsnNm
        cell.lblreadCnt.text = String(Int(infoList[indexPath.row].readCnt ?? 0))
        cell.lblregDate.text = infoList[indexPath.row].regDate
        
        if indexPath.row == infoList.count-1 && infoList.count < totalCount {
            currentPage += 1
            self.getList()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NoticeDetailViewController()
        vc.infoData = infoList[indexPath.row]
        vc.dvs = dvs
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 126)
    }
}

//
//  GpsConfigAddViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import UIKit
import JGProgressHUD
import Alamofire
import GoogleMaps
class GpsConfigAddViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, UITextFieldDelegate, GMSMapViewDelegate {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let scrollView = UIScrollView()
    let hud = JGProgressHUD()
    let util = Util()
    
    
    let tfSearch: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "키워드를 입력하세요".localized
        return textField
    }()
    
    let btnSearch: UIButton = {
        let button = UIButton()
        button.setTitle("조회".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var model:KakaoAddress?
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cvInfoListCellHeight = 119
    var infoList:[KAKAO_DOCUMENT] = []
    var cvInfoListHeightAnchor:NSLayoutConstraint?
    
    
    let tfAreaName: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.placeholder = "장소를 입력하세요".localized
        return textField
    }()
    
    let tfRange: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(16)
        textField.keyboardType = .numberPad
        textField.placeholder = "반경을 입력하세요".localized
        return textField
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
    var mapView = GMSMapView()
    var currentLat:Double = 0.0
    var currentLng:Double = 0
    var infoData:GpsConfigInfoListResponseData?
    
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
        
        
        scrollView.addSubview(btnSearch)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        btnSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSearch.widthAnchor.constraint(equalToConstant: 84).isActive = true
        btnSearch.addTarget(self, action: #selector(btnSearchClicked), for: .touchUpInside)
        
        scrollView.addSubview(tfSearch)
        tfSearch.translatesAutoresizingMaskIntoConstraints = false
        tfSearch.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        tfSearch.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfSearch.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfSearch.trailingAnchor.constraint(equalTo: btnSearch.leadingAnchor, constant: -7).isActive = true
        
        // Do any additional setup after loading the view.
        
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
        cvInfoList.topAnchor.constraint(equalTo: tfSearch.bottomAnchor, constant: 16).isActive = true
        cvInfoList.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        cvInfoList.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100).isActive = true
        cvInfoListHeightAnchor = cvInfoList.heightAnchor.constraint(equalToConstant: 0)
        cvInfoListHeightAnchor?.isActive = true
        cvInfoList.register(GpsConfigAddCollectionViewCell.self, forCellWithReuseIdentifier: GpsConfigAddCollectionViewCell.ID)
        
        scrollView.addSubview(tfAreaName)
        tfAreaName.translatesAutoresizingMaskIntoConstraints = false
        tfAreaName.topAnchor.constraint(equalTo: cvInfoList.bottomAnchor, constant: 32).isActive = true
        tfAreaName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfAreaName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        tfAreaName.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfAreaName.text = infoData?.areaNm
        scrollView.addSubview(tfRange)
        tfRange.translatesAutoresizingMaskIntoConstraints = false
        tfRange.topAnchor.constraint(equalTo: tfAreaName.bottomAnchor, constant: 8).isActive = true
        tfRange.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        tfRange.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        tfRange.heightAnchor.constraint(equalToConstant: 51).isActive = true
        tfRange.delegate = self
        tfRange.text = infoData?.range
        
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: tfRange.bottomAnchor, constant: 12).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        stackView.addArrangedSubview(btnSave)
        stackView.addArrangedSubview(btnDelete)
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(btnDeleteClicked), for: .touchUpInside)
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width, height: 380), camera: camera)
        scrollView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16).isActive = true
        mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        mapView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mapView.delegate = self
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 37.37, longitude: 126.64)
//        marker.map = mapView
        
        if let lngt = infoData?.lngt, let lttd = infoData?.lttd {
            currentLng = Double(lngt) ?? 0
            currentLat = Double(lttd) ?? 0
            let radius = Int(tfRange.text ?? "") ?? 0
            addMarker(radius: radius)
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    @objc func btnSearchClicked(){
        if let searchText = tfSearch.text {
            
            if let escapedString = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                self.hud.textLabel.text = "Loading"
                self.hud.show(in: self.view)
                
                let url = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(escapedString)"
                let headers: HTTPHeaders = [
                    "Authorization": "KakaoAK b3471c702585424396ac4459dc814b43"
                ]
                AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers)
                    .responseData { response in
                        self.hud.dismiss()
                        switch response.result {
                            
                        case .success(let value):
                            let decoder: JSONDecoder = JSONDecoder()
                            do {
                                self.model = try decoder.decode(KakaoAddress.self, from: value)
                                
                                print("model : \(self.model)")
                                DispatchQueue.main.async {
                                    if let docuements = self.model?.documents {
                                        self.infoList = docuements
                                        let totalHeight = self.infoList.count * self.cvInfoListCellHeight +  (self.infoList.count-1) * 8
                                        self.cvInfoListHeightAnchor?.isActive = false
                                        self.cvInfoListHeightAnchor = self.cvInfoList.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
                                        self.cvInfoListHeightAnchor?.isActive = true
                                        self.cvInfoList.reloadData()
                                    }
                                }
                            } catch {
                                print(error)
                            }
                            
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                    .responseJSON { response in
                        //                    print("search result : \(response)")
                        
                        switch response.result {
                        case .success(let value):
                            print("search result ")
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
            }
        }
    }
    @objc func btnDeleteClicked(){
        let alert  = UIAlertController(title: "알림".localized, message: "출퇴근 정보 관리에서 삭제할까요?".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
            self.hud.textLabel.text = "Loading"
            self.hud.show(in: self.view)
            var list:[GpsConfigUseYnUpdateRequestList] = []
            list.append(GpsConfigUseYnUpdateRequestList(areaCd: self.infoData?.areaCd ?? "", useYn: "N"))
            
            ApiService.request(router: GpsConfigApi.useYnUpdate(param: GpsConfigUseYnUpdateRequest(list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
                self.hud.dismiss()
                if let result = response.value {
                    if result.status ?? false {
                        let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
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
        }))
        alert.addAction(UIAlertAction(title: "취소".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    let marker = GMSMarker()
    let circle = GMSCircle()
    func addMarker(radius: Int) {
        let center = CLLocationCoordinate2D(latitude: self.currentLat, longitude: self.currentLng)
        
        circle.position = center
        circle.radius = CLLocationDistance(radius)
        circle.fillColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.3)
        circle.strokeWidth = 0
        
        marker.position = center
        
        if circle.map == nil {
            circle.map = mapView
        }
        if marker.map == nil {
            marker.map = mapView
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: self.currentLat, longitude: self.currentLng, zoom: 14.0)
        mapView.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let radius = Int(tfRange.text ?? "") ?? 0
        self.currentLng = coordinate.longitude
        self.currentLat = coordinate.latitude
        addMarker(radius: radius)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfRange {
            let radius = Int(tfRange.text ?? "") ?? 0
            DispatchQueue.main.async {
                self.addMarker(radius: radius)
            }
        }
        
    }
    
    @objc func btnSaveClicked(){
        var list:[GpsConfigInfoUpdateRequestList] = []
        if let infoData = infoData {
            list = [GpsConfigInfoUpdateRequestList(areaCd: infoData.areaCd ?? "", areaNm: tfAreaName.text ?? "", lttd: "\(currentLat)", lngt: "\(currentLng)", range: tfRange.text ?? "")]
        } else {
            for item in infoList {
                if let isSelected = item.isSelected, isSelected {
                    list.append(GpsConfigInfoUpdateRequestList(areaCd: "", areaNm: tfAreaName.text ?? "", lttd: "\(currentLat)", lngt: "\(currentLng)", range: tfRange.text ?? ""))
                }
                
            }
        }
        
        //        print("list : \(list)")
        updateData(list: list)
    }
    func updateData(list:[GpsConfigInfoUpdateRequestList] ){
        
        
        guard let stAreaName = tfAreaName.text else {
            return
        }
        guard let stRange = tfRange.text else {
            return
        }
        
        if stAreaName.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "장소명을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if stRange.isEmpty {
            let alert  = UIAlertController(title: "알림".localized, message: "반경을 입력해 주세요".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: GpsConfigApi.infoUpdate(param: GpsConfigInfoUpdateRequest(list: list)), success: { (response: ApiResponse<SurveyInfoDetailResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if result.status ?? false {
                    let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: {_ in
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension GpsConfigAddViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return infoList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GpsConfigAddCollectionViewCell.ID, for: indexPath) as! GpsConfigAddCollectionViewCell
        cell.lblPlaceName.text = infoList[indexPath.row].place_name
        cell.lblRoadAddressName.text = infoList[indexPath.row].road_address_name
        cell.lblAddressName.text = infoList[indexPath.row].address_name
        
        if let isSelected = infoList[indexPath.row].isSelected, isSelected {
            cell.layer.borderColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
        } else {
            cell.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, item) in infoList.enumerated() {
            infoList[index].isSelected = false
        }
        
        if let isSelected = infoList[indexPath.row].isSelected {
            infoList[indexPath.row].isSelected = !isSelected
            
        } else {
            infoList[indexPath.row].isSelected = true
        }
        if let stLat = infoList[indexPath.row].y, let stLng = infoList[indexPath.row].x {
            let dbLat = Double(stLat) ?? 0
            let dbLng = Double(stLng) ?? 0
            
            let radius = Int(tfRange.text ?? "") ?? 0
            self.currentLat = dbLat
            self.currentLng = dbLng
            addMarker(radius: radius)
        }
        
        cvInfoList.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        
        return CGSize(width: collectionViewSize, height: CGFloat(cvInfoListCellHeight))
        
        
    }
}

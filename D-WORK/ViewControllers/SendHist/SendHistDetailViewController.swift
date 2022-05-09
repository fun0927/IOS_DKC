//
//  SendHistDetailViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import UIKit
import JGProgressHUD
class SendHistDetailViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol {
    let hud = JGProgressHUD()
    let util = Util()
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }

    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
    var infoData:SendHistInfoListResponseData?
    var infoList:[SendHistRecvListResponseData] = []
    let ivUser:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        return imageView
    }()
    let lblsendPrsnNm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblsendDtm: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    let lblRecv: UILabel = {
        let label = UILabel()
        label.text = "수신자".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    let cvInfoList = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

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
        
        let viewTitle = UIView()
        view.addSubview(viewTitle)
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewTitle.heightAnchor.constraint(equalToConstant: 72).isActive = true
        viewTitle.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        viewTitle.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.topAnchor.constraint(equalTo: viewTitle.topAnchor, constant: 25).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: viewTitle.leadingAnchor, constant: 19).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: viewTitle.trailingAnchor, constant: -19).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        let viewHeader = UIView()
        view.addSubview(viewHeader)
        viewHeader.translatesAutoresizingMaskIntoConstraints = false
        viewHeader.topAnchor.constraint(equalTo: viewTitle.bottomAnchor).isActive = true
        viewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewHeader.heightAnchor.constraint(equalToConstant: 55).isActive = true
        viewHeader.backgroundColor = .white
        viewHeader.layer.borderWidth = 1
        viewHeader.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        
        viewHeader.addSubview(ivUser)
        ivUser.widthAnchor.constraint(equalToConstant: 16).isActive = true
        ivUser.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ivUser.translatesAutoresizingMaskIntoConstraints = false
        ivUser.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 18).isActive = true
        ivUser.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor).isActive = true
        
        viewHeader.addSubview(lblsendPrsnNm)
        lblsendPrsnNm.translatesAutoresizingMaskIntoConstraints = false
        lblsendPrsnNm.leadingAnchor.constraint(equalTo: ivUser.trailingAnchor, constant: 10).isActive = true
        lblsendPrsnNm.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor).isActive = true
        
        viewHeader.addSubview(lblsendDtm)
        lblsendDtm.translatesAutoresizingMaskIntoConstraints = false
        lblsendDtm.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -16).isActive = true
        lblsendDtm.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor).isActive = true
        
        let textView = UITextView()
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        textView.topAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textView.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        textView.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        textView.isScrollEnabled = false
        textView.sizeToFit()
        
        view.addSubview(lblRecv)
        lblRecv.translatesAutoresizingMaskIntoConstraints = false
        lblRecv.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 32).isActive = true
        lblRecv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        lblRecv.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: lblRecv.bottomAnchor, constant: 0).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvInfoList.collectionViewLayout = cvLayout
        
        cvInfoList.delegate = self
        cvInfoList.dataSource = self
        cvInfoList.backgroundColor = .white
//        cvInfoList.isScrollEnabled = false
        view.addSubview(cvInfoList)
        cvInfoList.translatesAutoresizingMaskIntoConstraints = false
        cvInfoList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cvInfoList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvInfoList.topAnchor.constraint(equalTo: lblRecv.bottomAnchor, constant: 24).isActive = true
        cvInfoList.register(SendHistDetailRecvCollectionViewCell.self, forCellWithReuseIdentifier: SendHistDetailRecvCollectionViewCell.ID)
        cvInfoList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
       
//        let divider = UIView()
//        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
//        scrollView.addSubview(divider)
//        divider.translatesAutoresizingMaskIntoConstraints = false
//        divider.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        divider.topAnchor.constraint(equalTo: cvInfoList.topAnchor).isActive = true
        
        if let sendPrsnNm = infoData?.sendPrsnNm {
            self.lblsendPrsnNm.text = sendPrsnNm
        }else {
            self.lblsendPrsnNm.text = "시스템".localized
        }
        self.lblsendDtm.text = infoData?.sendDtm
        
        lblTitle.text = infoData?.ttlKr
        textView.text = infoData?.bdKr
        if let SYS_LANG = Environment.SYS_LANG {
            if SYS_LANG == "ja" {
                textView.text = infoData?.bdJpn
                lblTitle.text = infoData?.ttlJpn
            }
        }
        
        if let ttlKr = infoData?.ttlKr, let ttlJpn = infoData?.ttlJpn {
            if !ttlKr.isEmpty && ttlJpn.isEmpty {
                textView.text = infoData?.bdKr
                lblTitle.text = infoData?.ttlKr
            }
            if ttlKr.isEmpty && !ttlJpn.isEmpty {
                textView.text = infoData?.bdJpn
                lblTitle.text = infoData?.ttlJpn
            }
        }
        getData()
    }
    
    
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: SendHistApi.recvList(
            param: SendHistRecvListRequest(
                sendGroup: String(self.infoData?.sendGroup ?? 0)
            )), success: { (response: ApiResponse<SendHistRecvListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    self.infoList = list
                    if list.count < 1 {
                        self.lblRecv.isHidden = true
                    } else {
                        self.lblRecv.isHidden = false
                    }
                    self.cvInfoList.reloadData()
                } else {
                    self.lblRecv.isHidden = true
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
}

extension SendHistDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SendHistDetailRecvCollectionViewCell.ID, for: indexPath) as! SendHistDetailRecvCollectionViewCell
        cell.lblprsnNm.text = infoList[indexPath.row].prsnNm
        cell.lbldeptNm.text = infoList[indexPath.row].deptNm
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: CGFloat(39))
    }
}

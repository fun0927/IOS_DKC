//
//  ApprovalWaitDetailViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import UIKit
import JGProgressHUD
import WebKit
import Alamofire

class ApprovalWaitDetailViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, WKNavigationDelegate {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let hud = JGProgressHUD()
    let util = Util()
    var msgCd = ""
    var seqNo = 0
    var lineList:[ApprovalLineListDetailResponse] = []
    let cvLine = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var listCateogry = ""
    
    var webViewHeight: NSLayoutConstraint?
    
    let lblApproveTitle: UILabel = {
        let label = UILabel()
        label.text = "승인 현황".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let lblConfirmTitle: UILabel = {
        let label = UILabel()
        label.text = "결재 정보".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let scrollView = UIScrollView()
    let webView = WKWebView()
    
    let lblFileTitle: UILabel = {
        let label = UILabel()
        label.text = "첨부 파일".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        return label
    }()
    
    let cvFile = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvFileHeightAnchor:NSLayoutConstraint?
    var fileList:[ApprovalFileListDetailResponse] = []
    
    let btnApprove: UIButton = {
        let button = UIButton()
        button.setTitle("결재".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnDeny: UIButton = {
        let button = UIButton()
        button.setTitle("반려".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    let btnApproveAll: UIButton = {
        let button = UIButton()
        button.setTitle("전결".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    var cvLineHeightAnchor:NSLayoutConstraint?
    let cvLineHeight = 55
    
    var stackViewTopAnchor:NSLayoutConstraint?
    let stackView = UIStackView()
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
        scrollView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(lblApproveTitle)
        lblApproveTitle.translatesAutoresizingMaskIntoConstraints = false
        lblApproveTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        lblApproveTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 8
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvLine.collectionViewLayout = cvLayout
        
        cvLine.delegate = self
        cvLine.dataSource = self
        //        cvLine.backgroundColor = .white
        cvLine.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        scrollView.addSubview(cvLine)
        cvLine.translatesAutoresizingMaskIntoConstraints = false
        cvLine.topAnchor.constraint(equalTo: lblApproveTitle.bottomAnchor, constant: 16).isActive = true
        cvLine.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        let totalHeight = cvLineHeight*3 + 8*2
        cvLineHeightAnchor = cvLine.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
        cvLineHeightAnchor?.isActive = true
        
        cvLine.register(ApprovalWaitDetailApprovalLineCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalWaitDetailApprovalLineCollectionViewCell.ID)
        cvLine.isScrollEnabled = false
        
        scrollView.addSubview(lblConfirmTitle)
        lblConfirmTitle.translatesAutoresizingMaskIntoConstraints = false
        lblConfirmTitle.topAnchor.constraint(equalTo: cvLine.bottomAnchor, constant: 32).isActive = true
        lblConfirmTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: lblConfirmTitle.bottomAnchor, constant: 16).isActive = true
        webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        webViewHeight = webView.heightAnchor.constraint(equalToConstant: 210)
        webViewHeight?.isActive = true
        webView.navigationDelegate = self
        
        scrollView.addSubview(lblFileTitle)
        lblFileTitle.translatesAutoresizingMaskIntoConstraints = false
        lblFileTitle.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 32).isActive = true
        lblFileTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        let cvFileLayout = UICollectionViewFlowLayout()
        cvFileLayout.minimumLineSpacing = 8
        cvFileLayout.minimumInteritemSpacing = 0
        cvFileLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvFile.collectionViewLayout = cvFileLayout
        
        cvFile.delegate = self
        cvFile.dataSource = self
        cvFile.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        scrollView.addSubview(cvFile)
        cvFile.translatesAutoresizingMaskIntoConstraints = false
        cvFile.topAnchor.constraint(equalTo: lblFileTitle.bottomAnchor, constant: 16).isActive = true
        cvFile.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvFile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        let cvFileHeight = 0
        cvFileHeightAnchor = cvFile.heightAnchor.constraint(equalToConstant: CGFloat(cvFileHeight))
        cvFileHeightAnchor?.isActive = true
        cvFile.register(ApprovalWaitDetailFileListCollectionViewCell.self, forCellWithReuseIdentifier: ApprovalWaitDetailFileListCollectionViewCell.ID)
        cvFile.isScrollEnabled = false
        cvFile.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -150).isActive = true
        
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewTopAnchor = stackView.topAnchor.constraint(equalTo: cvFile.bottomAnchor, constant:16)
        stackViewTopAnchor?.isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        stackView.addArrangedSubview(btnApprove)
        stackView.addArrangedSubview(btnDeny)
        stackView.addArrangedSubview(btnApproveAll)
        stackView.isHidden = true
        
        btnApprove.addTarget(self, action: #selector(btnApproveClicked), for: .touchUpInside)
        btnDeny.addTarget(self, action: #selector(btnDenyClicked), for: .touchUpInside)
        btnApproveAll.addTarget(self, action: #selector(btnApproveAllClicked), for: .touchUpInside)
        
        getData()
        getHtmlCode()
        getFileList()
        
        // Do any additional setup after loading the view.
    }
    func getData(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.approvalLineList(param: ApprovalLineListRequest(msgCd: msgCd)), success: { (response: ApiResponse<ApprovalLineListResponse>) in
            self.hud.dismiss()
            //            print("response : \(response)")
            if let result = response.value {
                //                print("result : \(result)")
                if let list = result.data {
                    self.lineList = list
                    self.cvLineHeightAnchor?.isActive = false
                    let totalHeight = self.cvLineHeight*list.count + 8*(list.count-1)
                    self.cvLineHeightAnchor = self.cvLine.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight))
                    self.cvLineHeightAnchor?.isActive = true
                    for i in self.lineList.indices {
                        let item = self.lineList[i]
                        if item.prsnCd == Environment.USER_PRSN_CD {
                            if item.seqNo == self.seqNo {
                                if item.statusCd == "미결".localized {
                                    self.lineList[i].isActive = true
                                    self.stackView.isHidden = false
                                    break
                                }
                            }
                        }
                    }
                    self.cvLine.reloadData()
                }
            }
            
        }) { (error) in
            self.hud.dismiss()
        }
        
    }
    
    func getHtmlCode(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.contentsRead(param: ApprovalLineListRequest(msgCd: msgCd)), success: { (response: ApiResponse<ApprovalContentsReadResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                //                    print("getHtmlCode result : \(result)")
                if let contents = result.data?.contents {
                    self.webView.loadHTMLString(contents, baseURL: nil)
                    
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webViewHeight?.constant = webView.scrollView.contentSize.height
        }
    }
    
    func getFileList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.fileList(param: ApprovalLineListRequest(msgCd: msgCd)), success: { (response: ApiResponse<ApprovalFileListResponse>) in
            self.hud.dismiss()
            //            print("response : \(response)")
            
            if let result = response.value {
                if let list = result.data {
                    self.fileList = list
                    self.cvFileHeightAnchor?.isActive = false
                    let cvHeight = list.count * 51 + 8*(list.count-1)
                    //                    print("cvHeight : \(cvHeight)")
                    self.cvFileHeightAnchor = self.cvFile.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
                    self.cvFileHeightAnchor?.isActive = true
                    self.cvFile.reloadData()
                    if list.count < 1 {
                        self.lblFileTitle.isHidden = true
                        self.stackViewTopAnchor?.isActive = false
                        self.stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: self.webView.bottomAnchor, constant:16)
                        self.stackViewTopAnchor?.isActive = true
                    } else {
                        self.lblFileTitle.isHidden = false
                        self.stackViewTopAnchor?.isActive = false
                        self.stackViewTopAnchor = self.stackView.topAnchor.constraint(equalTo: self.cvFile.bottomAnchor, constant:16)
                        self.stackViewTopAnchor?.isActive = true
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    @objc func btnApproveClicked(){
        approval(type: "1")
    }
    @objc func btnDenyClicked(){
        approval(type: "2")
    }
    @objc func btnApproveAllClicked(){
        approval(type: "3")
    }
    func approval(type:String){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: ApprovalApi.approval(param: ApprovalRequest(msgCd: msgCd, seqNo: String(seqNo), type: type)), success: { (response: ApiResponse<ApprovalContentsReadResponse>) in
            self.hud.dismiss()
            //
            
            if let result = response.value {
                if result.status ?? false {
                    var alertComment = ""
                    if type == "1"{
                        alertComment = "결재 되었습니다".localized
                    } else if type == "2" {
                        alertComment = "반려 되었습니다".localized
                    } else {
                        alertComment = "전결 되었습니다".localized
                    }
                    let alert  = UIAlertController(title: "알림".localized, message: alertComment, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
                        NotificationCenter.default.post(name: Notification.Name("callReload"), object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert  = UIAlertController(title: "알림".localized, message: "장애가 발생하였습니다. 전산실로 문의하여 주십시오", preferredStyle: .alert)
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

extension ApprovalWaitDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvLine {
            return lineList.count
        } else {
            return fileList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvLine {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalWaitDetailApprovalLineCollectionViewCell.ID, for: indexPath) as! ApprovalWaitDetailApprovalLineCollectionViewCell
            cell.lbluserSeq.text = "\(lineList[indexPath.row].userSeq ?? 1)" + "차".localized
            cell.lblstatusCd.text = lineList[indexPath.row].statusCd
            cell.lblsysDate.text = ""
            if let statusCd = lineList[indexPath.row].statusCd {
                if statusCd == "승인".localized || statusCd == "전결".localized || statusCd == "반려".localized || statusCd == "-" {
                    cell.lblsysDate.text = lineList[indexPath.row].sysDate
                }
            }
            cell.lblprsnNm.text = lineList[indexPath.row].prsnNm
            print("lineList[indexPath.row] : \(lineList[indexPath.row])")
            if lineList[indexPath.row].isActive ?? false {
                cell.lbluserSeq.font = UIFont.boldSystemFont(ofSize: 16)
                cell.lblstatusCd.font = UIFont.boldSystemFont(ofSize: 16)
                cell.lblsysDate.font = UIFont.boldSystemFont(ofSize: 16)
                cell.lblprsnNm.font = UIFont.boldSystemFont(ofSize: 16)
                cell.layer.borderColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1).cgColor
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApprovalWaitDetailFileListCollectionViewCell.ID, for: indexPath) as! ApprovalWaitDetailFileListCollectionViewCell
            cell.lblfileName.text = fileList[indexPath.row].fileName
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvFile {
            let title = fileList[indexPath.row].fileName ?? ""
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(title)
                print("download fileURL : \(fileURL)")
                return (fileURL, [.removePreviousFile])
            }
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            let urlString = "\(Environment.BASE_URL)/approval/fileDownload"
            let parameters:[String : Any] = [
                "fileName" : title,
                "filePath": fileList[indexPath.row].filePath ?? ""
            ]
            let session = URLSession.shared
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue(Environment.AUTHORIZATOIN, forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                } catch let error {
                    print(error.localizedDescription)
                }
                
                let task = session.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    // Success
                    print("response : \(response)")
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        //                print("Success: \(statusCode)")
                    }
                    do {
                        let documentFolderURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                        let fileURL = documentFolderURL.appendingPathComponent(title)
                        print("data : \(data)")
                        try data!.write(to: fileURL)
                        DispatchQueue.main.async {
                            self.hud.dismiss()
                        }
                    } catch  {
                        print("error writing file \(title) : \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        
        if collectionView == cvLine {
            return CGSize(width: collectionViewSize, height: 55)
        } else {
            return CGSize(width: collectionViewSize, height: 51)
        }
    }
}

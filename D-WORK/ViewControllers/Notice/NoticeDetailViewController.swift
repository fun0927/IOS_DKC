//
//  NoticeDetailViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import UIKit
import JGProgressHUD
import WebKit
import Alamofire

class NoticeDetailViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol, UIDocumentInteractionControllerDelegate {
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let hud = JGProgressHUD()
    let util = Util()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Medium", size: 16)
        return label
    }()
    
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
    
    var infoData:NoticeInfoListResponseData?
    let webView = WKWebView()
    var dvs = ""
    
    let downloadView = UIView()
    
    let lblDownload: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font =  UIFont(name: "NotoSansKR-Regular", size: 16)
        return label
    }()
    
    let ivDownload:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "download")
        return imageView
    }()
    
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
        let topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 76))
        topView.backDelegate = self
        topView.titleDelegate = self
        topView.isShowBtnBack = true
        topView.isShowNoti = true
        view.addSubview(topView)
        
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
        
        
        let viewContent = UIView()
        view.addSubview(viewContent)
        viewContent.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        viewContent.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewContent.topAnchor.constraint(equalTo: viewHeader.bottomAnchor).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        viewContent.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        webView.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        webView.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 24).isActive = true
        webView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -98).isActive = true
        
        downloadView.backgroundColor = .white
        downloadView.layer.borderWidth = 1
        downloadView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        downloadView.layer.cornerRadius = 8
        
        viewContent.addSubview(downloadView)
        downloadView.translatesAutoresizingMaskIntoConstraints = false
        downloadView.heightAnchor.constraint(equalToConstant: 51).isActive = true
        downloadView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        downloadView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        downloadView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        downloadView.addSubview(lblDownload)
        lblDownload.translatesAutoresizingMaskIntoConstraints = false
        lblDownload.centerYAnchor.constraint(equalTo: downloadView.centerYAnchor).isActive = true
        lblDownload.leadingAnchor.constraint(equalTo: downloadView.leadingAnchor, constant: 20).isActive = true
        lblDownload.trailingAnchor.constraint(equalTo: downloadView.trailingAnchor, constant: -40).isActive = true
        
        downloadView.addSubview(ivDownload)
        ivDownload.translatesAutoresizingMaskIntoConstraints = false
        ivDownload.centerYAnchor.constraint(equalTo: downloadView.centerYAnchor).isActive = true
        ivDownload.trailingAnchor.constraint(equalTo: downloadView.trailingAnchor, constant: -16).isActive = true
        ivDownload.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivDownload.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivDownload.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivDownloadClicked))
        ivDownload.addGestureRecognizer(tap)
        
        getContent()
    }
    
    @objc func ivDownloadClicked(){
        let title = self.lblDownload.text ?? "noname"
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(title)
            print("download fileURL : \(fileURL)")
            return (fileURL, [.removePreviousFile])
        }
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let urlString = "\(Environment.BASE_URL)/notice/fileDownload"
        let parameters:[String : Any] = [
            "dvs" : dvs,
            "dataNo" : Int(infoData?.dataNo ?? 0),
            "fileName": lblDownload.text ?? ""
        ]
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(Environment.AUTHORIZATOIN, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                // pass dictionary to nsdata object and set it as request body
            } catch let error {
                print(error.localizedDescription)
            }
            
            let task = session.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                // Success
                //            print("response1 : \(response)")
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
        //       print("parameters : \(parameters)")
        //        AF.download("\(Environment.BASE_URL)/notice/fileDownload",
        //                    method: .post,
        //                    parameters: parameters,
        //                    headers: headers,
        //                    to: destination)
        //            .downloadProgress { (progress) in
        //                print("downloading : \((String)(progress.fractionCompleted))")
        //            }
        //            .response { response in
        //                print("response : \(response)")
        //            }
        //            .responseData { (data) in
        //                print("dtata : \(data)")
        ////                self.progressLabel.text = "Completed!"
        //                self.hud.dismiss()
        //
        //            }
    }
    
    func getContent(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: NoticeApi.infoDetail(
            param: NoticeInfoDetailRequest(
                dvs: dvs,
                dataNo: String(Int(infoData?.dataNo ?? 0)))), success: { (response: ApiResponse<NoticeHtmlContentResponse>) in
            self.hud.dismiss()
            if let result = response.value {
//                print("result : \(result)")
                if let data = result.data {
//                    print("data : \(data)")
                    self.lblTitle.text = data.title
                    self.lblsendPrsnNm.text = data.prsnNm
                    self.lblsendDtm.text = data.regDate
                    if let content = data.content {
//                        self.webView.loadHTMLString(content, baseURL: nil)
                        let meta_java : String = "<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">"
                        self.webView.loadHTMLString(meta_java + content, baseURL: nil)
                    }
                    if data.fileYn == "Y" {
                        self.getFileList()
                    }else {
                        self.downloadView.isHidden = true
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    
    func getFileList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: NoticeApi.fileList(
            param: NoticeInfoDetailRequest(
                dvs: dvs,
                dataNo: String(Int(infoData?.dataNo ?? 0)))), success: { (response: ApiResponse<NoticeFileListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    if list.count > 0 {
                        self.lblDownload.text = list[0].fileName
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
}

//
//  MainShorCutEditViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/18.
//

import UIKit
import SQLite
import JGProgressHUD

class MainShorCutEditViewController: UIViewController, TopViewBackProtocol, TopViewTitleProtocol {
    let hud = JGProgressHUD()
    var menuAuthList:[MenuAuthDetailResponse] = []
    var selectedArray:[Util.ShortCutContent] = []
    var selectedCount = 0
    func btnBackClicked() {
        dismiss(animated: true, completion: nil)
    }
    func ivTitleClicked() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
    }
    
    let cvShortCut = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let util = Util()
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("저장".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var cvShortCutHeightAnchor:NSLayoutConstraint?
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
        topView.isShowBtnBack = true
        topView.titleDelegate = self
        topView.backDelegate = self
        topView.isShowNoti = true
        self.view.addSubview(topView)
        
        //        view.addSubview(lblNotiTitle)
        //        lblNotiTitle.translatesAutoresizingMaskIntoConstraints = false
        //        lblNotiTitle.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 21).isActive = true
        //        lblNotiTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        //
        //        view.addSubview(lblNotiContent)
        //        lblNotiContent.translatesAutoresizingMaskIntoConstraints = false
        //        lblNotiContent.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 21).isActive = true
        //        lblNotiContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 73).isActive = true
        
        let divider = UIView()
        divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cvShortCut.collectionViewLayout = cvLayout
        
        cvShortCut.delegate = self
        cvShortCut.dataSource = self
        scrollView.addSubview(cvShortCut)
        cvShortCut.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        //        cvShortCut.backgroundColor = .red
        cvShortCut.translatesAutoresizingMaskIntoConstraints = false
        cvShortCut.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        cvShortCut.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvShortCut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //        cvShortCut.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -200).isActive = true
        
        let cvHeight =  57
        cvShortCutHeightAnchor = cvShortCut.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
        cvShortCutHeightAnchor?.isActive = true
        cvShortCut.register(EditShortCutCollectionViewCell.self, forCellWithReuseIdentifier: EditShortCutCollectionViewCell.ID)
        cvShortCut.isScrollEnabled = false
        
        scrollView.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.topAnchor.constraint(equalTo: cvShortCut.bottomAnchor, constant: 16).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -65).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        
        //        getSelectedArray()
        getMenuAuthList()
        // Do any additional setup after loading the view.
    }
    
    @objc func btnSaveClicked() {
        print("selectedArray : \(selectedArray)")
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        do {
            let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            let shorcuts = Table("shorcuts")
            try db.run(shorcuts.delete())
            for shorcut in selectedArray {
                if shorcut.isSelected {
                    try db.run(shorcuts.insert(title <- shorcut.title))
                }
            }
            hud.dismiss()
            let alert  = UIAlertController(title: "알림".localized, message: "저장 되었습니다".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            hud.dismiss()
            print(error)
        }
        
    }
    
    func getSelectedArray(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        selectedArray.removeAll()
        for shorcutItem in util.shorCutArray {
            for menuItem in menuAuthList {
                if menuItem.pgmId == shorcutItem.pgmId || (shorcutItem.pgmId ?? "").left(1) == "P" {
                    selectedArray.append(shorcutItem)
                    break
                }
            }
        }
        
        do {
            let db = try Connection("\(Environment.DB_PATH)/db.sqlite3")
            let title = Expression<String>("title")
            let shorcuts = Table("shorcuts")
            let id = Expression<Int64>("id")
            try db.run(shorcuts.create(ifNotExists: true) { t in     // CREATE TABLE "users" (
                t.column(id, primaryKey: true) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(title)  //     "email" TEXT UNIQUE NOT NULL,
            })
            for shortcut in try db.prepare(shorcuts) {
                print("title: \(shortcut[title])")
                for (index, item) in selectedArray.enumerated() {
                    if item.title == shortcut[title] {
                        selectedArray[index].isSelected = true
                        selectedCount += 1
                    }
                }
            }
            let cvHeight =  selectedArray.count*57
            cvShortCutHeightAnchor?.isActive = false
            cvShortCutHeightAnchor = cvShortCut.heightAnchor.constraint(equalToConstant: CGFloat(cvHeight))
            cvShortCutHeightAnchor?.isActive = true
            cvShortCut.reloadData()
            hud.dismiss()
        } catch {
            print(error)
            hud.dismiss()
        }
    }
    
    func getMenuAuthList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: MainApi.menuAuthList, success: { (response: ApiResponse<MenuAuthResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    for item in list {
                        if let auth = item.auth {
                            if auth == "N" {
                                
                            } else {
                                self.menuAuthList.append(MenuAuthDetailResponse(pgmId: item.pgmId, auth: auth))
                            }
                        }
                    }
                    self.getSelectedArray()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
}

extension MainShorCutEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditShortCutCollectionViewCell.ID, for: indexPath) as! EditShortCutCollectionViewCell
        cell.lblTitle.text = selectedArray[indexPath.row].title
        cell.ivIcon.image = selectedArray[indexPath.row].editIcon
        cell.cbCheck.isSelected = selectedArray[indexPath.row].isSelected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EditShortCutCollectionViewCell
        if selectedCount > 5 {
            if !cell.cbCheck.isSelected {
                let alert  = UIAlertController(title: "알림".localized, message: "바로가기 선택은 최대 6개입니다".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        cell.cbCheck.isSelected = !cell.cbCheck.isSelected
        if cell.cbCheck.isSelected {
            selectedCount += 1
        } else {
            selectedCount -= 1
        }
        selectedArray[indexPath.row].isSelected = cell.cbCheck.isSelected
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize, height: 57)
    }
}

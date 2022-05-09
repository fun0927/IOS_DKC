//
//  SlideMenuViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/20.
//

import UIKit
import JGProgressHUD
class SlideMenuViewController: UIViewController {
    var menuModel = SlideMenuModel()
    let hud = JGProgressHUD()
    var menuAuthList:[MenuAuthDetailResponse] = []
    let util = Util()
    let lblUser: UILabel = {
        let label = UILabel()
        label.text = "사용자명"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        //        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    let btnSetting: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting"), for: .normal)
        //        button.imageView?.contentMode = .scaleAspectFit
        //        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 22, bottom: 25, right: 22)
        return button
    }()
    
    let btnLogout: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logout"), for: .normal)
        //        button.imageView?.contentMode = .scaleAspectFit
        //        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 22, bottom: 25, right: 22)
        return button
    }()
    
    
    let menuTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblUser)
        view.addSubview(btnLogout)
        view.addSubview(btnSetting)
        lblUser.translatesAutoresizingMaskIntoConstraints = false
        lblUser.topAnchor.constraint(equalTo: view.topAnchor, constant: 91).isActive = true
        lblUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26).isActive = true
        lblUser.trailingAnchor.constraint(equalTo: btnSetting.leadingAnchor, constant: 10).isActive = true
        lblUser.text = Environment.USER_NAME
        
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.centerYAnchor.constraint(equalTo: lblUser.centerYAnchor).isActive = true
        btnLogout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -27).isActive = true
        btnLogout.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnLogout.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnLogout.addTarget(self, action: #selector(btnLogoutClicked), for: .touchUpInside)
        
        btnSetting.translatesAutoresizingMaskIntoConstraints = false
        btnSetting.centerYAnchor.constraint(equalTo: lblUser.centerYAnchor).isActive = true
        btnSetting.trailingAnchor.constraint(equalTo: btnLogout.leadingAnchor, constant: -17).isActive = true
        btnSetting.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnSetting.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnSetting.addTarget(self, action: #selector(btnSettingClicked), for: .touchUpInside)
        
        view.addSubview(menuTableView)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        menuTableView.topAnchor.constraint(equalTo: lblUser.bottomAnchor, constant: 5).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.ID)
//        menuTableView.separatorStyle = .none
//        menuTableView.contentInset = .zero
//        menuTableView.contentInsetAdjustmentBehavior = .never
//        menuTableView.tableFooterView = UIView(frame: .zero)
        
//        menuTableView.separatorInset.top = 0
//        menuTableView.separatorInset.bottom = 0
        menuTableView.backgroundColor = UIColor.white
        menuTableView.delegate = self
        
        getMenuAuthList()
        // Do any additional setup after loading the view.
    }
    
    func getMenuAuthList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: MainApi.menuAuthList, success: { (response: ApiResponse<MenuAuthResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let list = result.data {
                    for item in list.reversed() {
                        if let auth = item.auth {
                            if auth == "N" {
                                for (menuItemIndex,menuItem) in self.menuModel.menu.enumerated() {
                                    for (index, value) in menuItem.deptth2.enumerated() {
                                        if let itemPgmId = item.pgmId, let valuePgmId = value.pgmId, itemPgmId == valuePgmId {
                                            self.menuModel.menu[menuItemIndex].deptth2.remove(at: index)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.menuTableView.reloadData()
                }
            }
        }) { (error) in
            self.hud.dismiss()
        }
    }
    @objc func btnLogoutClicked(){
        
        let alert  = UIAlertController(title: "알림", message: "로그 아웃 되었습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            let defaults: UserDefaults = UserDefaults.standard
            defaults.set(false, forKey: "autoLogin")
            defaults.synchronize()
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        })
    }
    
    @objc func btnSettingClicked(){
        if let getVc = util.getViewControllerFromText(label: "개인정보 변경 신청") {
            //            print("slidemenu didSelectRowAt getVc : \(getVc)")
            
            NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
            self.dismiss(animated: true, completion: nil)
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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

extension SlideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuModel.menu.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 59
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.menuModel.menu[section].isCollapsible ? menuModel.menu[section].deptth2.count : 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MenuTableViewCell {
            if indexPath.row == menuModel.menu[indexPath.section].deptth2.count-1 {
                cell.lastBottomSectionView.isHidden = false
                cell.leftView.isHidden = true
                cell.rightView.isHidden = true
            } else {
                cell.lastBottomSectionView.isHidden = true
                cell.leftView.isHidden = false
                cell.rightView.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.lblContent.text = menuModel.menu[indexPath.section].deptth2[indexPath.row].title
        cell.lblContent.isHidden = false
        cell.lblUpper.isHidden = true
        cell.row = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuModel.menu[indexPath.section].isCollapsible.toggle()
        self.menuTableView.reloadData()
        
        let label = menuModel.menu[indexPath.section].deptth2[indexPath.row].title
        if let getVc = util.getViewControllerFromText(label: label) {
            if let getVc2 = getVc as?  NoticeListViewController {
                //공지사항 분류에 따라 구분을 다르게 함
                switch label {
                case "사내공지사항":
                    getVc2.dvs = "1"
                case "안전공지사항":
                    getVc2.dvs = "2"
                case "노동조합공지사항":
                    getVc2.dvs = "3"
                default:
                    getVc2.dvs = "1"
                }
                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc2)
                self.dismiss(animated: true, completion: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("changeMainChildeView"), object: getVc)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension SlideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.lblUpper.text = menuModel.menu[section].depth1
        cell.lblUpper.isHidden = false
        cell.lblContent.isHidden = true
        cell.lastBottomSectionView.isHidden = true
        cell.leftView.isHidden = true
        cell.rightView.isHidden = true
        
        cell.section = section
        cell.delegate = self
        cell.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: #selector(cell.didTapHeader)))
        if self.menuModel.menu[section].isCollapsible {
            cell.rightImageView.image = UIImage(named: "arrow-up")
        } else {
            cell.rightImageView.image = UIImage(named: "arrow-down")
            cell.lastBottomSectionView.isHidden = true
            cell.leftView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .white
        let sectionView = UIView()
        view.addSubview(sectionView)
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        sectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        if !self.menuModel.menu[section].isCollapsible  {
            sectionView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
            sectionView.layer.borderWidth = 1
            sectionView.layer.cornerRadius = 8
        } else {
            sectionView.clipsToBounds = true
            sectionView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
            sectionView.layer.borderWidth = 1
            sectionView.layer.cornerRadius = 8
            sectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        }
    }
}

extension SlideMenuViewController: HeaderViewDelegate {
    func toggleSection(section: Int) {
        self.menuModel.menu[section].isCollapsible.toggle()
        self.menuTableView.reloadData()
    }
}

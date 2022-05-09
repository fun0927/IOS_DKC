//
//  MainViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import UIKit
import SideMenu

class MainViewController: UIViewController, TopViewMenuProtocol, SlideMenuVIewProtocol, TopViewTitleProtocol {
   
    let pageViewController = MainPageViewController()
    var slideMenuIsVisible = false
    var slideLeadingAnchor:NSLayoutConstraint?
    let slideMenuView = SlideMenuView(frame: CGRect.zero)
    let greyBackgroundView = UIView()
    
    enum MainTab {
        case WorkingStatus
        case RegisterWater
    }
    var mainTabView = MainTab.WorkingStatus
   
    
    let lblNotiTitle: UILabel = {
        let label = UILabel()
//        label.text = "공지사항"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
//        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    let lblNotiContent: UILabel = {
        let label = UILabel()
//        label.text = "다이후쿠코리아 공지사항 안내"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
//        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    let btnWorkingStatus: UIButton = {
        let button = UIButton()
        button.setTitle("근무 현황".localized,for: .normal)
        button.setTitleColor(UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return button
    }()
    
    let btnWaterRegister: UIButton = {
        let button = UIButton()
        if(Environment.IS_MANAGE == "0") {
            button.setTitle("출퇴근 식수 등록".localized, for:.normal)
        }else {
            button.setTitle("식수 등록".localized, for:.normal)
        }
        button.setTitleColor(UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        return button
    }()
    
    let selectedTabBottom:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        view.layer.cornerRadius = 2
        return view
    }()
    var selectedTabBottonCenterXAnchor:NSLayoutConstraint?
    
    var slideMenuViewNavigation:SideMenuNavigationController?
    let divider2 = UIView()
    
    var currentChildViewController:UIViewController?
    let divider = UIView()
    
    var topView:TopView?
    
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
        topView = TopView(frame:CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: 72))
        topView?.menuDelegate = self
        topView?.titleDelegate = self
        topView?.isShowBtnMenu = true
        topView?.isShowNoti = true
        
        self.view.addSubview(topView!)
        
//        view.addSubview(lblNotiTitle)
//        lblNotiTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblNotiTitle.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 21).isActive = true
//        lblNotiTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//
//        view.addSubview(lblNotiContent)
//        lblNotiContent.translatesAutoresizingMaskIntoConstraints = false
//        lblNotiContent.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 21).isActive = true
//        lblNotiContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 73).isActive = true
//
//
//
        
        divider.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: topView!.bottomAnchor, constant: 0).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(btnWorkingStatus)
        btnWorkingStatus.translatesAutoresizingMaskIntoConstraints = false
        btnWorkingStatus.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnWorkingStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        btnWorkingStatus.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12).isActive = true
        btnWorkingStatus.addTarget(self, action: #selector(btnWorkingStatusClicked), for: .touchUpInside)
        
        view.addSubview(btnWaterRegister)
        btnWaterRegister.translatesAutoresizingMaskIntoConstraints = false
        btnWaterRegister.leadingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnWaterRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        btnWaterRegister.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12).isActive = true
        btnWaterRegister.addTarget(self, action: #selector(btnWarterRegisterClicked), for: .touchUpInside)
        
        
        divider2.backgroundColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1)
        view.addSubview(divider2)
        divider2.translatesAutoresizingMaskIntoConstraints = false
        divider2.topAnchor.constraint(equalTo: btnWaterRegister.bottomAnchor, constant: 15).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      
        
        view.addSubview(selectedTabBottom)
        selectedTabBottom.translatesAutoresizingMaskIntoConstraints = false
        selectedTabBottom.topAnchor.constraint(equalTo: btnWaterRegister.bottomAnchor, constant: 13).isActive = true
        selectedTabBottom.heightAnchor.constraint(equalToConstant: 2).isActive = true
//        selectedTabBottom.centerXAnchor.constraint(equalTo: btnWorkingStatus.centerXAnchor).isActive = true
        selectedTabBottom.widthAnchor.constraint(equalToConstant: 138).isActive = true
        selectedTabBottonCenterXAnchor = selectedTabBottom.centerXAnchor.constraint(equalTo: btnWorkingStatus.centerXAnchor)
        selectedTabBottonCenterXAnchor?.isActive = true
//
        //page view setting 순서가 중요
        pageViewController.mainViewController = self
        self.addChild(pageViewController)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pageViewController.view)
        pageViewController.view.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 0).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        pageViewController.willMove(toParent: self)
        pageViewController.didMove(toParent: self)
        currentChildViewController = pageViewController
        
       view.addSubview(greyBackgroundView)
       greyBackgroundView.translatesAutoresizingMaskIntoConstraints = false
       greyBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
       greyBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       greyBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       greyBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       greyBackgroundView.isHidden = true
       greyBackgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        
        slideMenuViewNavigation = SideMenuNavigationController(rootViewController: SlideMenuViewController())
        slideMenuViewNavigation?.presentationStyle = .menuSlideIn
        slideMenuViewNavigation?.statusBarEndAlpha = 0
        slideMenuViewNavigation?.menuWidth = 300
        slideMenuViewNavigation?.leftSide = true
        slideMenuViewNavigation?.presentationStyle.presentingEndAlpha = 0.5
//        // slide menu setting
//        self.view.addSubview(slideMenuView)
//        slideMenuView.translatesAutoresizingMaskIntoConstraints = false
//        slideMenuView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        slideMenuView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        slideLeadingAnchor = slideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -300)
//        slideLeadingAnchor?.isActive = true
//        slideMenuView.delegate = self
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(changeMainChildeView(_:)), name: NSNotification.Name("changeMainChildeView"), object: nil)

        
    }
    func ivTitleClicked() {
        changeChildView(getVc: pageViewController)
    }
    
   
    @objc func changeMainChildeView(_ notification: Notification) {
        
//            print("Test changeMainChildeView")
        if let getVc = notification.object as? UIViewController {
            changeChildView(getVc: getVc)
//            self.present(getVc, animated: true, completion: nil)
        }
            
    }
    
    func changeChildView(getVc:UIViewController){
        
        currentChildViewController?.willMove(toParent: nil)
        currentChildViewController?.view.removeFromSuperview()
        currentChildViewController?.removeFromParent()
        print("changeChildView newVC : \(getVc)")
        DispatchQueue.main.async {
            if let newVC = getVc as? MyWorkingListViewController {
                self.addChild(newVC)
                newVC.view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(newVC.view)
                newVC.view.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 0).isActive = true
                newVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                newVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                newVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        pageViewController.willMove(toParent: self)
                newVC.didMove(toParent: self)
                self.currentChildViewController = newVC
                
            } else if let newVC = getVc as? WorkingPlanViewController {
                self.addChild(newVC)
                newVC.view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(newVC.view)
                newVC.view.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 0).isActive = true
                newVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                newVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                newVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        pageViewController.willMove(toParent: self)
                newVC.didMove(toParent: self)
                self.currentChildViewController = newVC
            } else if let newVC = getVc as? CheckListViewController {
                self.addChild(newVC)
                newVC.view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(newVC.view)
                newVC.view.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 0).isActive = true
                newVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                newVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                newVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        pageViewController.willMove(toParent: self)
                newVC.didMove(toParent: self)
                self.currentChildViewController = newVC
            } else if let newVc = getVc as? MainPageViewController {
                newVc.mainViewController = self
                self.addChild(newVc)
                newVc.view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(newVc.view)
                newVc.view.topAnchor.constraint(equalTo: self.divider2.bottomAnchor, constant: 0).isActive = true
                newVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                newVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                newVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        pageViewController.willMove(toParent: self)
                newVc.didMove(toParent: self)
                self.currentChildViewController = newVc
                
            } else {
                // 일반 뷰들
                
                self.addChild(getVc)
                getVc.view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(getVc.view)
                getVc.view.topAnchor.constraint(equalTo: self.divider.bottomAnchor, constant: 0).isActive = true
                getVc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                getVc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                getVc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        //        pageViewController.willMove(toParent: self)
                getVc.didMove(toParent: self)
                self.currentChildViewController = getVc
            }
            
        }
        
    }
    
    
    
    @objc func btnWorkingStatusClicked(){
        if mainTabView == .RegisterWater {
            pageViewController.goToPreviousPage()
            mainTabView = .WorkingStatus
            tabeViewChange()
        }
        
    }
    @objc func btnWarterRegisterClicked(){
        if mainTabView == .WorkingStatus  {
            pageViewController.goToNextPage()
            mainTabView = .RegisterWater
            tabeViewChange()
        }
        
    }
//    @objc func switchMainTab(){
//        if mainTabView == .WorkingStatus  {
//            pageViewController.goToNextPage()
//            mainTabView = .RegisterWater
//
//        } else if mainTabView == .RegisterWater && btnWorkingStatus.isSelected {
//            pageViewController.goToPreviousPage()
//            mainTabView = .WorkingStatus
//        }
//        tabeViewChange()
//    }
    
    func changeFromPageViewController(changeTo:MainTab){
        print("changeFromPageViewController changeTo:\(changeTo)" )
        mainTabView = changeTo
        tabeViewChange()
    }
    
    func tabeViewChange(){
        if mainTabView != .WorkingStatus {
            btnWorkingStatus.setTitleColor(UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
            btnWaterRegister.setTitleColor(UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1), for:.normal)
            selectedTabBottonCenterXAnchor?.isActive = false
            selectedTabBottonCenterXAnchor = selectedTabBottom.centerXAnchor.constraint(equalTo: btnWaterRegister.centerXAnchor)
            selectedTabBottonCenterXAnchor?.isActive = true
        } else {
            btnWorkingStatus.setTitleColor(UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1), for:.normal)
            btnWaterRegister.setTitleColor(UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
            selectedTabBottonCenterXAnchor?.isActive = false
            selectedTabBottonCenterXAnchor = selectedTabBottom.centerXAnchor.constraint(equalTo: btnWorkingStatus.centerXAnchor)
            selectedTabBottonCenterXAnchor?.isActive = true
        }
    }

    func btnMenuClicked() {
//       toggleSlide()
        if let slideMenuViewNavigation = slideMenuViewNavigation{
            present(slideMenuViewNavigation, animated: true, completion: nil)
        }
        
    }
    func swipeLeft() {
        //안쓰는 코드
        toggleSlide()
    }
    func toggleSlide(){
        if slideMenuIsVisible {
            slideMenuIsVisible = !slideMenuIsVisible
            slideLeadingAnchor?.isActive = false
            slideLeadingAnchor = slideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -300)
            slideLeadingAnchor?.isActive = true
//            greyBackgroundView.isHidden = true
            
        } else {
            
            slideMenuIsVisible = !slideMenuIsVisible
            slideLeadingAnchor?.isActive = false
            slideLeadingAnchor = slideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
            slideLeadingAnchor?.isActive = true
            
            greyBackgroundView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            if !self.slideMenuIsVisible {
                self.greyBackgroundView.isHidden = true
            }
           }) { (animationComplete) in
               print("The animation is complete!")
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let _ = self.currentChildViewController as? RecvHistViewController {
            topView?.getPushCount()
        }
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

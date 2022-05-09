//
//  CardAddViewAgreementController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/21.
//

import UIKit
import JGProgressHUD

class CardAddViewAgreementController: UIViewController, CheckBoxProtocol {
   
    var previousViewController:UIViewController?
    let hud = JGProgressHUD()
    let btnCLose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    var subNm = ""
    var subCd = ""
    let scrollView = UIScrollView()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "법인카드 참고".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let lblSubTitle1: UILabel = {
        let label = UILabel()
        label.text = "법인카드 사용대상".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContent1: UILabel = {
        let label = UILabel()
        label.text = "1.회사 업무 관련 모든 경비 지출".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblSubTitle2: UILabel = {
        let label = UILabel()
        label.text = "사용보고 및 지출의뢰".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContent2: UILabel = {
        let label = UILabel()
        label.text = "1.지출의뢰서 작성, 결재\n1-1.영수증을 첨부하여 지출의뢰서를 작성 후\n전결규정에 의하여 결재를 받는다.\n1-2.사전신청 시 예상금액보다 초과하여 지출 시\n사유를 구두 보고한다.\n*카드사용 익일 지출의뢰서 작성, 보고\n2.지출의뢰서 제출 및 카드 반납\n2-1.결재를 득한 지출의뢰서와 카드를\n법인카드 관리부서(경리과)에 반납한다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblSubTitle3: UILabel = {
        let label = UILabel()
        label.text = "사용시 유의사항".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContent3: UILabel = {
        let label = UILabel()
        label.text = "부정청탁 및 금품 등 수수의 금지에 관한 법률에\n적용되지 않도록 사용시 유의하시기 바랍니다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblTitleJD: UILabel = {
        let label = UILabel()
        label.text = "접대비 참고".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    let lblSubTitleJD1: UILabel = {
        let label = UILabel()
        label.text = "접대비 사용대상".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContentJD1: UILabel = {
        let label = UILabel()
        label.text = "1.다이후쿠코리아(주)윤리경영 가이드라인을\n준수하는  회사 업무관련 접대".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblSubTitleJD2: UILabel = {
        let label = UILabel()
        label.text = "접대비 신청방법".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContentJD2: UILabel = {
        let label = UILabel()
        label.text = "1.접대하기전 사전신청을 하고 승인을 득한 후 접대를 한다.\n(신청자가 최종승인 직위일 경우 상위직급자의 승인을 득한다.)\n2.해외출장시 긴급히 접대가 필요한 경우 메일로 승인을 득한다.\n3.접대시에는 원칙적으로 볍률상 인정하는 정규 증빙을\n수취한다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblSubTitleJD3: UILabel = {
        let label = UILabel()
        label.text = "사용보고".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblContentJD3: UILabel = {
        let label = UILabel()
        label.text = "1.접대후에는 귀사후 3영업일내에 영수증을 첨부하여\n지출의뢰서를 작성 후 전결규정에 의하여 결재를 받는다.\n2.사전신청시 예상금액보다 초과하여 지출시에는\n사유를 기재한다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lblCheck: UILabel = {
        let label = UILabel()
        label.text = "위내용을 확인하였습니다".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("확인".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var middleViewHeightAnchor:NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(btnCLose)
//        btnCLose.translatesAutoresizingMaskIntoConstraints = false
//        btnCLose.widthAnchor.constraint(equalToConstant: 32).isActive = true
//        btnCLose.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        btnCLose.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
//        btnCLose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
//        btnCLose.addTarget(self, action: #selector(btnCLoseClicked), for: .touchUpInside)

        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let middleView = UIView()
        middleView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.addSubview(middleView)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        middleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        middleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let titleView1 = UIView()
        titleView1.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        scrollView.addSubview(titleView1)
        titleView1.translatesAutoresizingMaskIntoConstraints = false
        titleView1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        titleView1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleView1.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(lblTitle)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.centerYAnchor.constraint(equalTo: titleView1.centerYAnchor).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblSubTitle1)
        lblSubTitle1.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitle1.topAnchor.constraint(equalTo: titleView1.bottomAnchor, constant: 16).isActive = true
        lblSubTitle1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContent1)
        lblContent1.translatesAutoresizingMaskIntoConstraints = false
        lblContent1.topAnchor.constraint(equalTo: lblSubTitle1.bottomAnchor, constant: 9).isActive = true
        lblContent1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContent1.numberOfLines = 0
        
        scrollView.addSubview(lblSubTitle2)
        lblSubTitle2.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitle2.topAnchor.constraint(equalTo: lblContent1.bottomAnchor, constant: 24).isActive = true
        lblSubTitle2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContent2)
        lblContent2.translatesAutoresizingMaskIntoConstraints = false
        lblContent2.topAnchor.constraint(equalTo: lblSubTitle2.bottomAnchor, constant: 9).isActive = true
        lblContent2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContent2.numberOfLines = 0
        
        scrollView.addSubview(lblSubTitle3)
        lblSubTitle3.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitle3.topAnchor.constraint(equalTo: lblContent2.bottomAnchor, constant: 24).isActive = true
        lblSubTitle3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContent3)
        lblContent3.translatesAutoresizingMaskIntoConstraints = false
        lblContent3.topAnchor.constraint(equalTo: lblSubTitle3.bottomAnchor, constant: 9).isActive = true
        lblContent3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContent3.numberOfLines = 0
        
        middleView.bottomAnchor.constraint(equalTo: lblContent3.bottomAnchor, constant: 16).isActive = true
        
        //JD
        let middleViewJD = UIView()
        middleViewJD.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        scrollView.addSubview(middleViewJD)
        middleViewJD.translatesAutoresizingMaskIntoConstraints = false
        middleViewJD.topAnchor.constraint(equalTo: lblContent3.bottomAnchor, constant: 32).isActive = true
        middleViewJD.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        middleViewJD.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let titleViewJD1 = UIView()
        titleViewJD1.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        scrollView.addSubview(titleViewJD1)
        titleViewJD1.translatesAutoresizingMaskIntoConstraints = false
        titleViewJD1.topAnchor.constraint(equalTo: lblContent3.bottomAnchor, constant: 16).isActive = true
        titleViewJD1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        titleViewJD1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleViewJD1.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(lblTitleJD)
        lblTitleJD.translatesAutoresizingMaskIntoConstraints = false
        lblTitleJD.centerYAnchor.constraint(equalTo: titleViewJD1.centerYAnchor).isActive = true
        lblTitleJD.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblSubTitleJD1)
        lblSubTitleJD1.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitleJD1.topAnchor.constraint(equalTo: titleViewJD1.bottomAnchor, constant: 16).isActive = true
        lblSubTitleJD1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContentJD1)
        lblContentJD1.translatesAutoresizingMaskIntoConstraints = false
        lblContentJD1.topAnchor.constraint(equalTo: lblSubTitleJD1.bottomAnchor, constant: 9).isActive = true
        lblContentJD1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContentJD1.numberOfLines = 0
        
        scrollView.addSubview(lblSubTitleJD2)
        lblSubTitleJD2.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitleJD2.topAnchor.constraint(equalTo: lblContentJD1.bottomAnchor, constant: 24).isActive = true
        lblSubTitleJD2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContentJD2)
        lblContentJD2.translatesAutoresizingMaskIntoConstraints = false
        lblContentJD2.topAnchor.constraint(equalTo: lblSubTitleJD2.bottomAnchor, constant: 9).isActive = true
        lblContentJD2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContentJD2.numberOfLines = 0
        
        scrollView.addSubview(lblSubTitleJD3)
        lblSubTitleJD3.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitleJD3.topAnchor.constraint(equalTo: lblContentJD2.bottomAnchor, constant: 24).isActive = true
        lblSubTitleJD3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        
        scrollView.addSubview(lblContentJD3)
        lblContentJD3.translatesAutoresizingMaskIntoConstraints = false
        lblContentJD3.topAnchor.constraint(equalTo: lblSubTitleJD3.bottomAnchor, constant: 9).isActive = true
        lblContentJD3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32).isActive = true
        lblContentJD3.numberOfLines = 0
        
        middleViewJD.bottomAnchor.constraint(equalTo: lblContentJD3.bottomAnchor, constant: 16).isActive = true
        
        let cbCheck = CheckBox()
        scrollView.addSubview(cbCheck)
        cbCheck.translatesAutoresizingMaskIntoConstraints = false
        cbCheck.delegate = self
        cbCheck.name = "cbCheck"
        cbCheck.topAnchor.constraint(equalTo: lblContentJD3.bottomAnchor, constant: 32).isActive = true
        cbCheck.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 86).isActive = true
        cbCheck.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbCheck.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        scrollView.addSubview(lblCheck)
        lblCheck.translatesAutoresizingMaskIntoConstraints = false
        lblCheck.centerYAnchor.constraint(equalTo: cbCheck.centerYAnchor).isActive = true
        lblCheck.leadingAnchor.constraint(equalTo: cbCheck.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(btnSave)
        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.topAnchor.constraint(equalTo: cbCheck.bottomAnchor, constant: 16).isActive = true
        btnSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnSave.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -33).isActive = true
        btnSave.backgroundColor = colors.BTN_DISABLE
        btnSave.isUserInteractionEnabled = false
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside)
        
        // subCd : 1 법인카드, 2: 접대비포함, 3: 접대비
        if subCd == "1" {
            lblTitleJD.isHidden = true
            lblSubTitleJD1.isHidden = true
            lblContentJD1.isHidden = true
            lblSubTitleJD2.isHidden = true
            lblContentJD2.isHidden = true
            lblSubTitleJD3.isHidden = true
            lblContentJD3.isHidden = true
            titleViewJD1.isHidden = true
            middleViewJD.isHidden = true
            cbCheck.topAnchor.constraint(equalTo: lblContent3.bottomAnchor, constant: 32).isActive = true
        }else if subCd == "3" {
            lblTitle.isHidden = true
            lblSubTitle1.isHidden = true
            lblContent1.isHidden = true
            lblSubTitle2.isHidden = true
            lblContent2.isHidden = true
            lblSubTitle3.isHidden = true
            lblContent3.isHidden = true
            titleView1.isHidden = true
            middleView.isHidden = true
            titleViewJD1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        }
    }
    
    @objc func btnCLoseClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func onSelectChange(name: String, isSelected: Bool) {
        if isSelected {
            btnSave.backgroundColor = colors.BTN_ABLE
            btnSave.isUserInteractionEnabled = true
        } else {
            btnSave.backgroundColor = colors.BTN_DISABLE
            btnSave.isUserInteractionEnabled = false
        }
    }
    
    @objc func btnSaveClicked(){
        self.dismiss(animated: true, completion: nil)
    }
}

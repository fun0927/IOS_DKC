//
//  WorkOverViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/16.
//

import UIKit
import JGProgressHUD
class WorkOverViewController: UIViewController, DropDownViewProtocol, CheckBoxProtocol {
    
    
    let scrollView = UIScrollView()
    let hud = JGProgressHUD()
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일".localized, "월".localized, "화".localized, "수".localized, "목".localized, "금".localized, "토".localized]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    var infoList:[MonthWorkInfoListData] = []
    var divNmDropDown = DropDownBtn()
    var divNmList:[String] = []
    var getdivNmList:[WorkReportReqInfoListDetailResponse] = []
    let lblMonth: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    
    let lblworkingDay: UILabel = {
        let label = UILabel()
        label.text = "근무일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lblworkingDayValue: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lbldayOff: UILabel = {
        let label = UILabel()
        label.text = "휴무일".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    let lbldayOffValue: UILabel = {
        let label = UILabel()
        label.text = "".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lblbaseWorkingHour: UILabel = {
        let label = UILabel()
        label.text = "총근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lblbaseWorkingHourValue: UILabel = {
        let label = UILabel()
        label.text = "".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lblmaxWorkingHour: UILabel = {
        let label = UILabel()
        label.text = "최대근로".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let lblmaxWorkingHourValue: UILabel = {
        let label = UILabel()
        label.text = "".localized
        label.font = UIFont(name: "NotoSansKR-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let btnPrevious: UIButton = {
        let button = UIButton()
        //        button.setImage(UIImage(named: "previous"), for: .normal)
        //        button.imageView?.contentMode = .scaleAspectFit
        //        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        //        button.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        //        button.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        //        button.layer.borderWidth = 1
        //        button.layer.cornerRadius = 8
        //        button.layer.masksToBounds = true
        
        return button
    }()
    let ivPrevious:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previous")
        return imageView
    }()
    
    
    let btnNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next"), for: .normal)
        return button
    }()
    
    let overView = UIView()
    
    let lblDiv: UILabel = {
        let label = UILabel()
        label.text = "사업부문".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    var selectedDivCd = ""
    
    
    let ivDivsion:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    
    let lblDivCd: UILabel = {
        let label = UILabel()
        label.text = "본부별".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let btnDivStart: UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    
    let btnDivEnd:UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    
    
    let ivTeam:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    
    let lblTeamCd: UILabel = {
        let label = UILabel()
        label.text = "부서별".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let btnTeamStart: UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    
    let btnTeamEnd:UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    let ivPerson:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "radio-unselected")
        return imageView
    }()
    
    let lblPersonCd: UILabel = {
        let label = UILabel()
        label.text = "개인별".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let btnPersonStart: UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    
    let btnPersonEnd:UIButton = {
        let button = UIButton()
        button.setTitle("",for: .normal)
        button.setTitleColor( UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return button
    }()
    enum SearchDiv {
        case div, team, person
    }
    enum ButtonCd {
        case start, end
    }
    var selectedSearchDiv:SearchDiv?
    var selectedButtonCd:ButtonCd?
    var selectedStartCd = ""
    var selectedEndCd = ""
    
    
    let btnFind: UIButton = {
        let button = UIButton()
        button.setTitle("조회".localized,for: .normal)
        button.setTitleColor(.white, for:.normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.backgroundColor = UIColor(red: 0.318, green: 0.282, blue: 0.616, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    var WorkPlanResultInfoList:[WorkPlanResultInfoListData] = []
    let cvWorkPlanResultInfo = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cvWorkPlanResultInfoHeightAnchor:NSLayoutConstraint?
    
    
    let cbGrade3:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblGrade3: UILabel = {
        let label = UILabel()
        label.text = "주의".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    let cbGrade4:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblGrade4: UILabel = {
        let label = UILabel()
        label.text = "위험".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    
    
    let cbGrade5:CheckBox = {
        let checkBox = CheckBox()
        checkBox.setImage(UIImage(named: "check2"), for: .selected)
        return checkBox
    }()
    
    let lblGrade5: UILabel = {
        let label = UILabel()
        label.text = "법위반".localized
        label.font = UIFont(name: "NotoSansKR-Regular", size: 16)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        // Do any additional setup after loading the view.
        
        
        scrollView.addSubview(lblMonth)
        lblMonth.translatesAutoresizingMaskIntoConstraints = false
        lblMonth.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        lblMonth.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24).isActive = true
        
        scrollView.addSubview(ivPrevious)
        ivPrevious.translatesAutoresizingMaskIntoConstraints = false
        ivPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        ivPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        ivPrevious.widthAnchor.constraint(equalToConstant: 10).isActive = true
        ivPrevious.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        scrollView.addSubview(btnPrevious)
        btnPrevious.translatesAutoresizingMaskIntoConstraints = false
        btnPrevious.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnPrevious.trailingAnchor.constraint(equalTo: lblMonth.leadingAnchor, constant: -18).isActive = true
        btnPrevious.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnPrevious.addTarget(self, action: #selector(btnPreviousClicked), for: .touchUpInside)
        
        scrollView.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.centerYAnchor.constraint(equalTo: lblMonth.centerYAnchor).isActive = true
        btnNext.leadingAnchor.constraint(equalTo: lblMonth.trailingAnchor, constant: 18).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 10).isActive = true
        btnNext.addTarget(self, action: #selector(btnNextClicked), for: .touchUpInside)
        
        
        scrollView.addSubview(overView)
        overView.translatesAutoresizingMaskIntoConstraints = false
        overView.topAnchor.constraint(equalTo: lblMonth.bottomAnchor, constant: 24).isActive = true
        overView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        overView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        overView.heightAnchor.constraint(equalToConstant: 93).isActive = true
        
        overView.layer.borderWidth = 1
        overView.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        overView.layer.cornerRadius = 8
        
        
        scrollView.addSubview(lblworkingDay)
        lblworkingDay.translatesAutoresizingMaskIntoConstraints = false
        lblworkingDay.topAnchor.constraint(equalTo: overView.topAnchor, constant: 23).isActive = true
        lblworkingDay.leadingAnchor.constraint(equalTo: overView.leadingAnchor, constant:25).isActive = true
        lblworkingDay.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblworkingDay.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lbldayOff)
        lbldayOff.translatesAutoresizingMaskIntoConstraints = false
        lbldayOff.translatesAutoresizingMaskIntoConstraints = false
        lbldayOff.topAnchor.constraint(equalTo: overView.topAnchor, constant: 23).isActive = true
        lbldayOff.leadingAnchor.constraint(equalTo: lblworkingDay.trailingAnchor, constant:31).isActive = true
        lbldayOff.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lbldayOff.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblbaseWorkingHour)
        lblbaseWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblbaseWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblbaseWorkingHour.topAnchor.constraint(equalTo: overView.topAnchor, constant: 23).isActive = true
        lblbaseWorkingHour.leadingAnchor.constraint(equalTo: lbldayOff.trailingAnchor, constant:31).isActive = true
        lblbaseWorkingHour.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblbaseWorkingHour.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(lblmaxWorkingHour)
        lblmaxWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblmaxWorkingHour.translatesAutoresizingMaskIntoConstraints = false
        lblmaxWorkingHour.topAnchor.constraint(equalTo: overView.topAnchor, constant: 23).isActive = true
        lblmaxWorkingHour.trailingAnchor.constraint(equalTo: overView.trailingAnchor, constant:-23).isActive = true
        lblmaxWorkingHour.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblmaxWorkingHour.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        scrollView.addSubview(lblworkingDayValue)
        lblworkingDayValue.translatesAutoresizingMaskIntoConstraints = false
        lblworkingDayValue.centerXAnchor.constraint(equalTo: lblworkingDay.centerXAnchor).isActive = true
        lblworkingDayValue.topAnchor.constraint(equalTo: lblworkingDay.bottomAnchor, constant: 3).isActive = true
        
        scrollView.addSubview(lbldayOffValue)
        lbldayOffValue.translatesAutoresizingMaskIntoConstraints = false
        lbldayOffValue.centerXAnchor.constraint(equalTo: lbldayOff.centerXAnchor).isActive = true
        lbldayOffValue.topAnchor.constraint(equalTo: lblworkingDay.bottomAnchor, constant: 3).isActive = true
        
        scrollView.addSubview(lblbaseWorkingHourValue)
        lblbaseWorkingHourValue.translatesAutoresizingMaskIntoConstraints = false
        lblbaseWorkingHourValue.centerXAnchor.constraint(equalTo: lblbaseWorkingHour.centerXAnchor).isActive = true
        lblbaseWorkingHourValue.topAnchor.constraint(equalTo: lblworkingDay.bottomAnchor, constant: 3).isActive = true
        
        scrollView.addSubview(lblmaxWorkingHourValue)
        lblmaxWorkingHourValue.translatesAutoresizingMaskIntoConstraints = false
        lblmaxWorkingHourValue.centerXAnchor.constraint(equalTo: lblmaxWorkingHour.centerXAnchor).isActive = true
        lblmaxWorkingHourValue.topAnchor.constraint(equalTo: lblworkingDay.bottomAnchor, constant: 3).isActive = true
        
        
        scrollView.addSubview(lblDiv)
        lblDiv.translatesAutoresizingMaskIntoConstraints = false
        lblDiv.topAnchor.constraint(equalTo: overView.bottomAnchor, constant: 38).isActive = true
        lblDiv.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        lblDiv.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        
        let divider = UIView()
        scrollView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: lblDiv.bottomAnchor, constant: 38).isActive = true
        divider.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.backgroundColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1)
        
        scrollView.addSubview(ivDivsion)
        ivDivsion.translatesAutoresizingMaskIntoConstraints = false
        ivDivsion.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        ivDivsion.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 38).isActive = true
        ivDivsion.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivDivsion.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivDivsion.isUserInteractionEnabled = true
        let ivDivsionTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivDivsionTapped))
        ivDivsion.addGestureRecognizer(ivDivsionTap)
        
        scrollView.addSubview(lblDivCd)
        lblDivCd.translatesAutoresizingMaskIntoConstraints = false
        lblDivCd.centerYAnchor.constraint(equalTo: ivDivsion.centerYAnchor).isActive = true
        lblDivCd.leadingAnchor.constraint(equalTo: ivDivsion.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(btnDivStart)
        btnDivStart.translatesAutoresizingMaskIntoConstraints = false
        btnDivStart.leadingAnchor.constraint(equalTo: ivDivsion.trailingAnchor, constant: 67).isActive = true
        btnDivStart.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnDivStart.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDivStart.centerYAnchor.constraint(equalTo: ivDivsion.centerYAnchor).isActive = true
        btnDivStart.setTitleColor(.black, for: .normal)
        btnDivStart.isUserInteractionEnabled = false
        btnDivStart.addTarget(self, action: #selector(btnDivStartClicked), for: .touchUpInside)
        
        let divCdView = UIView()
        scrollView.addSubview(divCdView)
        divCdView.translatesAutoresizingMaskIntoConstraints = false
        divCdView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        divCdView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        divCdView.backgroundColor = .black
        divCdView.centerYAnchor.constraint(equalTo: ivDivsion.centerYAnchor).isActive = true
        divCdView.leadingAnchor.constraint(equalTo: btnDivStart.trailingAnchor, constant: 9).isActive = true
        
        scrollView.addSubview(btnDivEnd)
        btnDivEnd.translatesAutoresizingMaskIntoConstraints = false
        btnDivEnd.leadingAnchor.constraint(equalTo: divCdView.trailingAnchor, constant: 9).isActive = true
        btnDivEnd.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnDivEnd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnDivEnd.centerYAnchor.constraint(equalTo: ivDivsion.centerYAnchor).isActive = true
        btnDivEnd.setTitleColor(.black, for: .normal)
        btnDivEnd.isUserInteractionEnabled = false
        btnDivEnd.addTarget(self, action: #selector(btnDivEndClicked), for: .touchUpInside)
        
        scrollView.addSubview(ivTeam)
        ivTeam.translatesAutoresizingMaskIntoConstraints = false
        ivTeam.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        ivTeam.topAnchor.constraint(equalTo: ivDivsion.bottomAnchor, constant: 35).isActive = true
        ivTeam.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivTeam.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivTeam.isUserInteractionEnabled = true
        let ivTeamTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivTeamTapped))
        ivTeam.addGestureRecognizer(ivTeamTap)
        
        scrollView.addSubview(lblTeamCd)
        lblTeamCd.translatesAutoresizingMaskIntoConstraints = false
        lblTeamCd.centerYAnchor.constraint(equalTo: ivTeam.centerYAnchor).isActive = true
        lblTeamCd.leadingAnchor.constraint(equalTo: ivTeam.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(btnTeamStart)
        btnTeamStart.translatesAutoresizingMaskIntoConstraints = false
        btnTeamStart.leadingAnchor.constraint(equalTo: ivTeam.trailingAnchor, constant: 67).isActive = true
        btnTeamStart.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnTeamStart.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnTeamStart.centerYAnchor.constraint(equalTo: ivTeam.centerYAnchor).isActive = true
        btnTeamStart.setTitleColor(.black, for: .normal)
        btnTeamStart.isUserInteractionEnabled = false
        btnTeamStart.addTarget(self, action: #selector(btnDivStartClicked), for: .touchUpInside)
        
        let teamCdView = UIView()
        scrollView.addSubview(teamCdView)
        teamCdView.translatesAutoresizingMaskIntoConstraints = false
        teamCdView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        teamCdView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        teamCdView.backgroundColor = .black
        teamCdView.centerYAnchor.constraint(equalTo: ivTeam.centerYAnchor).isActive = true
        teamCdView.leadingAnchor.constraint(equalTo: btnTeamStart.trailingAnchor, constant: 9).isActive = true
        
        scrollView.addSubview(btnTeamEnd)
        btnTeamEnd.translatesAutoresizingMaskIntoConstraints = false
        btnTeamEnd.leadingAnchor.constraint(equalTo: teamCdView.trailingAnchor, constant: 9).isActive = true
        btnTeamEnd.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnTeamEnd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnTeamEnd.centerYAnchor.constraint(equalTo: ivTeam.centerYAnchor).isActive = true
        btnTeamEnd.setTitleColor(.black, for: .normal)
        btnTeamEnd.isUserInteractionEnabled = false
        btnTeamEnd.addTarget(self, action: #selector(btnDivEndClicked), for: .touchUpInside)
        
        scrollView.addSubview(ivPerson)
        ivPerson.translatesAutoresizingMaskIntoConstraints = false
        ivPerson.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        ivPerson.topAnchor.constraint(equalTo: ivTeam.bottomAnchor, constant: 35).isActive = true
        ivPerson.widthAnchor.constraint(equalToConstant: 24).isActive = true
        ivPerson.heightAnchor.constraint(equalToConstant: 24).isActive = true
        ivPerson.isUserInteractionEnabled = true
        let ivPersonTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ivPersonTapped))
        ivPerson.addGestureRecognizer(ivPersonTap)
        
        scrollView.addSubview(lblPersonCd)
        lblPersonCd.translatesAutoresizingMaskIntoConstraints = false
        lblPersonCd.centerYAnchor.constraint(equalTo: ivPerson.centerYAnchor).isActive = true
        lblPersonCd.leadingAnchor.constraint(equalTo: ivPerson.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(btnPersonStart)
        btnPersonStart.translatesAutoresizingMaskIntoConstraints = false
        btnPersonStart.leadingAnchor.constraint(equalTo: ivPerson.trailingAnchor, constant: 67).isActive = true
        btnPersonStart.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnPersonStart.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnPersonStart.centerYAnchor.constraint(equalTo: ivPerson.centerYAnchor).isActive = true
        btnPersonStart.setTitleColor(.black, for: .normal)
        btnPersonStart.isUserInteractionEnabled = false
        btnPersonStart.addTarget(self, action: #selector(btnPersonStartClicked), for: .touchUpInside)
        
        let personCdView = UIView()
        scrollView.addSubview(personCdView)
        personCdView.translatesAutoresizingMaskIntoConstraints = false
        personCdView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        personCdView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        personCdView.backgroundColor = .black
        personCdView.centerYAnchor.constraint(equalTo: ivPerson.centerYAnchor).isActive = true
        personCdView.leadingAnchor.constraint(equalTo: btnPersonStart.trailingAnchor, constant: 9).isActive = true
        
        scrollView.addSubview(btnPersonEnd)
        btnPersonEnd.translatesAutoresizingMaskIntoConstraints = false
        btnPersonEnd.leadingAnchor.constraint(equalTo: personCdView.trailingAnchor, constant: 9).isActive = true
        btnPersonEnd.widthAnchor.constraint(equalToConstant: 110).isActive = true
        btnPersonEnd.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnPersonEnd.centerYAnchor.constraint(equalTo: ivPerson.centerYAnchor).isActive = true
        btnPersonEnd.setTitleColor(.black, for: .normal)
        btnPersonEnd.isUserInteractionEnabled = false
        btnPersonEnd.addTarget(self, action: #selector(btnPersonEndClicked), for: .touchUpInside)
        
        
        scrollView.addSubview(cbGrade3)
        cbGrade3.translatesAutoresizingMaskIntoConstraints = false
        cbGrade3.topAnchor.constraint(equalTo: ivPerson.bottomAnchor, constant: 37).isActive = true
        cbGrade3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        cbGrade3.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade3.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade3.delegate = self
        cbGrade3.name = "cbGrade3"
        
        scrollView.addSubview(lblGrade3)
        lblGrade3.translatesAutoresizingMaskIntoConstraints = false
        lblGrade3.centerYAnchor.constraint(equalTo: cbGrade3.centerYAnchor).isActive = true
        lblGrade3.leadingAnchor.constraint(equalTo: cbGrade3.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(cbGrade4)
        cbGrade4.translatesAutoresizingMaskIntoConstraints = false
        cbGrade4.topAnchor.constraint(equalTo: ivPerson.bottomAnchor, constant: 37).isActive = true
        cbGrade4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 148).isActive = true
        cbGrade4.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade4.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade4.delegate = self
        cbGrade4.name = "cbGrade4"
        
        scrollView.addSubview(lblGrade4)
        lblGrade4.translatesAutoresizingMaskIntoConstraints = false
        lblGrade4.centerYAnchor.constraint(equalTo: cbGrade4.centerYAnchor).isActive = true
        lblGrade4.leadingAnchor.constraint(equalTo: cbGrade4.trailingAnchor, constant: 8).isActive = true
        
        scrollView.addSubview(cbGrade5)
        cbGrade5.translatesAutoresizingMaskIntoConstraints = false
        cbGrade5.topAnchor.constraint(equalTo: ivPerson.bottomAnchor, constant: 37).isActive = true
        cbGrade5.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 280).isActive = true
        cbGrade5.widthAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade5.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cbGrade5.delegate = self
        cbGrade5.name = "cbGrade5"
        
        scrollView.addSubview(lblGrade5)
        lblGrade5.translatesAutoresizingMaskIntoConstraints = false
        lblGrade5.centerYAnchor.constraint(equalTo: cbGrade5.centerYAnchor).isActive = true
        lblGrade5.leadingAnchor.constraint(equalTo: cbGrade5.trailingAnchor, constant: 8).isActive = true
        
        
        scrollView.addSubview(btnFind)
        btnFind.translatesAutoresizingMaskIntoConstraints = false
        btnFind.topAnchor.constraint(equalTo: cbGrade5.bottomAnchor, constant: 24).isActive = true
        btnFind.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        btnFind.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        btnFind.heightAnchor.constraint(equalToConstant: 51).isActive = true
        btnFind.addTarget(self, action: #selector(btnFindClicked), for: .touchUpInside)
        
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cvWorkPlanResultInfo.collectionViewLayout = cvLayout
        
        cvWorkPlanResultInfo.delegate = self
        cvWorkPlanResultInfo.dataSource = self
        cvWorkPlanResultInfo.backgroundColor = .white
        scrollView.addSubview(cvWorkPlanResultInfo)
        cvWorkPlanResultInfo.translatesAutoresizingMaskIntoConstraints = false
        cvWorkPlanResultInfo.topAnchor.constraint(equalTo: btnFind.bottomAnchor, constant: 32).isActive = true
        cvWorkPlanResultInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        cvWorkPlanResultInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cvWorkPlanResultInfo.register(WorkPlanResultCollectionViewCell.self, forCellWithReuseIdentifier: WorkPlanResultCollectionViewCell.ID)
        cvWorkPlanResultInfo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        cvWorkPlanResultInfoHeightAnchor = cvWorkPlanResultInfo.heightAnchor.constraint(equalToConstant: 51)
        cvWorkPlanResultInfoHeightAnchor?.isActive = true
        
        
        dateFormatter.dateFormat = "yyyy.MM" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        calculation()
        getDivList()
        // Do any additional setup after loading the view.
    }
    
    func onSelectChange(name: String, isSelected: Bool) {
        
    }
    
    func getDateFromDivList(upDetpItem:UpDeptListDetailResponse){
        if let deptNm = upDetpItem.deptNm {
            if selectedSearchDiv == .div {
                if selectedButtonCd == .start {
                    btnDivStart.setTitle(deptNm, for: .normal)
                    selectedStartCd = upDetpItem.deptCd ?? ""
                } else {
                    selectedEndCd = upDetpItem.deptCd ?? ""
                    btnDivEnd.setTitle(deptNm, for: .normal)
                }
            } else if selectedSearchDiv == .team {
                if selectedButtonCd == .start {
                    selectedStartCd = upDetpItem.deptCd ?? ""
                    btnTeamStart.setTitle(deptNm, for: .normal)
                } else {
                    selectedEndCd = upDetpItem.deptCd ?? ""
                    btnTeamEnd.setTitle(deptNm, for: .normal)
                }
            }
        }
    }
    
    func getApproveListFromPopup(approveListItem:UserListDetailResponse){
        if let prsnNm = approveListItem.prsnNm {
            if selectedButtonCd == .start {
                btnPersonStart.setTitle(prsnNm, for: .normal)
            } else {
                btnPersonEnd.setTitle(prsnNm, for: .normal)
            }
        }
    }
    
    @objc func btnDivStartClicked(){
        selectedButtonCd = .start
        let vc = DivListPopupViewController()
        vc.previousViewController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func btnDivEndClicked(){
        selectedButtonCd = .end
        let vc = DivListPopupViewController()
        vc.previousViewController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func btnPersonStartClicked(){
        selectedButtonCd = .start
        let vc = UserPopUpViewController()
        vc.previousViewController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func btnPersonEndClicked(){
        selectedButtonCd = .end
        let vc = UserPopUpViewController()
        vc.previousViewController = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func ivDivsionTapped(){
        selectedSearchDiv = .div
        
        ivDivsion.image = UIImage(named: "radio-selected")
        btnDivStart.backgroundColor = .white
        btnDivStart.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnDivStart.isUserInteractionEnabled = true
        btnDivEnd.backgroundColor = .white
        btnDivEnd.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnDivEnd.isUserInteractionEnabled = true
        
        ivTeam.image = UIImage(named: "radio-unselected")
        btnTeamStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnTeamStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnTeamStart.isUserInteractionEnabled = false
        btnTeamStart.setTitle("", for: .normal)
        btnTeamEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnTeamEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnTeamEnd.isUserInteractionEnabled = false
        btnTeamEnd.setTitle("", for: .normal)
        
        ivPerson.image = UIImage(named: "radio-unselected")
        btnPersonStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnPersonStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnPersonStart.isUserInteractionEnabled = false
        btnPersonStart.setTitle("", for: .normal)
        btnPersonEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnPersonEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnPersonEnd.isUserInteractionEnabled = false
        btnPersonEnd.setTitle("", for: .normal)
    }
    
    @objc func ivTeamTapped(){
        selectedSearchDiv = .team
        ivDivsion.image = UIImage(named: "radio-unselected")
        btnDivStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnDivStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnDivEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnDivEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnDivStart.isUserInteractionEnabled = false
        btnDivEnd.isUserInteractionEnabled = false
        btnDivStart.setTitle("", for: .normal)
        btnDivEnd.setTitle("", for: .normal)
        
        ivTeam.image = UIImage(named: "radio-selected")
        btnTeamStart.backgroundColor = .white
        btnTeamStart.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnTeamEnd.backgroundColor = .white
        btnTeamEnd.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnTeamStart.isUserInteractionEnabled = true
        btnTeamEnd.isUserInteractionEnabled = true
        
        ivPerson.image = UIImage(named: "radio-unselected")
        btnPersonStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnPersonStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnPersonEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnPersonEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnPersonEnd.isUserInteractionEnabled = false
        btnPersonStart.isUserInteractionEnabled = false
        btnPersonStart.setTitle("", for: .normal)
        btnPersonEnd.setTitle("", for: .normal)
        
    }
    @objc func ivPersonTapped(){
        selectedSearchDiv = .person
        ivDivsion.image = UIImage(named: "radio-unselected")
        btnDivStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnDivStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnDivEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnDivEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnDivStart.isUserInteractionEnabled = false
        btnDivEnd.isUserInteractionEnabled = false
        btnDivStart.setTitle("", for: .normal)
        btnDivEnd.setTitle("", for: .normal)
        
        ivTeam.image = UIImage(named: "radio-unselected")
        btnTeamStart.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnTeamStart.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnTeamEnd.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        btnTeamEnd.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
        btnTeamStart.isUserInteractionEnabled = false
        btnTeamEnd.isUserInteractionEnabled = false
        btnTeamStart.setTitle("", for: .normal)
        btnTeamEnd.setTitle("", for: .normal)
        
        ivPerson.image = UIImage(named: "radio-selected")
        btnPersonStart.backgroundColor = .white
        btnPersonStart.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnPersonEnd.backgroundColor = .white
        btnPersonEnd.layer.borderColor = UIColor(red: 0.854, green: 0.854, blue: 0.854, alpha: 1).cgColor
        btnPersonStart.isUserInteractionEnabled = true
        btnPersonEnd.isUserInteractionEnabled = true
    }
    @objc func btnPreviousClicked(){
        components.month = components.month! - 1
        self.calculation()
        
    }
    
    @objc func btnNextClicked(){
        components.month = components.month! + 1
        self.calculation()
    }
    
    func calculation() { // 월 별 일 수 계산
        let firstDayOfMonth = cal.date(from: components)
        self.lblMonth.text = dateFormatter.string(from: firstDayOfMonth!)
        getInfoRead()
        
        var startCd = btnDivStart.titleLabel?.text
        var endCd = btnDivEnd.titleLabel?.text
        if selectedSearchDiv == .team {
            startCd = btnTeamStart.titleLabel?.text
            endCd = btnTeamEnd.titleLabel?.text
        } else if selectedSearchDiv == .person {
            startCd = btnPersonStart.titleLabel?.text
            endCd = btnPersonEnd.titleLabel?.text
        }
        
        if (startCd ?? "").isEmpty {
            return
        }
        if (endCd ?? "").isEmpty {
            return
        }
        
        btnFindClicked()
    }
    
    func getDivList(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        ApiService.request(router: WorkOverApi.divList , success: { (response: ApiResponse<WorkReportReqInfoListResponse>) in
            self.hud.dismiss()
            if let result = response.value {
                if let data = result.data {
                    let defaultDivCd = data.defaultDivCd ?? ""
                    if let list = data.list{
                        self.getdivNmList = list
                        self.divNmList.removeAll()
//                        self.getdivNmList.append("사업부문을 선택하세요".localized)
                        for item in list {
                            self.divNmList.append(item.divNm ?? "")
                        }
                        self.updateDivDropDown(defaultDivCd: defaultDivCd)
                        self.getInfoRead()
                    }
                }
            }
        }) { (error) in
            self.hud.dismiss()
            return
        }
    }
    
    func updateDivDropDown(defaultDivCd: String){
        divNmDropDown = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        divNmDropDown.name = "divNmDropDown"
//        divNmDropDown.stTitle = "내용을 선택하세요".localized
        
        for item in getdivNmList {
            if let subCd = item.divCd {
                if(subCd == defaultDivCd ) {
                    divNmDropDown.stTitle = item.divNm!
                    self.selectedDivCd = item.divCd!
                }
            }
        }
        
        divNmDropDown.delegate = self
        self.divNmDropDown.dropView.dropDownOptions = self.divNmList
        scrollView.addSubview(divNmDropDown)
        divNmDropDown.translatesAutoresizingMaskIntoConstraints = false
        divNmDropDown.centerYAnchor.constraint(equalTo: lblDiv.centerYAnchor).isActive = true
        divNmDropDown.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 93).isActive = true
        divNmDropDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18).isActive = true
        divNmDropDown.heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    func dropDownPressed(name: String, string: String) {
        if name ==  "divNmDropDown" {
            for item in getdivNmList {
                if item.divNm == string {
                    self.selectedDivCd = item.divCd ?? ""
                    getInfoRead()
                }
            }
        }
    }
    
    func getInfoRead(){
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        
        ApiService.request(router: WorkOverApi.infoRead(param: WorkPlanReportInfoReadRequest(yyyymm: yyyymm, divCdParam: selectedDivCd)) , success: { (response: ApiResponse<WorkingInfoResponse>) in
            if let result = response.value {
                if let workingDay = result.data?.workingDay {
                    self.lblworkingDayValue.text = "\(workingDay)"
                }
                if let dayOff = result.data?.dayOff {
                    self.lbldayOffValue.text = "\(dayOff)"
                }
                if let baseWorkingHour = result.data?.baseWorkingHour {
                    self.lblbaseWorkingHourValue.text = "\(baseWorkingHour)"
                }
                if let maxWorkingHour = result.data?.maxWorkingHour {
                    self.lblmaxWorkingHourValue.text = "\(maxWorkingHour)"
                }
            }
//            self.hud.dismiss()
        }) { (error) in
//            self.hud.dismiss()
            return
        }
    }
    
    @objc func btnFindClicked(){
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        
        var searchDiv = "1"
        var startCd = btnDivStart.titleLabel?.text
        var endCd = btnDivEnd.titleLabel?.text
        if selectedSearchDiv == .team {
            searchDiv = "2"
            startCd = btnTeamStart.titleLabel?.text
            endCd = btnTeamEnd.titleLabel?.text
        } else if selectedSearchDiv == .person {
            searchDiv = "3"
            startCd = btnPersonStart.titleLabel?.text
            endCd = btnPersonEnd.titleLabel?.text
        }
        
        if (startCd ?? "").isEmpty {
            var msg = ""
            if selectedSearchDiv == .div {
                msg = "[본부별] 시작부서를 입력하지 않았습니다".localized
            }else if selectedSearchDiv == .team {
                msg = "[부서별] 시작부서를 입력하지 않았습니다".localized
            } else if selectedSearchDiv == .person {
                msg = "[개인별] 시작사번을 입력하지 않았습니다".localized
            }
            let alert  = UIAlertController(title: "알림".localized, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (endCd ?? "").isEmpty {
            var msg = ""
            if selectedSearchDiv == .div {
                msg = "[본부별] 종료부서를 입력하지 않았습니다".localized
            }else if selectedSearchDiv == .team {
                msg = "[부서별] 종료부서를 입력하지 않았습니다".localized
            } else if selectedSearchDiv == .person {
                msg = "[개인별] 종료사번을 입력하지 않았습니다".localized
            }
            let alert  = UIAlertController(title: "알림".localized, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인".localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let grade3 = cbGrade3.isSelected ? "1" : "0"
        let grade4 = cbGrade4.isSelected ? "1" : "0"
        let grade5 = cbGrade5.isSelected ? "1" : "0"
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiService.request(router: WorkOverApi.infoList(param: WorkOverInfoListRequest(yyyymm: yyyymm, divCdParam: selectedDivCd, searchDiv: searchDiv, startCd: selectedStartCd, endCd: selectedEndCd, grade3:grade3, grade4: grade4, grade5: grade5)) , success: { (response: ApiResponse<WorkPlanResultInfoListResponse>) in
            if let result = response.value {
                if let result = response.value?.data {
                    self.WorkPlanResultInfoList = result
                    self.cvWorkPlanResultInfoHeightAnchor?.isActive = false
                    let cvWorkPlanResultInfoHeight = self.WorkPlanResultInfoList.count*51+51
                    self.cvWorkPlanResultInfoHeightAnchor = self.cvWorkPlanResultInfo.heightAnchor.constraint(equalToConstant: CGFloat(cvWorkPlanResultInfoHeight))
                    self.cvWorkPlanResultInfoHeightAnchor?.isActive = true
                    self.cvWorkPlanResultInfo.reloadData()
                }
            }
            self.hud.dismiss()
        }) { (error) in
            self.hud.dismiss()
            return
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


extension WorkOverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return WorkPlanResultInfoList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkPlanResultCollectionViewCell.ID, for: indexPath) as! WorkPlanResultCollectionViewCell
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            cell.lblprsnNm.text = "사원명".localized
            cell.lblmaxWorkingHour.text = "최대근로".localized
            cell.lblworkPlan.text = "계획근로".localized
            cell.lblworkTime.text = "실근로".localized
            cell.lbloverWorkTime.text = "초과근로".localized
            cell.lblworkingGrade.text = "구분".localized
            
        default:
            cell.lblprsnNm.text = WorkPlanResultInfoList[indexPath.row].prsnNm
            if let maxWorkingHour = WorkPlanResultInfoList[indexPath.row].maxWorkingHour {
                if maxWorkingHour == Double(Int(maxWorkingHour)) {
                    cell.lblmaxWorkingHour.text = String(Int(maxWorkingHour))
                }else {
                    cell.lblmaxWorkingHour.text = String(maxWorkingHour)
                }
            }
            if let workPlan = WorkPlanResultInfoList[indexPath.row].workPlan {
                if workPlan == Double(Int(workPlan)) {
                    cell.lblworkPlan.text = String(Int(workPlan))
                }else {
                    cell.lblworkPlan.text = String(workPlan)
                }
            }
            if let workTime = WorkPlanResultInfoList[indexPath.row].workTime {
                if workTime == Double(Int(workTime)) {
                    cell.lblworkTime.text = String(Int(workTime))
                }else {
                    cell.lblworkTime.text = String(workTime)
                }
            }
            if let overWorkTime = WorkPlanResultInfoList[indexPath.row].overWorkTime {
                if overWorkTime == Double(Int(overWorkTime)) {
                    cell.lbloverWorkTime.text = String(Int(overWorkTime))
                }else {
                    cell.lbloverWorkTime.text = String(overWorkTime)
                }
            }
            if let workingGrade = WorkPlanResultInfoList[indexPath.row].workingGrade {
                switch workingGrade {
                case 1:
                    cell.lblworkingGrade.text = "양호".localized
                case 2:
                    cell.lblworkingGrade.text = "경계".localized
                case 3:
                    cell.lblworkingGrade.text = "주의".localized
                case 4:
                    cell.lblworkingGrade.text = "위험".localized
                case 5:
                    cell.lblworkingGrade.text = "법위반".localized
                default:
                    cell.lblworkingGrade.text = "양호".localized
                }
            }
            
            cell.backgroundColor = .white
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print("selected : \(indexPath.row)")
        let vc = WorkPlanResultDetailViewController()
        vc.workPlanResultInfoData = WorkPlanResultInfoList[indexPath.row]
        let firstDayOfMonth = cal.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM" // 월 표시 포맷 설정
        let yyyymm = dateFormatter.string(from: firstDayOfMonth!)
        vc.yyyymm = yyyymm
        vc.viewType = .WorkOver
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width
        //        print("collectionViewSize : \(collectionViewSize)")
        return CGSize(width: collectionViewSize, height: 51)
        
        
    }
}

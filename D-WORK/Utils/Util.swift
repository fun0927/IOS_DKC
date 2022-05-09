//
//  Util.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/18.
//

import Foundation
import UIKit


class Util {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    struct ShortCutContent {
        var editIcon:UIImage?
        var mainIcon:UIImage?
        var title = ""
        var isSelected = false
        var pgmId:String?
        
    }
    func getTitleFromPmgId(getPgmId:String) -> String{
        for item in shorCutArray {
            if let pmgId = item.pgmId, pmgId == getPgmId {
                return item.title ?? ""
            }
        }
        return ""
    }
    let shorCutArray:[ShortCutContent] = [
        ShortCutContent(editIcon: UIImage(named: "editTimer")!, mainIcon: UIImage(named: "mainTimer")!, title: "월별 출퇴근 현황".localized, pgmId: "P0001"),
        ShortCutContent(editIcon: UIImage(named: "edit-chat-dot-round")!, mainIcon: UIImage(named: "main-chat-dot-round")!, title: "사내공지사항".localized, pgmId: "P0002"),
        ShortCutContent(editIcon: UIImage(named: "edit-first-aid-kit")!, mainIcon: UIImage(named: "main-first-aid-kit")!, title: "안전공지사항".localized, pgmId: "P0003"),
        ShortCutContent(editIcon: UIImage(named: "edit-school")!, mainIcon: UIImage(named: "main-school")!, title: "노동조합공지사항".localized, pgmId: "W0001Q"),
        ShortCutContent(editIcon: UIImage(named: "edit-bell")!, mainIcon: UIImage(named: "main-bell")!, title: "알림확인".localized, pgmId: "P0004"),
        ShortCutContent(editIcon: UIImage(named: "edit-files")!, mainIcon: UIImage(named: "main-files")!, title: "설문조사".localized, pgmId: "P0005"),
        ShortCutContent(editIcon: UIImage(named: "edit-date")!, mainIcon: UIImage(named: "main-date")!, title: "근무 계획 등록".localized, pgmId: "W1001A"),
        ShortCutContent(editIcon: UIImage(named: "edit-pie-chart")!, mainIcon: UIImage(named: "main-pie-chart")!, title: "나의 근무 현황".localized, pgmId: "W1002A"),
        ShortCutContent(editIcon: UIImage(named: "edit-folder-checked")!, mainIcon: UIImage(named: "main-folder-checked")!, title: "근무 계획 실적 현황".localized, pgmId: "W1003Q"),
        ShortCutContent(editIcon: UIImage(named: "edit-data-line")!, mainIcon: UIImage(named: "main-data-line")!, title: "월별 초과 근로 현황".localized, pgmId: "W1005Q"),
        ShortCutContent(editIcon: UIImage(named: "edit-data-analysis")!, mainIcon: UIImage(named: "main-data-analysis")!, title: "근무 계획 현황".localized, pgmId: "W1006Q"),
        ShortCutContent(editIcon: UIImage(named: "edit-tickets")!, mainIcon: UIImage(named: "main-tickets")!, title: "전자 결재함".localized, pgmId: "W2001Q"),
        ShortCutContent(editIcon: UIImage(named: "edit-circle-plus-outline")!, mainIcon: UIImage(named: "main-circle-plus-outline")!, title: "확인원 등록".localized, pgmId: "W2002A"),
        ShortCutContent(editIcon: UIImage(named: "edit-document-add")!, mainIcon: UIImage(named: "main-document-add")!, title: "업무 일지 등록".localized, pgmId:"W2003A"),
        ShortCutContent(editIcon: UIImage(named: "edit-edit-outline")!, mainIcon: UIImage(named: "main-edit-outline")!, title: "증명서 발급 신청".localized, pgmId: "W2004A"),
        ShortCutContent(editIcon: UIImage(named: "edit-bank-card")!, mainIcon: UIImage(named: "main-bank-card")!, title: "법인카드 및 접대비 사전신청".localized, pgmId: "W2005A"),
        ShortCutContent(editIcon: UIImage(named: "edit-unlock")!, mainIcon: UIImage(named: "main-unlock")!, title: "권한관리".localized, pgmId: "W6001A"),
        ShortCutContent(editIcon: UIImage(named: "edit-mobile-phone")!, mainIcon: UIImage(named: "main-mobile-phone")!, title: "기기등록 승인".localized, pgmId: "W6002A"),
        ShortCutContent(editIcon: UIImage(named: "edit-finished")!, mainIcon: UIImage(named: "main-finished")!, title: "메시지 설정".localized, pgmId: "W7001A"),
        ShortCutContent(editIcon: UIImage(named: "edit-set-up")!, mainIcon: UIImage(named: "main-set-up")!, title: "출퇴근 정보 관리".localized, pgmId: "W7002A"),
        ShortCutContent(editIcon: UIImage(named: "edit-message")!, mainIcon: UIImage(named: "main-message")!, title: "메시지 발송".localized, pgmId: "W8001A"),
        ShortCutContent(editIcon: UIImage(named: "edit-document-copy")!, mainIcon: UIImage(named: "main-document-copy")!, title: "메시지 발송 이력현황".localized, pgmId: "W8002Q"),
        
        //    ShortCutContent(editIcon: UIImage(named: "edit-date")!, mainIcon: UIImage(named: "main-date")!, title: "근무 현황 조회".localized, pgmId: "W10012"),
        //    ShortCutContent(editIcon: UIImage(named: "edit-chat-dot-round")!, mainIcon: UIImage(named: "main-chat-dot-round")!, title: "사내 공지사항"),
        //    ShortCutContent(editIcon: UIImage(named: "edit-finished")!, mainIcon: UIImage(named: "main-finished")!, title: "노동조합공지사항", pgmId: "W0001Q"),
        
        //    ShortCutContent(editIcon: UIImage(named: "edit-finished")!, mainIcon: UIImage(named: "setting")!, title: "개인정보 변경 신청", pgmId: "")
        
    ]
    
    func getToday(format:String) -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = format
        let stDate = dateFormatter.string(from: date)
        return stDate
    }
    
    func getViewControllerFromText(label:String) -> UIViewController? {
        var vc:UIViewController?
        switch label {
        case "나의 근무 현황".localized:
            vc = MyWorkingListViewController()
        case "근무 계획 등록".localized:
            vc = WorkingPlanViewController()
        case "근무 계획 등록 상세".localized:
            vc = WorkingPlanRegisterViewController()
            
        case "확인원 등록".localized:
            vc = CheckListViewController()
        case "확인원 등록 상세".localized:
            vc = CheckerAddViewController()
        case "사용자 결재선".localized:
            vc = ApprovalListViewController()
        case "전자 결재함".localized:
            vc = ApprovalCountReadViewController()
            
        case "결재대기함".localized:
            vc = ApprovalWaitListViewController()
        case "결재대기함 인사".localized:
            vc = HumanListViewController()
        case "결재진행함".localized:
            vc = ApprovalWaitListViewController()
        case "완료문서함".localized:
            vc = ApprovalWaitListViewController()
        case "반려문서함".localized:
            vc = ApprovalWaitListViewController()
        case "결재요청함".localized:
            vc = ApprovalWaitListViewController()
        case "전자 결재함 상세".localized:
            vc = ApprovalWaitDetailViewController()
        case "업무 일지 등록".localized:
            vc = WorkReportListViewController()
        case "업무 일지 등록 상세".localized:
            vc = WorkReportRegisterViewController()
        case "월별 출퇴근 현황".localized :
            vc = WorkMonthListViewController()
        case "근무 계획 현황".localized :
            vc = WorkPlanReportViewController()
        case "근무 계획 실적 현황".localized:
            vc = WorkPlanResultViewController()
        case "월별 초과 근로 현황".localized:
            vc = WorkOverViewController()
        case "증명서 발급 신청".localized:
            vc = CertificateViewController()
        case "증명서 발급 신청 상세".localized:
            vc = CertificateAddViewController()
        case "법인카드 및 접대비 사전신청".localized:
            vc  = CardViewController()
        case "법인카드 및 접대비 사전신청 상세".localized:
            vc  = CardAddViewController()
        case "사내공지사항".localized:
            vc  = NoticeListViewController()
            
        case "안전공지사항".localized:
            vc  = NoticeListViewController()
            
        case "노동조합공지사항".localized:
            vc  = NoticeListViewController()
        case "설문조사".localized:
            vc  = SurveyViewController()
        case "메시지 발송".localized:
            vc  = MessageViewController()
        case "메시지 발송 이력현황".localized:
            vc  = SendHistViewController()
        case "알림확인".localized:
            vc = RecvHistViewController()
            
        case "권한관리".localized:
            vc = AuthViewController()
        case "기기등록 승인".localized:
            vc = RegistApprovalViewController()
            
        case "메시지 설정".localized:
            vc = MessageConfigViewController()
        case "출퇴근 정보 관리".localized:
            vc = GpsConfigViewController()
        case "개인정보 변경 신청".localized:
            vc = UserInfoUpdateViewController()
        default:
            print("")
            
        }
        return vc
        
    }
    
    func getWeekDayFromNum(num:Int) -> String{
        var array = ["일".localized,"월".localized, "화".localized,"수".localized,"목".localized,"금".localized,"토".localized]
        return array[num-1]
        
    }
    
    
    func calPlanTimeMinutes(stDate:Date, endDate:Date, period:Int) -> Int{
        let elapsedTime = endDate.timeIntervalSince(stDate)
        // convert from seconds to hours, rounding down to the nearest hour
        let minues = floor(elapsedTime / 60 )
        return Int(minues)*period
    }
    func fnCalcFureHHMM2Min(time:String) -> Int {
        let comeTimeHour = Int(time.prefix(2)) ?? 0
        let comeTimeMin = Int(time.suffix(2)) ?? 0
        print("time : \(time)")
        
        return comeTimeHour * 60 + comeTimeMin
    }
    
    func fnCalcMin2HHMM(getMin: Int)->String{
        var min = getMin
        if  min > 1440 {
            min -= 1440
        }
        let h = min / 60
        let m = min % 60
        var timeSt = ""
        if String(h).count == 1 {
            timeSt += "0\(h)"
        } else {
            timeSt += "\(h)"
        }
        if String(m).count == 1 {
            timeSt += "0\(m)"
        } else {
            timeSt += "\(m)"
        }
        return timeSt
    }
    
    func fnCalcHHMM2Min(str:String, getComeTime:Int?)->Int{
        //        if (!comeTime) ct = 450; //출근시간을 입력하지 않은 경우 제일 빠른 출근 시간인 0730 으로 계산
        let ct = getComeTime ?? 450
        print("fnCalcHHMM2Min ct : \(ct)")
        var min = fnCalcFureHHMM2Min(time: str); //HHMM 을 분으로 변환
        print("fnCalcHHMM2Min min : \(min)")
        if (min < ct) { //출근시간보다 빠른 시간의 경우 24시간(1440분) 더해서 다음날로 계산
            min += 1440;
        }
        print("fnCalcHHMM2Min min2 : \(min)")
        return min;
    }
    
    func fnCalcMinToHdotM(min:Int) -> Double {
        var rest = min % 60
        print("rest : \(rest)")
        var result = Double(rest)/60
        print("result : \(result)")
        let stDot = String(format: "%.1f", result)
        print("fnCalcMinToHdotM stDot : \(stDot)")
        
        return Double(min / 60) + (Double(stDot) ?? 0.0)
    }
    
    // string로 받아온 dt를 Date로 바꾸어 줍니다
    func convertingUTCtime(_ dt: String) -> Date {
        let timeInterval = TimeInterval(dt)!
        let utcTime = Date(timeIntervalSince1970: timeInterval)
        return utcTime
    }
    
    func getApprovalUserType(type:String) -> String {
        switch type {
        case "Approval":
            return "결재".localized
        case "Draft":
            return "기안".localized
        case "Agree":
            return "합의".localized
        case "Manage1":
            return "관리처".localized
        case "Manage2":
            return "관리처".localized
        default:
            return "결재".localized
        }
    }
    
}

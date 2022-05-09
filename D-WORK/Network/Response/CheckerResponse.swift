//
//  CheckerResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation

struct CheckerMasterListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerMasterListDetailResponse]?
}

struct CheckerMasterListDetailResponse: Codable {
    var makeDate:String?
    var dutyCode:String? // MainCd: HT016_ATS
    var dutyCodeNm:String?
    var stedDate:String?
    var apprState:String?
    var apprStateNm:String?
    var divCd:String?
    var orderNum:String?
    var custNm:String?
    var orderNm:String?
    var reason:String?
    var dutyDays:Double?
    var remark:String?
    var startDate:String?
    var startTime:String?
    var endDate:String?
    var endTime:String?
    var nationCd:String?
    var exitCd:String?
    var eduOrg:String?
    var msgCd:String?
    var modifiedYn:String?
    var seq:Double?
    var erpStatus:String?
    var useDate:String?
}

struct CheckerDetailInfoResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:CheckerDetailInfoDetailResponse?
}

struct CheckerDetailInfoDetailResponse: Codable {
    var isClose:Bool?
    var defaultDivCd:String?
    var list:[CheckerDetailInfoDetailListResponse]?
}
struct CheckerDetailInfoDetailListResponse: Codable {
    var divCd:String?
    var divNm:String?
}



struct CheckerOrderListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerOrderListDetailResponse]?
}
struct CheckerOrderListDetailResponse: Codable {
    var orderNum:String?
    var customNm:String?
    var orderNm:String?
}



struct CheckerCheckDupResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:CheckerCheckDupDetailResponse?
}
struct CheckerCheckDupDetailResponse: Codable {
    var afst22:String?
    var noem22:String?
}

struct CheckerAttendanceReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:CheckerAttendanceReadDetailResponse?
}
struct CheckerAttendanceReadDetailResponse: Codable {
    var comeTime:String?
    var leaveTime:String?
}


struct CheckerWorkReportListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerWorkReportListDetailResponse]?
}
struct CheckerWorkReportListDetailResponse: Codable {
    var dtata4:String?
    var noema4:String?
}


struct CheckerCalendarReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:CheckerCalendarReadDetailResponse?
}
struct CheckerCalendarReadDetailResponse: Codable {
    var idco95:String?
    var dtan95:String?
}

struct CheckerCalendarHolidayMResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerCalendarHolidayMDetailResponse]?
}
struct CheckerCalendarHolidayMDetailResponse: Codable {
    var cnt:Int?
}

struct CheckerCheckWorkTimeResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerCheckWorkTimeDetailResponse]?
}
struct CheckerCheckWorkTimeDetailResponse: Codable {
    var gTime:String?
}


struct CheckerGetHolidayResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerGetHolidayDetailResponse]?
}
struct CheckerGetHolidayDetailResponse: Codable {
    var jusa96:Int?
    var eusa96:Int?
    var jusb96:Int?
    var eusb96:Int?
    var blus96:Int?
}


struct CheckerGetYearHolidayResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerGetYearHolidayDetailResponse]?
}
struct CheckerGetYearHolidayDetailResponse: Codable {
    var cnps96:Int?
}


struct CheckerGetMHolidayResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerGetMHolidayDetailResponse]?
}
struct CheckerGetMHolidayDetailResponse: Codable {
    var cnps96:Int?
    var date01: String?
}

struct CheckerDayCountResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CheckerDayCountDetailResponse]?
}
struct CheckerDayCountDetailResponse: Codable {
    var rsCnt:Int?
}



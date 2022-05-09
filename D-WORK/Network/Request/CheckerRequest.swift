//
//  CheckerRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation


struct CheckerMasterListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
    
}

struct CheckerDetailInfoRequest: Codable {
    var startDate: String // yyyymmdd
}

struct CheckerUpdateRequest: Codable {
    var makeDate: String // yyyymmdd
    var dutyCode:String
    var divCdParam:String
    var nationCd:String
    var exitCd:String
    var eduOrg:String?
    var orderNum:String?
    var reason:String?
    var startDate:String
    var startTime:String
    var endDate:String
    var endTime:String
    var dutyDays:String?
    var remark:String?
    var apprState:String
    var msgCd:String?
    var seq:Int?
    var refSeq:Int?
    var useDate:String?
}

struct CheckerOrderListRequest: Codable {
    var ordDateFr: String?
    var ordDateTo: String?
    var customNm: String?
    var orderNm: String?
}

struct CheckerDeleteRequest: Codable {
    var seq:Int?
    var makeDate: String // yyyymmdd
    var dutyCode:String
}

struct CheckerDraftRequest: Codable {
    var seq: String
    var dutyCode: String
    var divCdParam: String
    var dutyDay: String
    var approvalId: String
    var refSeq: String
}

struct CheckerDraftCancelRequest: Codable {
    var msgCd: String
}

struct CheckerApprovalCancelRequest: Codable {
    var seq: String
    var dutyCode: String
    var divCdParam: String
    var dutyDay: String
    var approvalId: String
}



struct CheckerCheckRequest: Codable {
    var dutyDay: String?
    var dutyCode: String?
    var startDate:String?
    var endDate:String?
    var orgStartDate:String?
    var orgEndDate:String?
}
//
//
//struct CheckerCheckDupRequest: Codable {
//    var dutyCode: String
//    var startDate:String
//    var endDate:String
//    var orgStartDate:String
//    var ortEndDate:String
//}
//
//struct CheckerDutyDayRequest: Codable {
//    var dutyDay: String
//}
//
//struct CheckerStartEndRequest: Codable {
//    var startDate:String
//    var endDate:String
//}

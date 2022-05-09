//
//  WorkReportResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import Foundation


struct WorkReportListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:WorkReportData?
}

struct WorkReportData:Codable{
    var isClose:Bool?
    var list:[WorkReportListDetailResponse]?
}

struct WorkReportListDetailResponse: Codable {
    var ddate:String?
    var cdtx95:String?
    var comeDay:String? // N: 평일, E: 기타, S: 토요일, H: 휴일, M: 명절
    var comeTime:String?
    var leaveDay:String?
    var leaveTime:String?
    var afsta3Nm:String?
    var cdat21Nm1:String?
    var cdat21Nm2:String?
    var cdat21Nm3:String?
    var cdat21Nm4:String?
    var cdat21Nm5:String?
    var cdat21Nm6:String?
    var afsta3:String?
    var msgCd:String?
    var dtan95:String?
    var dtnm95:String?
}

struct WorkReportRestReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkReportRestReadDetailResponse]?
}
struct WorkReportRestReadDetailResponse: Codable {
    var stTLs:String?
    var stTLe:String?
    var stTDs:String?
    var stTDe:String?
    var stTBs:String?
    var stTBe:String?
    var stTNs:String?
    var stTNe:String?
    var stTMs:String?
    var stTMe:String?
    var stTLs1:String?
    var stTLe1:String?
    var stTDs1:String?
    var stTDe1:String?
    var stTBs1:String?
    var stTBe1:String?
    var stTNs1:String?
    var stTNe1:String?
    var stTMs1:String?
    var stTMe1:String?
}

struct WorkReportDetailListResponse: Codable {
    var status:Bool?
    var code:Int?
//    var data:[WorkReportDetailListDetailResponse]?
    var data:[WorkReportUpdateList]? // request 항목과 데이터가 동일
}
struct WorkReportDetailListDetailResponse: Codable {
    var divcd4:String?
    var upcda4:String? // N: 평일, E: 기타, S: 토요일, H: 휴일, M: 명절
    var npnoa4:String?
    var cdaca4:String?
    var remka4:String?
    var timeSt:String?
    var timeEn:String?
    var uphma4:String?
    
}


struct WorkReportReqInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:ReqInfoData?
}

struct ReqInfoData:Codable{
    var defaultDivCd:String?
    var list:[WorkReportReqInfoListDetailResponse]?
}


struct WorkReportReqInfoListDetailResponse: Codable {
    var divCd:String?
    var divNm:String?
}



struct WorkReportworkNoAListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkReportworkNoAListDetailResponse]?
}
struct WorkReportworkNoAListDetailResponse: Codable {
    var csNum:String?
    var customNm:String?
    var ordNm:String?
    var orderNum:String?
    var orderNm:String?
}


struct WorkReportworkNoZListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkReportworkNoZListDetailResponse]?
}
struct WorkReportworkNoZListDetailResponse: Codable {
    var vlCd:String?
    var vlNm:String?
    
    
}
    

struct BudgetListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[BudgetListDetailResponse]?
}
struct BudgetListDetailResponse: Codable {
    var divNm:String?
    var bgCd:String?
    var bgNm:String?
    
    
}
    

//
//  WorkPlanReportResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/10.
//

import Foundation


struct WorkPlanReportInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkPlanReportInfoListData]?
}

struct WorkPlanReportInfoListData:Codable{
    var yyyymm:String?
    var prsnCd:String?
    var divCd:String?
    var prsnNm:String?
    var wPlan:Double?
    var breakPlan:Double?
    var tripPlan:Double?
    var etcPlan:Double?
    var saveYn:String?
    var chkYn:String?
    var div:String?
}
struct WorkPlanReportDetailListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkPlanReportDetailListData]?
}

struct WorkPlanReportDetailListData:Codable{
    var yyyymmdd:String?
    var week:String?
    var workTime:Double?
    var comeTime:String?
    var leaveTime:String?
    var cdat1:String?
    var cdat2:String?
    var cdat3:String?
    var stat:String?
    
}

//
//  WorkPlanResultResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/16.
//

import Foundation


struct WorkPlanResultInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkPlanResultInfoListData]?
}

struct WorkPlanResultInfoListData:Codable{
    var divCd:String?
    var prsnCd:String?
    var prsnNm:String?
    var maxWorkingHour:Double?
    var workPlan:Double?
    var workTime:Double?
    var overWorkTime:Double?
    var workingGrade:Double?
    
}

struct WorkPlanResultDetailListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkPlanResultDetailListData]?
}

struct WorkPlanResultDetailListData:Codable{
    var yyyymmdd:String?
    var week:String?
    var comeLeaveTimePlan:String?
    var workTimePlan:Double?
    var cdat21Plan:String?
    var cdat22Plan:String?
    var comeLeaveTime:String?
    var workTime:Double?
    var cdat21:String?
    var cdat22:String?
}


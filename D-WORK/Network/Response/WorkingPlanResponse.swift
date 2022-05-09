//
//  WorkingPlanResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import Foundation

struct WorkingPlanListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkingPlanDetailListResponse]?
}


struct WorkingPlanDetailListResponse: Codable {
    var yyyymmdd:String?
    var week:String? // N: 평일, E: 기타, S: 토요일, H: 휴일, M: 명절
    var comeTime:String?
    var leaveTime:String?
    var workTime:Double?
    var cdat1:String?
    var cdat2:String?
    var cdat3:String?
    var stat:String?
}
struct WorkingPlanRestReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:WorkingPlanRestReadDetailResponse?
}


struct WorkingPlanRestReadDetailResponse: Codable {
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
    var stbm23:String?
    var enbm23:String?
    var stba23:String?
    var enba23:String?    
    
}

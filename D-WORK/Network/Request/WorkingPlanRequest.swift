//
//  WorkingPlanRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import Foundation

struct WorkingPlanRequest: Codable {
    var yyyymm: String 
    
}

struct WorkingPlanUpdateRequest: Codable {
    var yyyymm: String
    var list:[WorkingPlanUpdateListRequest]
    
}

struct WorkingPlanUpdateListRequest: Codable {
    var yyyymmdd: String
    var comeTime:String
    var leaveTime:String
    var workTime:String
    var cdat1:String
    var cdat2:String
    var cdat3:String
    
}

//
//  WorkingResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import Foundation
struct WorkingReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:WorkingReadDetailResponse?
}


struct WorkingReadDetailResponse: Codable {
    var etcWorkingHour:Double?
    var baseWorkingHour:Double?
    var addWorkingHour:Double?
    var maxWorkingHour:Double?
    var workingHour:Double?
    var workingGrade:Int? // 1: 양호, 2: 경계, 3: 주의, 4: 위험, 5: 법위반
}



struct WorkingListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[WorkingListDetailResponse]?
}


struct WorkingListDetailResponse: Codable {
    var dtan95:String?
    var cdat21:String?
    var wPlan:Double?
    var uphma3:Double?
    var cdtx95:String?
}



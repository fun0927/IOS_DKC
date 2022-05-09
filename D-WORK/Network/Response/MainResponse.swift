//
//  MainResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import Foundation



struct WorkingInfoResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:WorkingInfoDetailResponse?
}


struct WorkingInfoDetailResponse: Codable {
    var workingDay:Int?
    var dayOff:Int?
    var baseWorkingHour:Int?
    var addWorkingHour:Int?
    var maxWorkingHour:Int?
    var workingHour:Int?
    var etcWorkingHour:Int?
    var workingGrade:Int? // 1: 양호, 2: 경계, 3: 주의, 4: 위험, 5: 법위반
    var workingGrade1:Int?
    var workingGrade2:Int?
    var workingGrade3:Int?
    var workingGrade4:Int?
    
}



struct ManageInfoResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:ManageInfoDetailResponse?
}


struct ManageInfoDetailResponse: Codable {
    var workingDay:Int?
    var dayOff:Int?
    var baseWorkingHour:Int?
    var addWorkingHour:Int?
    var maxWorkingHour:Int?
    var grade1:Int? 
    var grade2:Int?
    var grade3:Int?
    var grade4:Int?
    var grade5:Int?
    
}

struct MenuAuthResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[MenuAuthDetailResponse]?
}


struct MenuAuthDetailResponse: Codable {
    var pgmId:String?
    var auth:String?
    
}

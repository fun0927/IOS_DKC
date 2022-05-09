//
//  InOutResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation


struct InOutReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:InOutReadDetailResponse?
}


struct InOutReadDetailResponse: Codable {
    var comeTime:String?
    var leaveTime:String?
    var isLate:Int?
    var isEarly:Int?
    var gpsYn:String?
    
}

struct InOutCoordListRespnose: Codable {
    var status:Bool?
    var code:Int?
    var data:[InOutCoordListDetailRespnose]?
}


struct InOutCoordListDetailRespnose: Codable {
    var areaCd:String?
    var areaNm:String?
    var lttd:String?
    var lngt:String?
    var range:String?     // m
}

struct InOutInsertRespnose: Codable {
    var status:Bool?
    var code:Int?
    var data:InOutReadDetailResponse?
}


//struct InOutInsertDetailRespnose: Codable {
//    var comeTime:String?
//    var leaveTime:String?
//    var isLate:Int?
//    var isEarly:Int?
//    var gpsYn:String?     // m
//}

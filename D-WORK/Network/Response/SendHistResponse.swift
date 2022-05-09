//
//  SendHistResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/14.
//

import Foundation
struct SendHistInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[SendHistInfoListResponseData]?
}


struct SendHistInfoListResponseData: Codable {
    var sendGroup:Int?
    var ttlKr:String?
    var bdKr:String?
    var ttlJpn:String?
    var bdJpn:String?
    var sendPrsnCd:String?
    var sendPrsnNm:String?
    var sendDtm:String?
    var readYn:String?
}
struct SendHistRecvListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[SendHistRecvListResponseData]?
}


struct SendHistRecvListResponseData: Codable {
    var deptNm:String?
    var prsnNm:String?
    
}

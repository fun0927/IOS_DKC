//
//  CardResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import Foundation

struct CardInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CardInfoListData]?
}

struct CardInfoListData:Codable{
    var divCd:String?
    var reqDate:String?
    var seq:String?
    var reqDiv:String?
    var useDate:String?
    var attPer:String?
    var usePlace:String?
    var exPur:String?
    var foreAmtNum:String?
    var returnDate:String?
    var custNm:String?
    var statCd:String?
    var stat:String?
    var msgCd:String?
    var appYn:String?
}

struct CardInfoUpdateResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:Double?
}


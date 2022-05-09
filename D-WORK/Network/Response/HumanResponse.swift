//
//  HumanResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/29.
//

import Foundation

struct HumanInfoCntdResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:HumanInfoCntdResponseData?
}


struct HumanInfoCntdResponseData: Codable {
    var undecidedCnt:Double?
    var auth:String?
    
}

struct HumanInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[HumanInfoListResponseData]?
}


struct HumanInfoListResponseData: Codable {
    var chek04:String?
    var divCd:String?
    var divNm:String?
    var dtfr04:String?
    var cdbr04:String?
    var prsnCd:String?
    var prsnNm:String?
    var yybr04:String?
    var nobr04:String?
    var sqbr04:String?
    var isSelected:Bool?
}

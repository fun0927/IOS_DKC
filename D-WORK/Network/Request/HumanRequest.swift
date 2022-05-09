//
//  HumanRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/29.
//

import Foundation


struct HumanInfoListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
    var chek04: String
    var cdbr04: String
    
    
}


struct HumanInfoUpdateRequest: Codable {
    var chek04:String
    var list: [HumanInfoUpdateRequestList]
}
struct HumanInfoUpdateRequestList: Codable {
    var divCdParam: String
    var yybr04: String
    var nobr04:String
    var sqbr04:String
    var prsnCdParam:String
    var cdbr04:String
    var dtfr04:String
    
}

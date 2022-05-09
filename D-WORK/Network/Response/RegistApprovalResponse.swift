//
//  RegistApprovalResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation

struct RegistApprovalInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[RegistApprovalInfoListResponseData]?
}


struct RegistApprovalInfoListResponseData: Codable {
    var reqDate:String?
    var prsnCd:String?
    var prsnNm:String?
    var os:String?
    var uuid:String?
    var stat:String?
    var isSelected:Bool?
    
}

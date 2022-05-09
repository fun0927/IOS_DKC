//
//  RegistApprovalRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation


struct RegistApprovalInfoListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
    var stat:String //Y, N
}

struct RegistApprovalInfoUpdateRequest: Codable {
    var list: [RegistApprovalInfoUpdateRequestList]
}
struct RegistApprovalInfoUpdateRequestList: Codable {
    var prsnCdParam: String
    var reqDate: String
    var uuid:String
    var stat:String
}


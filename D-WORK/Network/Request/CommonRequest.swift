//
//  CommonRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation

struct CommonRequest: Codable {
    var mainCd: String
    
}

struct UserListRequest: Codable {
    var prsnCdParam: String
    var prsnNmParam: String
    
}

struct UpDeptListRequest: Codable {
    var divCdParam: String
    
}

struct pushTokenUpdateRequest: Codable {
    var pushToken: String
    
}

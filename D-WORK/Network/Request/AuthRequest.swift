//
//  AuthRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/20.
//

import Foundation

struct AuthInfoReadRequest: Codable {
    var prsnCdParam: String
}

struct AuthInfoDeleteRequest: Codable {
    var list: [AuthInfoDeleteRequestList]
}
struct AuthInfoDeleteRequestList: Codable {
    var prsnCdParam: String
    var pgmId: String
}


struct AuthInfoUpdateRequest: Codable {
    var prsnCdParam: String
    var actPermission: String
    var divPermission:String
    var divCd1:String
    var divCd2:String
    var divCd3:String
    var divCd4:String
    var list: [AuthInfoUpdateRequestList]
}

struct AuthInfoUpdateRequestList: Codable {
    var pgmId: String
}

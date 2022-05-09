//
//  RegistRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation

struct RegistRequest: Codable {
    var prsnCd: String // 사번
    var pwd: String
    var model: String
    var os: String
    var uuid:String
    var pushToken:String // Firebase Cloud Messaging API 
}

 

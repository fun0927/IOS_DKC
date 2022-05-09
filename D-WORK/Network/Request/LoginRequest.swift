//
//  loginRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation

struct LoginRequest: Codable {
    var prsnCd: String // 사번
    var pwd: String
    var uuid: String
    
}

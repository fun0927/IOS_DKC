//
//  InOutRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation

struct InOutInsertRequest: Codable {
    var inOut: String // 1: 출근, 2: 퇴근
    var reason: String?
    var lttd: String?
    var lngt:String?
    
    
}

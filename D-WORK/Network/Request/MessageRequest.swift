//
//  MessageRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/19.
//

import Foundation

struct MessageInfoUpdateRequest: Codable {
    var type: String
    var ttlKr: String
    var bdKr:String
    var ttlJpn:String
    var bdJpn:String
    var list:[MessageInfoUpdateRequestList]
}
struct MessageInfoUpdateRequestList: Codable {
    var recvType: String
    var recvCd: String
    
}

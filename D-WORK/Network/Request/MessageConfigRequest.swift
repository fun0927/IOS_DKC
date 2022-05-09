//
//  MessageConfigRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation


struct MessageConfigInfoUpdateRequest: Codable {
    var list: [MessageConfigInfoUpdateRequestList]
}
struct MessageConfigInfoUpdateRequestList: Codable {
    var pshTp: String
    var sndDt: String
    var sndTm:String
    var hlYn:String
    var useYn:String
}


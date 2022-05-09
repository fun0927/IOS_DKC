//
//  GpsConfigRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation


struct GpsConfigUseYnUpdateRequest: Codable {
    var list: [GpsConfigUseYnUpdateRequestList]
}
struct GpsConfigUseYnUpdateRequestList: Codable {
    var areaCd: String
    var useYn:String
}

struct GpsConfigInfoUpdateRequest: Codable {
    var list: [GpsConfigInfoUpdateRequestList]
}
struct GpsConfigInfoUpdateRequestList: Codable {
    var areaCd: String
    var areaNm:String
    var lttd:String
    var lngt:String
    var range:String
}


//
//  GpsConfigResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation

struct GpsConfigInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[GpsConfigInfoListResponseData]?
}


struct GpsConfigInfoListResponseData: Codable {
    var areaCd:String?
    var areaNm:String?
    var lttd:String?
    var lngt:String?
    var range:String?
    var useYn:String?
    var isUseYnSeleced:Bool?
}

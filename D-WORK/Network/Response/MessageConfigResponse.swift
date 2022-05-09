//
//  MessageConfigResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation

struct MessageConfigInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[MessageConfigInfoListResponseData]?
}


struct MessageConfigInfoListResponseData: Codable {
    var pshDiv:String?
    var pshTitle:String?
    var pshTp:String?
    var sndDt:String?
    var sndDtYn:String?
    var sndTm:String?
    var sndTmYn:String?
    var hlYn:String?
    var isHlYnSeleced:Bool?
    var useYn:String?
    var isUseYnSeleced:Bool?
    
}

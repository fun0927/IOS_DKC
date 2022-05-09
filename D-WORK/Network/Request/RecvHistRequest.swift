//
//  RecvHistRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import Foundation


struct RecvHistInfoListRequest: Codable {
    var type: String
    var searchTxt: String
    var rows:String
    var page:String
}

struct RecvHistInfoUpdateRequest: Codable {
    var sndGrp: String
}

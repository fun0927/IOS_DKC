//
//  NoticeRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import Foundation

struct NoticeInfoCountRequest: Codable {
    var dvs: String
    var searchDvs: String
    var searchTxt:String
}

struct NoticeInfoListRequest: Codable {
    var dvs: String
    var searchDvs: String
    var searchTxt:String
    var rows: String
    var page: String
}

struct NoticeInfoDetailRequest: Codable {
    var dvs: String
    var dataNo: String
    
    
}

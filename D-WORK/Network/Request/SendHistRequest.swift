//
//  SendHistRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/14.
//

import Foundation
struct SendHistInfoListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
    var type: String
    var rows: String
    var page: String
}
struct SendHistRecvListRequest: Codable {
    var sendGroup: String
}

//
//  WorkOverRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/16.
//

import Foundation




struct WorkOverInfoListRequest: Codable {
    var yyyymm: String
    var divCdParam: String
    var searchDiv: String // 1, 2, 3
    var startCd: String
    var endCd: String
    var grade3:String
    var grade4:String
    var grade5:String
}

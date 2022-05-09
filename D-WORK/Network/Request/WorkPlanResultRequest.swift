//
//  WorkPlanResultRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/17.
//

import Foundation


struct WorkPlanResultInfoListRequest: Codable {
    var yyyymm: String
    var divCdParam: String
    var prsnCdParam: String
}

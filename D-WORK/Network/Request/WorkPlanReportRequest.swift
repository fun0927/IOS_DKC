//
//  WorkPlanReportRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/10.
//

import Foundation


struct WorkPlanReportInfoReadRequest: Codable {
    var yyyymm: String
    var divCdParam: String
}



struct WorkPlanReportInfoListRequest: Codable {
    var yyyymm: String
    var divCdParam: String
    var searchDiv: String // 1, 2, 3
    var startCd: String
    var endCd: String
    
}
struct WorkingPlanReportUpdateRequest: Codable {
    var yyyymm: String
    var prsnCdParam: String
    var list:[WorkingPlanUpdateListRequest]
    
}


struct WorkingPlanReportChkUpdateRequest: Codable {
    var yyyymm: String
    var divCdParam: String
    var prsnCdParam: String
    var chkYn: String
}

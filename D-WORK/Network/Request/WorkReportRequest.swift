//
//  WorkReportRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import Foundation

struct WorkReportDetailRequest: Codable {
    var yyyymmdd: String
    
}

struct WorkReportworkNoAListRequest: Codable {
    var ordDateFr: String?
    var ordDateTo: String?
    var customNm: String?
    var ordNm: String?
    var orderNm: String?
}

struct WorkReportworkBudgetListRequest: Codable {
    var divCd: String?
    var bgFg: String?
    var procCd: String?
    var bgCd: String?
    var bgNm: String?
    
}

struct WorkReportUpdateRequest: Codable {
    var yyyymmdd: String?
    var uphma3: String?
    var list: [WorkReportUpdateList]?
    
}
struct WorkReportUpdateList: Codable {
    var divcd4: String?
    var upcda4: String?
    var npnoa4: String?
    var cdaca4: String?
    var remka4: String?
    var timeSt: String?
    var timeEn: String?
    var uphma4: String?
    var isSelected:Bool? = false
}

struct WorkReportDraftCancelRequest: Codable {
    var msgCd: String
}

struct WorkReportDraftRequest: Codable {
    var yyyymmdd: String
    var approvalId: String
}

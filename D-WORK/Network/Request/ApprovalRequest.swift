//
//  ApprovalRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/27.
//

import Foundation

struct ApprovalWaitListRequest: Codable {
    var startDate: String
    var endDate: String
    
    
}


struct ApprovalCompleteRequest: Codable {
    var startDate: String
    var endDate: String
    var rows: String
    var page: String
    
    
}

struct ApprovalLineListRequest: Codable {
    var msgCd: String
    
}
struct ApprovalRequest:Codable{
    var msgCd:String
    var seqNo:String
    var type:String // 1: 결재, 2: 반려, 3: 전결
}

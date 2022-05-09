//
//  ApprovalResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation
struct ApproveCountReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:ApproveCountReadDetailResponse?
}


struct ApproveCountReadDetailResponse: Codable {
    var undecidedCnt:Int?
    var progressCnt:Int?
    var undecidedFfCnt:Int?
    
}

struct ApproveCompleteCountResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:ApproveCompleteCountDetailResponse?
}
struct ApproveCompleteCountDetailResponse: Codable {
    var cnt:Int?
}

struct ApproveWaitListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[ApproveWaitListDetailResponse]?
}


struct ApproveWaitListDetailResponse: Codable {
    var userType:String?
    var draftName:String?
    var subject:String?
    var statusCd:String?
    var msgCd:String?
    var seqNo:Int?
}

struct ApprovalLineListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[ApprovalLineListDetailResponse]?
}


struct ApprovalLineListDetailResponse: Codable {
    var seqNo:Int?
    var userType:String?
    var userSeq:Int?
    var statusCd:String?
    var prsnCd:String?
    var prsnNm:String?
    var sysDate:String?
    var isActive: Bool?
    var gwUserId: String?
}
struct ApprovalContentsReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:ApprovalContentsReadDetailResponse?
}


struct ApprovalContentsReadDetailResponse: Codable {
    var contents:String?
    
}

struct ApprovalFileListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[ApprovalFileListDetailResponse]?
}


struct ApprovalFileListDetailResponse: Codable {
    var fileName:String?
    var fileSize:Double?
    var filePath:String?
    
}

//
//  CardRequest.swift
//  D-WORK
//
//  Created by 유민형 on 2022/03/01.
//

import Foundation

struct CardInfoListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
}


struct CardInfoUpdateRequest: Codable {
    var divCdParam:String?
    var reqDate:String?
    var seq:String?
    var reqDiv:String?
    var useDate:String?
    var attPer:String?
    var usePlace:String?
    var exPur:String?
    var foreAmtNum:String?
    var returnDate:String?
    var custNm:String?
}

struct CardInfoDeleteRequest: Codable {
    var divCdParam:String?
    var reqDate:String?
    var seq:String?
}

struct CardDraftRequest: Codable {
    var divCdParam:String?
    var reqDate:String?
    var seq:String?
    var approvalId: String
}

struct CardDraftCancelRequest: Codable {
    var msgCd: String
}

struct CardApprovalCancelRequest: Codable {
    var divCdParam:String?
    var reqDate:String?
    var seq:String?
    var approvalId: String
}

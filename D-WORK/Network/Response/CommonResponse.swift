//
//  CommonResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation



struct CodeListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CodeListDetailResponse]?
}


struct CodeListDetailResponse: Codable {
    var subCd:String?
    var subNm:String?
    var refCd1:String?
    var refCd2:String?
    var refCd3:String?
    var jpnSubNm:String? // 1: 양호, 2: 경계, 3: 주의, 4: 위험, 5: 법위반
}


struct UserListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[UserListDetailResponse]?
}


struct UserListDetailResponse: Codable {
    var prsnCd:String?
    var prsnNm:String?
    var deptCd:String?
    var deptNm:String?
    var postCd:String?
    var postNm:String?
    var divCd:String?
    var divNm:String?
    var gwUserId:String?
    var isSelected:Bool? = false
    
}


struct ApprovalListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[ApprovalListDetailResponse]?
}


struct ApprovalListDetailResponse: Codable {
    var subject:String?
    var approvalLine:String?
    var approvalName:String?
    
}

struct UpDeptListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[UpDeptListDetailResponse]?
}


struct UpDeptListDetailResponse: Codable {
    var divCd:String?
    var divNm:String?
    var orgDeptCd:String?
    var orgDeptNm:String?
    var deptCd:String?
    var deptNm:String?
    var isSelected:Bool?
    
}

struct commonNoticeListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[commonNoticeListResponseData]?
}


struct commonNoticeListResponseData: Codable {
    var dataNo:Double?
    var title:String?
    var dvs:String?
    var dispSec:String?    
}

struct commonPushCountResponseData: Codable {
    var status:Bool?
    var code:Int?
    var data:commonPushCountDetailResponseData?
}

struct commonPushCountDetailResponseData: Codable {
    var cnt:Int?
}

struct DivListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[DivListDetailResponse]?
}


struct DivListDetailResponse: Codable {
    var divCd:String?
    var divNm:String?
}

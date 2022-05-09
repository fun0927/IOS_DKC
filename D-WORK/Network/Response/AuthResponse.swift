//
//  AuthResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation


struct RegistResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:RegistDetailResponse?
}


struct RegistDetailResponse: Codable {
    var reqDate:String?
    var prsnCd:String?
    var uuid:String?
    var pushToken:String?
    var stat:String?
}

struct LoginHeaderResponse: Codable {
    var Authorization:String?
    
}


struct LoginResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:LoginDetailResponse?
}


struct LoginDetailResponse: Codable {
    var prsnNm:String?
    var isManage:String?
    var divCd:String?
    var divNm:String?
    
}


struct AuthInfoReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:AuthInfoReadResponseData?
}


struct AuthInfoReadResponseData: Codable {
    var divNm:String?
    var prsnCd:String?
    var prsnNm:String?
    var deptNm:String?    
}



struct AuthInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[AuthInfoListResponseData]?
}


struct AuthInfoListResponseData: Codable {
    var prsnCd:String?
    var pgmId:String?
    var pgmNm:String?
    var actPermission:String?
    var divPermission:String?
    var divCd1:String?
    var divCd2:String?
    var divCd3:String?
    var divCd4:String?
    var isSelected:Bool?
}

struct AuthEtcListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[AuthEtcListResponseData]?
}


struct AuthEtcListResponseData: Codable {
    var pgmId:String?
    var pgmNm:String?
    var isSelected:Bool?
}


//
//  NoticeResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import Foundation

struct NoticeInfoReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:NoticeInfoReadResponseData?
}

struct NoticeInfoReadResponseData: Codable {
    var isDvs1:String?
    var isDvs2:String?
    var isDvs3:String?
}

struct NoticeInfoCountResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:NoticeInfoCountResponseData?
}

struct NoticeInfoCountResponseData: Codable {
    var cnt:Int?
}

struct NoticeInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[NoticeInfoListResponseData]?
}

struct NoticeInfoListResponseData: Codable {
    var dataNo:Double?
    var title:String?
    var prsnNm:String?
    var readCnt:Double?
    var regDate:String?
    var fileYn:String?
}

struct NoticeHtmlContentResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:NoticeHtmlContentResponseData?
}


struct NoticeHtmlContentResponseData: Codable {
    var title:String?
    var prsnNm:String?
    var readCnt:Int?
    var regDate:String?
    var fileYn:String?
    var content:String?
}

struct NoticeFileListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[NoticeFileListResponseData]?
}


struct NoticeFileListResponseData: Codable {
    var fileName:String?
    
}

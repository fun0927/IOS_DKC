//
//  SurveyRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/07.
//

import Foundation


struct SurveyInfoListRequest: Codable {
    var yyyymmddFr: String
    var yyyymmddTo: String
    var subject: String
    
}

struct SurveyInfoDetailRequest: Codable {
    var Msg_CD: String
    
}
struct SurveyInfoUpdateRequest: Codable {
    var list:[SurveyInfoUpdateRequestList]
}
struct SurveyInfoUpdateRequestList: Codable {
    var Msg_CD: String
    var Que_Num:String
    var Que_Type:String
    var Ans_Value:String
    var Ans_Text:String
}

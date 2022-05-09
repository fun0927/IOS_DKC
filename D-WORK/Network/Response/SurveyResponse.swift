//
//  SurveyResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/07.
//

import Foundation


struct SurveyInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[SurveyInfoListResponseData]?
}


struct SurveyInfoListResponseData: Codable {
    var Subject:String?
    var Sys_Date:String?
    var Start_Date:String?
    var Due_Date:String?
    var Msg_CD:String?
    var Ans_Count:Int?
    var Que_Type:String?
}

struct SurveyInfoDetailResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:SurveyInfoDetailResponseData?
}


struct SurveyInfoDetailResponseData: Codable {
    var que:[QueData]?
    var exm:[exmData]?
}
struct QueData: Codable {
    var Msg_CD:String?
    var Que_Num:Int?
    var Que_Title:String?
    var Que_Type:String?
    var Exm_Cnt:Int?
}

struct exmData: Codable {
    var Msg_CD:String?
    var Que_Num:Int?
    var Exm_Num:Int?
    var Exm_Title:String?
    var Exm_Type:String?
    var isSelected:Bool? = false
}

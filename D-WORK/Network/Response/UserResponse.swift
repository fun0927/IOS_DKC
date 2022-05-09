//
//  UserResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import Foundation


struct UserInfoReadResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:UserInfoReadResponseData?
}


struct UserInfoReadResponseData: Codable {
    var prsnCd:String?
    var prsnNm:String?
    var telNo:String?
    var addr:String?
    var editTelNo:String?
    var editAddr:String?
    var editDetailAddr:String?
}

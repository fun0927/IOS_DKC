//
//  UserRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import Foundation

struct UserInfoUpdateRequest: Codable {
    var telNo: String
    var zipCd:String
    var roadAddress:String
    var bname:String
    var buildingName:String
    var detailAddress:String
    
}

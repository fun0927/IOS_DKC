//
//  MonthWorkResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/09.
//

import Foundation

struct MonthWorkInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[MonthWorkInfoListData]?
}

struct MonthWorkInfoListData:Codable{
    var dd:String?
    var week:Int?
    var sthm21:String?
    var enhm21:String?
    var cdat1:String?
    var cdat2:String?
    var cdat3:String?
    
}

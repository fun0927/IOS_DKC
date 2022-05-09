//
//  RecvHistResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import Foundation


struct RecvHistTypeListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[RecvHistTypeListResponseData]?
}


struct RecvHistTypeListResponseData: Codable {
    var subCd:String?
    var subNm:String?
    var refCd1:String?
    var refCd2:String?
    var refCd3:String?
    var jpnSubNm:String?
    
}

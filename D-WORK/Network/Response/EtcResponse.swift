//
//  EtcResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation

struct ErrorMessage: Decodable {
//  var errorLog: [String]?
//  var errorCode: String?
//    var errorMessage: String?
    var status:Bool?
    var code:Int?
    var data:String?
//  var message: Message?
}



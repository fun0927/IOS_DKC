//
//  FoodResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation

struct FoodListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:FoodListDetailResponse?
}


struct FoodListDetailResponse: Codable {
    var lncYn:String?
    var lncLoc:String?
    var lncAdd:Int?
    var dnrYn:String?
    var dnrLoc:String?
    var dnrAdd:Int?
    var list:[FoodListStruct]?
    
}
struct FoodListStruct:Codable {
    var ldCd:String? // L: 중식, D: 석식
    var addNm:String?
    var addNum:Int?
}

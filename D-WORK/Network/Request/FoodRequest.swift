//
//  FoodRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation

struct FoodInsertRequest: Codable {
    var lncYn: String // 사번
    var lncLoc: String
    var lncAdd: String
    var dnrYn:String
    var dnrLoc:String
    var dnrAdd:String
    var list:[FoodListStruct]
    
}


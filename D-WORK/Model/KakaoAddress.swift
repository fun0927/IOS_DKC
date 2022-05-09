//
//  KakaoAddress.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import Foundation

struct KakaoAddress: Codable {
    let documents:[KAKAO_DOCUMENT]
    
}

struct KAKAO_DOCUMENT: Codable {
    var place_name:String?
    let address_name:String?
    let road_address_name:String?
    let x:String?
    let y:String?
    var isSelected:Bool?
//    let address:address?
//    let road_address:road_address?
    
}
    

struct address: Codable {
    let address_name:String
    let x:String
    let y:String
}
    
struct road_address: Codable {
    let address_name:String
    let zone_no:String
    let region_3depth_name:String
}
    

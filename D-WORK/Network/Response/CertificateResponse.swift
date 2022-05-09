//
//  CertificateResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import Foundation
struct CertificateInfoListResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:[CertificateInfoListData]?
}

struct CertificateInfoListData:Codable{
    var certifiCd:String?
    var reqDate:String?
    var certifiType:String?
    var remark:String?
    var erpStatus:String?
    var repreType:String?
    var langType:String?
    var issueQty:String?
    var msgCd:String?
    
}

struct CertificateInfoUpdateResponse: Codable {
    var status:Bool?
    var code:Int?
    var data:Double?
}

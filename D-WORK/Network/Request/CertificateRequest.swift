//
//  CertificateRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/28.
//

import Foundation
struct CertificateInfoUpdateRequest: Codable {
    var certifiCd: String?
    var certifiType: String
    var remark: String
    var repreType: String
    var langType: String
    var issueQty: String
    
}
struct CertificateDraftRequest: Codable {
    var certifiCd: String?
    var approvalId: String
    
    
}

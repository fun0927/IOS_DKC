//
//  CertificateApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import Foundation
import Alamofire

enum CertificateApi: ApiRouter{
    case infoList(param : CheckerMasterListRequest)
    case infoUpdate(param : CertificateInfoUpdateRequest)
    case draft(param : CertificateDraftRequest)
  
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .infoUpdate : return .post
        case .draft : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "certificate/infoList"
        case .infoUpdate : return "certificate/infoUpdate"
        case .draft : return "certificate/draft"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    switch self{
        case .infoList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoUpdate(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draft(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
    }
    
    return urlRequest
  }
  
  #if DEBUG
  var fakeFile: String? {
    return nil
  }
  #endif
}


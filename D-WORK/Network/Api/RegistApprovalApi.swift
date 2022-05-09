//
//  RegistApprovalApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation
import Alamofire

enum RegistApprovalApi: ApiRouter{
    case infoList(param : RegistApprovalInfoListRequest)
    case infoUpdate(param : RegistApprovalInfoUpdateRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .infoUpdate : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/registApproval/infoList"
        case .infoUpdate : return "/registApproval/infoUpdate"
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
        
    }
    
    return urlRequest
  }
  
  #if DEBUG
  var fakeFile: String? {
    return nil
  }
  #endif
}


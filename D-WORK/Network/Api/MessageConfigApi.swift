//
//  MessageConfigApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation
import Alamofire

enum MessageConfigApi: ApiRouter{
    case infoList
    case infoUpdate(param : MessageConfigInfoUpdateRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .infoUpdate : return .post
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/messageConfig/infoList"
        case .infoUpdate : return "/messageConfig/infoUpdate"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoList:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
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


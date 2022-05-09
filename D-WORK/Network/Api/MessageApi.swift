//
//  MessageApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/19.
//

import Foundation
import Alamofire

enum MessageApi: ApiRouter{
    case infoUpdate(param : MessageInfoUpdateRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoUpdate : return .post
        
        
    }
  }
  
  var path: String{
    switch self{
        case .infoUpdate : return "/message/infoUpdate"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
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


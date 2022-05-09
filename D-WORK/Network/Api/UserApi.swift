//
//  UserApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/24.
//

import Foundation
import Alamofire

enum UserApi: ApiRouter{
    case infoRead
    case infoUpdate(param : UserInfoUpdateRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoRead : return .post
        case .infoUpdate : return .post
            
    }
  }
  
  var path: String{
    switch self{
        case .infoRead : return "/user/infoRead"
        case .infoUpdate : return "/user/infoUpdate"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoRead:
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


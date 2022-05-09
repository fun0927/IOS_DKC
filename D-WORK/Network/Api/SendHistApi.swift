//
//  SendHistApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/14.
//

import Foundation
import Alamofire

enum SendHistApi: ApiRouter{
    case infoList(param : SendHistInfoListRequest)
    case recvList(param : SendHistRecvListRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .recvList : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/sendHist/infoList"
        case .recvList : return "/sendHist/recvList"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .recvList(let param) :
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


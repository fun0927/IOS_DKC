//
//  InOutApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//

import Foundation
import Alamofire

enum InOutApi: ApiRouter{
    case inOutRead
    case inOutCoordList
    case inOutInsert(param : InOutInsertRequest)
    
  
  var method: HTTPMethod{
    switch self{
        case .inOutRead : return .post
        case .inOutCoordList : return .post
        case .inOutInsert : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .inOutRead : return "/main/inOutRead"
        case .inOutCoordList : return "/main/inOutCoordList"
        case .inOutInsert : return "/main/inOutInsert"
        
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .inOutRead :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .inOutCoordList :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .inOutInsert(let param) :
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

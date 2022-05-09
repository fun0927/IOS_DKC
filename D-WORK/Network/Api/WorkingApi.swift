//
//  WorkingApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import Foundation
import Alamofire

enum WorkingApi: ApiRouter{
    case workingRead(param : WorkingPlanRequest)
    case workingList(param : WorkingPlanRequest)
    
    
  
  var method: HTTPMethod{
    switch self{
        case .workingRead : return .post
        case .workingList : return .post
        
        
    }
  }
  
  var path: String{
    switch self{
        case .workingRead : return "/working/read"
        case .workingList : return "/working/list"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    switch self{
    case .workingRead(let param) :
      urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
    case .workingList(let param) :
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



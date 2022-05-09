//
//  MonthWorkApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/09.
//

import Foundation
import Alamofire

enum MonthWorkApi: ApiRouter{
    case infoList(param:WorkingPlanRequest)
    
    
  
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/monthWork/infoList"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoList(let param) :
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


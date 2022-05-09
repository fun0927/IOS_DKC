//
//  WorkPlanApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/22.
//

import Foundation
import Alamofire

enum WorkPlanApi: ApiRouter{
    case workPlan(param : WorkingPlanRequest)
    case workPlanList(param : WorkingPlanRequest)
    case restRead(param : WorkingPlanRequest)
    case update(param : WorkingPlanUpdateRequest)
    
    
  
  var method: HTTPMethod{
    switch self{
        case .workPlan : return .post
        case .workPlanList : return .post
        case .restRead : return .post
        case .update : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .workPlan : return "/workPlan/read"
        case .workPlanList : return "/workPlan/list"
        case .restRead : return "/workPlan/restRead"
        case .update : return "/workPlan/update"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .workPlan(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .workPlanList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .restRead(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .update(let param) :
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



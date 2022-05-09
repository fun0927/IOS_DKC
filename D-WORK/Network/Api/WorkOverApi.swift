//
//  WorkOverApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/16.
//

import Foundation
import Alamofire

enum WorkOverApi: ApiRouter{
    case divList
    case infoRead(param:WorkPlanReportInfoReadRequest)
    case infoList(param:WorkOverInfoListRequest)
    
    
  
  var method: HTTPMethod{
    switch self{
        case .divList : return .post
        case .infoRead : return .post
        case .infoList : return .post
    }
  }
  
  var path: String{
    switch self{
        case .divList : return "/workOver/divList"
        case .infoRead : return "/workOver/infoRead"
        case .infoList : return "/workOver/infoList"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .divList :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(["":""]))
        case .infoRead(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
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


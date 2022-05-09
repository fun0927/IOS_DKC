//
//  WorkPlanResultApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/14.
//

import Foundation
import Alamofire

enum WorkPlanResultApi: ApiRouter{
    case divList
    case infoRead(param:WorkPlanReportInfoReadRequest)
    case infoList(param:WorkPlanReportInfoListRequest)
    case detailRead(param:WorkPlanResultInfoListRequest)
    case detailList(param:WorkPlanResultInfoListRequest)
    
  
  var method: HTTPMethod{
    switch self{
        case .divList : return .post
        case .infoRead : return .post
        case .infoList : return .post
        case .detailRead : return .post
        case .detailList : return .post
    }
  }
  
  var path: String{
    switch self{
        case .divList : return "/workPlanResult/divList"
        case .infoRead : return "/workPlanResult/infoRead"
        case .infoList : return "/workPlanResult/infoList"
        case .detailRead : return "/workPlanResult/detailRead"
        case .detailList : return "/workPlanResult/detailList"
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
        case .detailRead(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .detailList(let param) :
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


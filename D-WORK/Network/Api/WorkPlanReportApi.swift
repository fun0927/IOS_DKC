//
//  WorkPlanReportApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/10.
//

import Foundation
import Alamofire

enum WorkPlanReportApi: ApiRouter{
    case divList
    case infoRead(param:WorkPlanReportInfoReadRequest)
    case infoList(param:WorkPlanReportInfoListRequest)
    case detailRead(param:WorkPlanResultInfoListRequest)
    case detailList(param:WorkPlanResultInfoListRequest)
    case update(param:WorkingPlanReportUpdateRequest)
    case chkUpdate(param:WorkingPlanReportChkUpdateRequest)
  
  var method: HTTPMethod{
    switch self{
        case .divList : return .post
        case .infoRead : return .post
        case .infoList : return .post
        case .detailRead : return .post
        case .detailList : return .post
        case .update : return .post
        case .chkUpdate : return .post
    }
  }
  
  var path: String{
    switch self{
        case .divList : return "/workPlanReport/divList"
        case .infoRead : return "/workPlanReport/infoRead"
        case .infoList : return "/workPlanReport/infoList"
        case .detailRead : return "/workPlanReport/detailRead"
        case .detailList : return "/workPlanReport/detailList"
        case .update : return "/workPlanReport/update"
        case .chkUpdate : return "/workPlanReport/chkUpdate"
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
        case .update(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .chkUpdate(let param) :
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


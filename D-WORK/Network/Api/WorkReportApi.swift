//
//  WorkReportApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/25.
//

import Foundation
import Alamofire

enum WorkReportApi: ApiRouter{
    case masterList(param : WorkingPlanRequest)
    case detailList(param : WorkReportDetailRequest)
    case reqInfoList
    case restRead(param : WorkReportDetailRequest)
    case workNoAList(param : WorkReportworkNoAListRequest)
    case workNoCList(param : WorkReportworkNoAListRequest)
    case workNoZList
    case budgetList(param : WorkReportworkBudgetListRequest?)
    case update(param : WorkReportUpdateRequest)
    case draft(param : WorkReportDraftRequest)
    case draftCancel(param : WorkReportDraftCancelRequest)
    case approvalCancel(param : WorkReportDraftRequest)
  
  var method: HTTPMethod{
    switch self{
        case .masterList : return .post
        case .detailList : return .post
        case .reqInfoList : return .post
        case .restRead : return .post
        case .workNoAList : return .post
        case .workNoCList : return .post
        case .workNoZList : return .post
        case .budgetList : return .post
        case .update : return .post
        case .draft : return .post
        case .draftCancel : return .post
        case .approvalCancel : return .post
    }
  }
  
  var path: String{
    switch self{
        case .masterList : return "/workReport/masterList"
        case .detailList : return "/workReport/detailList"
        case .reqInfoList : return "/workReport/reqInfoList"
        case .restRead : return "/workReport/restRead"
        case .workNoAList : return "/workReport/workNoAList"
        case .workNoCList : return "/workReport/workNoCList"
        case .workNoZList : return "/workReport/workNoZList"
        case .budgetList : return "/workReport/budgetList"
        case .update : return "/workReport/update"
        case .draft : return "/workReport/draft"
        case .draftCancel : return "/workReport/draftCancel"
        case .approvalCancel : return "/workReport/approvalCancel"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .masterList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .detailList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .reqInfoList :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .restRead(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .workNoAList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .workNoCList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .workNoZList :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .budgetList(let param) :
            if let param = param {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
            } else {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
            }
          
        case .update(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draft(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draftCancel(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approvalCancel(let param) :
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



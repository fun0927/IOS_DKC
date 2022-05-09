//
//  ApprovalApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation
import Alamofire

enum ApprovalApi: ApiRouter{
    case countRead
    case undecidedList(param : ApprovalWaitListRequest)
    case progressList(param : ApprovalWaitListRequest)
    case completeList(param : ApprovalCompleteRequest)
    case completeCount(param : ApprovalCompleteRequest)
    case undecidedFFList(param : ApprovalWaitListRequest)
    case approvalLineList(param : ApprovalLineListRequest)
    case contentsRead(param : ApprovalLineListRequest)
    case fileList(param : ApprovalLineListRequest)
    case approval(param : ApprovalRequest)
    case rejectList(param : ApprovalWaitListRequest)
    
    
    
  
  var method: HTTPMethod{
    switch self{
        case .countRead : return .post
        case .undecidedList : return .post
        case .progressList : return .post
        case .completeList : return .post
        case .completeCount : return .post
        case .undecidedFFList : return .post
        case .approvalLineList : return .post
        case .contentsRead : return .post
        case .fileList : return .post
        case .approval : return .post
        case .rejectList : return . post
    }
  }
  
  var path: String{
    switch self{
        case .countRead : return "/approval/countRead"
        case .undecidedList : return "/approval/undecidedList"
        case .progressList : return "/approval/progressList"
        case .completeList : return "/approval/completeList"
        case .completeCount : return "/approval/completeCount"
        case .undecidedFFList : return "/approval/undecidedFFList"
        case .approvalLineList : return "/approval/approvalLineList"
        case .contentsRead : return "/approval/contentsRead"
        case .fileList : return "/approval/fileList"
        case .approval : return "/approval/approval"
        case .rejectList : return "/approval/rejectList"
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .countRead :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .undecidedList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .progressList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .completeList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .completeCount(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .undecidedFFList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approvalLineList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .contentsRead(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .fileList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approval(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .rejectList(let param) :
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

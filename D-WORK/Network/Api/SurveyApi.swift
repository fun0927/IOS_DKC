//
//  SurveyApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/07.
//

import Foundation
import Alamofire

enum SurveyApi: ApiRouter{
    case infoList(param : SurveyInfoListRequest)
    case infoDetail(param : SurveyInfoDetailRequest)
    case infoUpdate(param : SurveyInfoUpdateRequest)
    case fileList(param : NoticeInfoDetailRequest)
    
  
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .infoDetail : return .post
        case .infoUpdate : return .post
        case .fileList : return .post
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/survey/infoList"
        case .infoDetail : return "/survey/infoDetail"
        case .infoUpdate : return "/survey/infoUpdate"
        case .fileList : return "/survey/fileList"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoDetail(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoUpdate(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .fileList(let param) :
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


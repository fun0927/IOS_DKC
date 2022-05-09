//
//  HumanApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/29.
//

import Foundation
import Alamofire

enum HumanApi: ApiRouter{
    case infoCnt
    case infoList(param : HumanInfoListRequest)
    case infoUpdate(param : HumanInfoUpdateRequest)
    
  
  var method: HTTPMethod{
    switch self{
        case .infoCnt : return .post
        case .infoList : return .post
        case .infoUpdate : return .post
    }
  }
  
  var path: String{
    switch self{
        case .infoCnt : return "/human/infoCnt"
        case .infoList : return "/human/infoList"
        case .infoUpdate : return "/human/infoUpdate"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoCnt :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
        case .infoList(let param) :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoUpdate(let param) :
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

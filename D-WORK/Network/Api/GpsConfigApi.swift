//
//  GpsConfig.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/21.
//

import Foundation
import Alamofire

enum GpsConfigApi: ApiRouter{
    case infoList
    case useYnUpdate(param : GpsConfigUseYnUpdateRequest)
    case infoUpdate(param : GpsConfigInfoUpdateRequest)
    
  var method: HTTPMethod{
    switch self{
        case .infoList : return .post
        case .useYnUpdate : return .post
        case .infoUpdate : return .post
    }
  }
  
  var path: String{
    switch self{
        case .infoList : return "/gpsConfig/infoList"
        case .useYnUpdate : return "/gpsConfig/useYnUpdate"
        case .infoUpdate : return "/gpsConfig/infoUpdate"
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .infoList:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
        case .useYnUpdate(let param) :
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


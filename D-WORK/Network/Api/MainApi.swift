//
//  MainApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import Foundation
import Alamofire

enum MainApi: ApiRouter{
    case WorkingInfoRead
    case ManageInfoRead
    case menuAuthList
    
  
  var method: HTTPMethod{
    switch self{
        case .WorkingInfoRead : return .post
        case .ManageInfoRead : return .post
        case .menuAuthList : return .post
        
        
    }
  }
  
  var path: String{
    switch self{
        case .WorkingInfoRead : return "/main/workingInfoRead"
        case .ManageInfoRead : return "/main/manageInfoRead"
        case .menuAuthList : return "/main/menuAuthList"
        
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .WorkingInfoRead :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .ManageInfoRead :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .menuAuthList :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        
        
    }
    
    return urlRequest
  }
  
  #if DEBUG
  var fakeFile: String? {
    return nil
  }
  #endif
}



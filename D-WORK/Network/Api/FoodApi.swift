//
//  FoodApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/19.
//


import Foundation
import Alamofire

enum FoodAPi: ApiRouter{
    case foodList
    case foodInsert(param : FoodInsertRequest)
    
  
  var method: HTTPMethod{
    switch self{
        case .foodList : return .post
        case .foodInsert : return .post
        
    }
  }
  
  var path: String{
    switch self{
        case .foodList : return "/main/foodList"
        case .foodInsert : return "/main/foodInsert"
        
        
    }
  }
  
  func urlRequest() throws -> URLRequest {
    
    let url = try baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    urlRequest.httpMethod = method.rawValue
    
    switch self{
        case .foodList :
          urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .foodInsert(let param) :
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


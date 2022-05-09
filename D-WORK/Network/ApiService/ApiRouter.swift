//
//  ApiRouter.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import Alamofire

protocol ApiRouter: URLRequestConvertible {
  
  var baseUrl: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  
  func makeParams(_: [String : Any]?) -> [String : Any]
  func makeParams(_ params: Codable) -> [String : Any]
  
  func urlRequest() throws -> URLRequest
  func asURLRequest() throws -> URLRequest
  
  #if DEBUG
  var fakeFile: String? { get }
  #endif
}

extension ApiRouter {
  
  func asURLRequest() throws -> URLRequest {
    var request = try urlRequest()
    // token handling
    if !Environment.AUTHORIZATOIN.isEmpty {
      request.addValue("\(Environment.AUTHORIZATOIN)", forHTTPHeaderField: "Authorization")
    }
    return request
  }
  
  var baseUrl: String {
    return Environment.BASE_URL
  }
  
//  var translateUrl: String {
//    return ApiEnvironment.translateUrl
//  }
  
  private func combineDefault(params: [String : Any]?) -> [String : Any] {
//    var newParams = params
//    if params == nil {
    var newParams = [String : Any]()
//    }
//    print("combineDefault newParams : \(newParams)")
    if let params = params {
        for (key, value) in params {
            if let stValue = value as? String{
//                if !stValue.isEmpty {
                    newParams[key] = value
//                }                
            } else {
                switch value {
                case Optional<Any>.none:
                    print("nil")
                default:
                    print("not nil")
                    newParams[key] = value
                }
            }
        }
    }
//    newParams = newParams!.compactMapValues({ $0 })
    print("combineDefault newParams : \(newParams)")
    
    return newParams
  }
  
  func makeParams(_ params: [String : Any]?) -> [String : Any] {
    return combineDefault(params: params)
  }
  
  func makeParams(_ params: Codable) -> [String : Any] {
    return combineDefault(params: params.dictionary)
  }
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

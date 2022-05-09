//
//  ApiResponse.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import Alamofire


struct ApiResponse<T> {
  
  var success: Bool = false
  var statusCode: Int = 500
  var errorString: String?
var value:T?
var headers:[AnyHashable:Any]?
    
  var errorMessage: ErrorMessage?




  
  init(statusCode: Int = 200,
       errorString: String? = nil,
       response: Any? = nil,
       errorMessage: ErrorMessage? = nil) {
    print("init repose")
    self.statusCode = statusCode
    self.errorString = errorString
    self.value = response as? T
    self.errorMessage = errorMessage
  }
  
  init(response: AFDataResponse<T>) {
    print("AFDataResponse")
    switch response.result {
    case .success:
//      self.value = response.result.value
        self.value = response.value
        self.headers = response.response?.allHeaderFields
    case .failure(let error):
      errorString = error.localizedDescription
      do {
        errorMessage = try JSONDecoder().decode(ErrorMessage.self, from: response.data!)
      } catch {
        debugPrint(error)
      }
    }
    
    if let code =  response.response?.statusCode {
      statusCode = code
    }
  }
  
  
  init(statusCode: Int?, data: Data?) {
    print("ApiResponse last : \(data)")
    if let statusCode = statusCode {
      self.statusCode = statusCode
        
    }
    
    if let data = data {
      do {
        
        errorMessage = try JSONDecoder().decode(ErrorMessage.self, from: data)
      } catch {
        debugPrint(error)
      }
    }
  }
}



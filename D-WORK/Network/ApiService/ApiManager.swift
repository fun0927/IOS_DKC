//
//  ApiManager.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import Alamofire


protocol ApiManager {
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<T>, failure: FailureHanler?) -> ApiRequest
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<[T]>, failure: FailureHanler?) -> ApiRequest
}

fileprivate var manager: Session = {
  return Alamofire.Session()
}()

fileprivate func reloadSessionManager() -> Session {
//  var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
  //    defaultHeaders["api_Key"] = ApiEnvironment.serverApiKey
  
  // USER TOKEN
  
//  if let token = OPenPalManager.shared.getAccessToken() {
//    defaultHeaders["Authorization"] = "Bearer \(token)"
//  }
  
  let configuration = URLSessionConfiguration.default
//  configuration.httpAdditionalHeaders = defaultHeaders
  
  let sessionManager = Alamofire.Session(configuration: configuration)
  return sessionManager
}

extension ApiManager {
  
  func isSuccess(_ response: HTTPURLResponse?) -> Bool {
    print("response is success : \(response?.statusCode)")
    
    var ret = false
//    if let response = response, response.statusCode >= 200 && response.statusCode < 300 {
//      ret = true
//    }
    if let response = response, response.statusCode >= 200 && response.statusCode < 300 {
          ret = true
    }
    
    print("ret : \(ret)")
    return ret
  }
  
  func isTokenExpired(_ response: HTTPURLResponse?) -> Bool {
    var ret = false
    if let response = response, response.statusCode == 401 {
      ret = true
    }
    return ret
  }
  
  func reloadManager() {
    manager = reloadSessionManager()
  }
  
  func request(router: ApiRouter, success: @escaping JsonHanler, failure: FailureHanler?) -> ApiRequest {
    let request = manager.request(router).validate()
    request.responseJSON { (response) in
      if self.isSuccess(response.response) {
        let wrappedResponse = ApiResponse<Any>(response: response)
        success(wrappedResponse)
      }
      else {
        print("it is error")
//        let wrappedResponse = ApiResponse<[ErrorMessage]>(response: response)
        let wrappedResponse = ApiResponse<ErrorMessage>(response: response)
        print("wrappedResponse : \(wrappedResponse)")
        failure?(wrappedResponse)
      }
    }
    return ApiRequest(request: request)
  }
  
  func upload<T: Codable>(router: ApiRouter, multiPartFormHanler: @escaping MultiPartFormHanler, success: @escaping SuccessHanler<T>, failure: FailureHanler?) {
    
    
//    manager.upload(
//      multipartFormData: multiPartFormHanler,
//      usingThreshold: 10 * 1024 * 1024,
//        with: router)
        
    manager.upload(multipartFormData: multiPartFormHanler, with: router, usingThreshold: 10 * 1024 * 1024)
        .response{ response in
        
        
    
    }
  }
}

struct RealApiManager: ApiManager {
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<T>, failure: FailureHanler?) -> ApiRequest {
    print("RealApiManager")
    let request = manager.request(router).validate(statusCode: 0..<999)
    printDebug(request: request)
    
    request.responseDecodable(completionHandler: { (response: AFDataResponse<T>) in
//        print("response1 : \(response)")
      if self.isSuccess(response.response) {
//        print("response : \(response)")
        let wrappedResponse = ApiResponse<T>(response: response)
        success(wrappedResponse)
      } else if self.isTokenExpired(response.response){
//        print("it is isTokenExpired ")

        // 후에 jwt 관련 분기 처리 필요
        let wrappedResponse = ApiResponse<ErrorMessage>(statusCode: response.response?.statusCode, data: response.data)
          failure?(wrappedResponse)
          
        
      }else {
//        print("is unathorized")
        let wrappedResponse = ApiResponse<ErrorMessage>(statusCode: response.response?.statusCode, data: response.data)
        failure?(wrappedResponse)
      }
    })
    
    return ApiRequest(request: request)
  }
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<[T]>, failure: FailureHanler?) -> ApiRequest {
    let request = manager.request(router).validate()
    printDebug(request: request)
    
    request.responseDecodable(completionHandler: { (response: AFDataResponse<[T]>) in
      if self.isSuccess(response.response) {
        let wrappedResponse = ApiResponse<[T]>(response: response)
        success(wrappedResponse)
      }else if self.isTokenExpired(response.response){
//        guard let accessToken = OPenPalManager.shared.getAccessToken() else {
//          let wrappedResponse = ApiResponse<[ErrorMessage]>(statusCode: response.response?.statusCode, data: response.data)
//          failure?(wrappedResponse)
//          return
//        }
//        guard let refreshToken = OPenPalManager.shared.getRefreshToken() else {
//          let wrappedResponse = ApiResponse<[ErrorMessage]>(statusCode: response.response?.statusCode, data: response.data)
//          failure?(wrappedResponse)
//          return
//        }
        if router.path == "/auth/token/refresh" {
//          OPenPalManager.shared.setLoginOut()
        }else if router.path == "/auth/password" {
          let wrappedResponse = ApiResponse<ErrorMessage>(response: response)
          failure?(wrappedResponse)
//        }else if router.urlRequest?.url == URL(string: ApiEnvironment.translateUrl) {
//          print ("translate fail")
        }else {
//          ApiService.request(router: AuthApi.RefreshToken(param: Token(accessToken: accessToken, refreshToken: refreshToken)), success: { (response: ApiResponse<Token>) in
//            if let accessToken = response.value?.accessToken {
//              OPenPalManager.shared.setLogin(accessToken: accessToken, refreshToken: refreshToken)
//              let _ = self.request(router: router, success: success, failure: failure)
//            }
//          }, failure: { (error) in
//            if error?.statusCode == 401 {
//              OPenPalManager.shared.setLoginOut()
//            }
//          })
        }
      }else {
        let wrappedResponse = ApiResponse<ErrorMessage>(statusCode: response.response?.statusCode, data: response.data)
        failure?(wrappedResponse)
      }
    })
    
    return ApiRequest(request: request)
  }
}

// MARK:- DEBUG
fileprivate func printDebug(request: DataRequest) {
  #if DEBUG
  request.responseData(completionHandler: { (response) in
    print("\n------------------------------------------------------------------------------------------------")
    var output: [String] = []
    output.append("[Request]: \(request)")
    
    if let httpHeader = request.request?.allHTTPHeaderFields {
      output.append("[Request Header]: \(httpHeader)")
    }
    
    
    if let httpBody = request.request?.httpBody {
      // output.append("[Request Data]: \(try! JSON(data: httpBody))")
      output.append("[Request Data utf8] \(String(data: httpBody, encoding: String.Encoding.utf8)!)")
      
    }
    output.append("[Response]: \(response)")
    output.append("response header : \(response.response?.allHeaderFields)")
    
    if let value = response.data,
      let json = String(data: value, encoding: .utf8) {
//      output.append("[Response Data]: \(JSON(parseJSON: json))")
        output.append("[Response Data]: \(json)")
    }
    else {
      output.append("[Data]: nil")
    }
    //output.append("[Result]: \(response.result.debugDescription)")
    //output.append("[Timeline]: \(response.timeline.debugDescription)")
    print(output.joined(separator: "\n"))
    print("------------------------------------------------------------------------------------------------\n")
  })
  #endif
}

#if DEBUG
struct FakeApiManager: ApiManager {
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<T>, failure: FailureHanler?) -> ApiRequest {
    let mockResponse = getMockResponse(router: router, status: 200) as ApiResponse<T>
    let mockRequest = MockRequest(router: router)
    success(mockResponse)
    return ApiRequest(request: mockRequest)
  }
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<[T]>, failure: FailureHanler?) -> ApiRequest {
    let mockResponse = getMockResponses(router: router, status: 200) as ApiResponse<[T]>
    let mockRequest = MockRequest(router: router)
    success(mockResponse)
    return ApiRequest(request: mockRequest)
  }
}


fileprivate func getMockResponse<T: Codable>(router: ApiRouter, status: Int) -> ApiResponse<T> {
  
//  if let file = router.fakeFile, status >= 200 && status < 300 {
//    let json = JSONFileReader.getJSONNamed(file)
//    return ApiResponse<T>(statusCode: status, errorString: nil, response: json)
//  }
//  else {
    return ApiResponse<T>(statusCode: 400, errorString: "Mock Error", response: nil)
//  }
}

fileprivate func getMockResponses<T: Codable>(router: ApiRouter, status: Int) -> ApiResponse<[T]> {
  
//  if let file = router.fakeFile, status >= 200 && status < 300 {
//    let json = JSONFileReader.getJSONNamed(file)
//    return ApiResponse<[T]>(statusCode: status, errorString: nil, response: json)
//  }
//  else {
    return ApiResponse<[T]>(statusCode: 400, errorString: "Mock Error", response: nil)
//  }
}


struct MockApiManager: ApiManager {
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<T>, failure: FailureHanler?) -> ApiRequest {
    let mockResponse = getMockResponse(router: router, status: 200) as ApiResponse<T>
    success(mockResponse)
    let mockRequest = MockRequest(router: router)
    return ApiRequest(request: mockRequest)
  }
  
  func request<T: Codable>(router: ApiRouter, success: @escaping SuccessHanler<[T]>, failure: FailureHanler?) -> ApiRequest {
    let mockResponse = getMockResponse(router: router, status: 200) as ApiResponse<[T]>
    success(mockResponse)
    let mockRequest = MockRequest(router: router)
    return ApiRequest(request: mockRequest)
  }
  
  func requestStub<T: Codable>(router: ApiRouter,
                               status: Int,
                               response: ApiResponse<T>?,
                               completion: @escaping (ApiResponse<T>) -> ()) -> ApiRequest {
    if let response = response {
      completion(response)
      let mockRequest = MockRequest(router: router)
      return ApiRequest(request: mockRequest)
    }
    else {
      return request(router: router, success: completion, failure: nil)
    }
  }
}
#endif




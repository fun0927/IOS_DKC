//
//  RecvHistApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2022/01/17.
//

import Foundation
import Alamofire

enum RecvHistApi: ApiRouter{
    case typeList
    case infoList(param : RecvHistInfoListRequest)
    case infoUpdate(param : RecvHistInfoUpdateRequest)
    
    var method: HTTPMethod{
        switch self{
        case .typeList : return .post
        case .infoList : return .post
        case .infoUpdate : return .post
        }
    }
    
    var path: String{
        switch self{
        case .typeList : return "/recvHist/typeList"
        case .infoList : return "/recvHist/infoList"
        case .infoUpdate : return "/recvHist/infoUpdate"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case .typeList :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(["":""]))
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


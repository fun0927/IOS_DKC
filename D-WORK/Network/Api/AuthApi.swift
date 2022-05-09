//
//  AuthApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import Alamofire

enum AuthApi: ApiRouter{
    case RegistCheck(param : RegistRequest)
    case Regist(param : RegistRequest)
    case Login(param : LoginRequest)
    case infoRead(param : AuthInfoReadRequest)
    case infoList(param : AuthInfoReadRequest)
    case infoDelete(param : AuthInfoDeleteRequest)
    case etcList(param : AuthInfoReadRequest)
    case infoUpdate(param : AuthInfoUpdateRequest)
    
    
    var method: HTTPMethod{
        switch self{
        case .RegistCheck : return .post
        case .Regist : return .post
        case .Login : return .post
        case .infoRead : return .post
        case .infoList : return .post
        case .infoDelete : return .post
        case .etcList : return .post
        case .infoUpdate : return .post
        }
    }
    
    var path: String{
        switch self{
        case .RegistCheck : return "/registCheck"
        case .Regist : return "/regist"
        case .Login : return "/login"
        case .infoRead : return "/auth/infoRead"
        case .infoList : return "/auth/infoList"
        case .infoDelete : return "/auth/infoDelete"
        case .etcList : return "/auth/etcList"
        case .infoUpdate : return "/auth/infoUpdate"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case .RegistCheck(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .Regist(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .Login(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoRead(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoDelete(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .etcList(let param) :
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


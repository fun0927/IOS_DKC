//
//  NoticeApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/30.
//

import Foundation
import Alamofire

enum NoticeApi: ApiRouter{
    case infoRead
    case infoCount(param : NoticeInfoCountRequest)
    case infoList(param : NoticeInfoListRequest)
    case infoDetail(param : NoticeInfoDetailRequest)
    case fileList(param : NoticeInfoDetailRequest)
    
    
    var method: HTTPMethod{
        switch self{
        case .infoRead : return .post
        case .infoCount : return .post
        case .infoList : return .post
        case .infoDetail : return .post
        case .fileList : return .post
        }
    }
    
    var path: String{
        switch self{
        case .infoRead : return "/notice/infoRead"
        case .infoCount : return "/notice/infoCount"
        case .infoList : return "/notice/infoList"
        case .infoDetail : return "/notice/infoDetail"
        case .fileList : return "/notice/fileList"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case .infoRead :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .infoCount(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoDetail(let param) :
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

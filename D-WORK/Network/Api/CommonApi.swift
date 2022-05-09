//
//  CommonApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation
import Alamofire

enum CommonApi: ApiRouter{
    case codeList(param : CommonRequest)
    case userList(param : UserListRequest)
    case approvalList
    case upDeptList(param : UpDeptListRequest)
    case deptList(param : UpDeptListRequest)
    case noticeList
    case divList
    case pushCount
    case pushTokenUpdate(param: pushTokenUpdateRequest)
    
    
    var method: HTTPMethod{
        switch self{
        case .codeList : return .post
        case .userList : return .post
        case .approvalList : return .post
        case .upDeptList : return .post
        case .deptList : return .post
        case .noticeList : return .post
        case .divList : return .post
        case .pushCount : return .post
        case .pushTokenUpdate : return .post
        }
    }
    
    var path: String{
        switch self{
        case .codeList : return "/common/codeList"
        case .userList : return "/common/userList"
        case .approvalList : return "/common/approvalList"
        case .upDeptList : return "/common/upDeptList"
        case .deptList : return "/common/deptList"
        case .noticeList : return "/common/noticeList"
        case .divList : return "/common/divList"
        case .pushCount : return "/common/pushCount"
        case .pushTokenUpdate : return "/common/pushTokenUpdate"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case .codeList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .userList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approvalList :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .upDeptList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .deptList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .noticeList :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: nil)
        case .divList :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
        case .pushCount :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["":""])
        case .pushTokenUpdate(let param) :
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


//
//  CardApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/12/20.
//

import Foundation
import Alamofire

enum CardApi: ApiRouter{
    case infoList(param : CardInfoListRequest)
    case infoUpdate(param : CardInfoUpdateRequest)
    case infoDelete(param: CardInfoDeleteRequest)
    case draft(param: CardDraftRequest)
    case draftCancel(param: CardDraftCancelRequest)
    case approvalCancel(param: CardApprovalCancelRequest)
    
    var method: HTTPMethod{
        switch self{
        case .infoList : return .post
        case .infoUpdate : return .post
        case .infoDelete : return .post
        case .draft : return .post
        case .draftCancel : return .post
        case .approvalCancel : return .post
        }
    }
    
    var path: String{
        switch self{
        case .infoList : return "card/infoList"
        case .infoUpdate : return "card/infoUpdate"
        case .infoDelete : return "card/infoDelete"
        case .draft : return "card/draft"
        case .draftCancel : return "card/draftCancel"
        case .approvalCancel : return "card/approvalCancel"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self{
        case .infoList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoUpdate(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .infoDelete(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draft(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draftCancel(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approvalCancel(let param) :
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



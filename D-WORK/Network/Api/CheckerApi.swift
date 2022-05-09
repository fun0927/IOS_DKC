//
//  CheckerApi.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/23.
//

import Foundation
import Alamofire

enum CheckerApi: ApiRouter{
    case masterList(param : CheckerMasterListRequest)
    case detailInfo(param : CheckerDetailInfoRequest)
    case update(param : CheckerUpdateRequest)
    case orderList(param : CheckerOrderListRequest)
    case delete(param : CheckerDeleteRequest)
    case draft(param : CheckerDraftRequest)
    case draftCancel(param : CheckerDraftCancelRequest)
    case approvalCancel(param : CheckerApprovalCancelRequest)
    
    case checkDup(param: CheckerCheckRequest)
    case attendanceRead(param: CheckerCheckRequest)
    case workReportList(param: CheckerCheckRequest)
    case calendarRead(param: CheckerCheckRequest)
    case checkHolidayM(param: CheckerCheckRequest)
    case checkWorkTime(param: CheckerCheckRequest)
    case dayCount(param: CheckerCheckRequest)
    case getHoliday(param: CheckerCheckRequest)
    case getYearHoliday(param: CheckerCheckRequest)
    case getMHoliday(param: CheckerCheckRequest)
    
    
    var method: HTTPMethod{
        switch self{
        case .masterList : return .post
        case .detailInfo : return .post
        case .update : return .post
        case .orderList : return .post
        case .delete : return .post
        case .draft : return .post
        case .draftCancel : return .post
        case .approvalCancel : return .post
            
        case .checkDup : return .post
        case .attendanceRead : return .post
        case .workReportList : return .post
        case .calendarRead : return .post
        case .checkHolidayM : return .post
        case .checkWorkTime : return .post
        case .dayCount : return .post
        case .getHoliday : return .post
        case .getYearHoliday : return .post
        case .getMHoliday : return .post
        }
    }
    
    var path: String{
        switch self{
        case .masterList : return "checker/masterList"
        case .detailInfo : return "checker/detailInfo"
        case .update : return "checker/update"
        case .orderList : return "checker/orderList"
        case .delete : return "checker/delete"
        case .draft : return "checker/draft"
        case .draftCancel : return "checker/draftCancel"
        case .approvalCancel : return "checker/approvalCancel"
            
        case .checkDup : return "checker/checkDup"
        case .attendanceRead : return "checker/attendanceRead"
        case .workReportList : return "checker/workReportList"
        case .calendarRead : return "checker/calendarRead"
        case .checkHolidayM : return "checker/checkHolidayM"
        case .checkWorkTime : return "checker/checkWorkTime"
        case .dayCount : return "checker/dayCount"
        case .getHoliday : return "checker/getHoliday"
        case .getYearHoliday : return "checker/getYearHoliday"
        case .getMHoliday : return "checker/getMHoliday"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self{
        case .masterList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .detailInfo(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .update(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .orderList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .delete(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draft(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .draftCancel(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .approvalCancel(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
            
        case .checkDup(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .attendanceRead(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .workReportList(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .calendarRead(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .checkHolidayM(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .checkWorkTime(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .dayCount(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .getHoliday(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .getYearHoliday(let param) :
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: makeParams(param))
        case .getMHoliday(let param) :
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


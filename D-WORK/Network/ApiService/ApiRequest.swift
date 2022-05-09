//
//  ApiRequest.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/16.
//

import Foundation
import Alamofire

protocol Cancelable {
    
    func cancel()
}

extension Request: Cancelable {
    func cancel() {
        
    }
}

struct ApiRequest {
    
    let request: Cancelable
    
    init(request: Cancelable) {
        self.request = request
    }
    
    func cancel() {
        request.cancel()
    }
}


struct MockRequest: Cancelable  {
    
    let urlRequest: URLRequest?
    
    init(router: ApiRouter) {
        if let urlRequest = try? router.asURLRequest() {
            self.urlRequest = urlRequest
        }
        else {
            assertionFailure("urlRequest cannot be nil")
            urlRequest = nil
        }
    }
    
    func cancel() {
        debugPrint("Canceled Mock Request")
    }
}

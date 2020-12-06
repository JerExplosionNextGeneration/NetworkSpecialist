//
//  GeRequest.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

struct GetRequest: RequestabilityProtocol {
    let path: String
    let method: String
    
    init(method: String = GloballyApplied.getMethod, path: String) {
        self.method = method
        self.path = path
    }
    func urlRequestFunc() -> URLRequest {
        guard let url = URL(string: GloballyApplied.baseURLString) else {
            let emptyURL = URL(fileURLWithPath: GloballyApplied.nothingness)
            let emptyRequest = URLRequest(url: emptyURL)
            return emptyRequest
        }
        let urlFinalVersion = url.appendingPathComponent(path)
        var geRequest = URLRequest(url: url)
        geRequest.httpMethod = method
        
        return geRequest
    }        
}

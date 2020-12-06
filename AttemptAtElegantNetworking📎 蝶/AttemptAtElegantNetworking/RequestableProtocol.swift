//
//  RequestableProtocol.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

protocol RequestabilityProtocol {
    func urlRequestFunc() -> URLRequest
}

extension URLRequest: RequestabilityProtocol {
    func urlRequestFunc() -> URLRequest {
        return self
    } // not sure if this extension is necessary or not though
}
             

//
//  ErroStatusExtension.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

extension WorkNet {
    struct StatusCodeErr: Error {
        let stsCode: Int
    }
    
    func erro(from response: URLResponse?) -> Error? {
        guard let urlResponse = response as? HTTPURLResponse else {
            BorrowableLog.assertFailure("http response not found")
            return nil
        }
        let statusCode = urlResponse.statusCode
        
        switch statusCode {
        case 200...299:
            return nil
        default:
            print(response?.url?.absoluteString, "yields to", statusCode)
            return StatusCodeErr(stsCode: statusCode)
        }
    }

}


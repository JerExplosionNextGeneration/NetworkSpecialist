//
//  GloballyApplied.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

struct GloballyApplied {
    static let dispatchQueueLabel = "WorkNetClassy"
    static let baseURLString = "BASE_URL"
    static let nothingness = ""
    static let getMethod = "GET"
    static let postMethod = "POST"
    static let applicationSlashJson = "application/json"
    static let contentType = "Content-Type"
}          

protocol CodaModel: Codable {
    // used in worknet class
}
          

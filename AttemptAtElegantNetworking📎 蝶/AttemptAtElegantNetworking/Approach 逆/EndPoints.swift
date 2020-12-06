//
//  EndPoints.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/11/20.
//

import Foundation

protocol EndPointsProtocol {
    var scheme: String { get }
    var path: String { get }
    var method: String { get }
    var baseURL: String { get }
    var parameters: [URLQueryItem] { get} 
}

//
//  PoRequest.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation
     
struct PostRequest<EModel: Encodable> : RequestabilityProtocol {
    
    let encodableModel: EModel
    let path: String
    
    func urlRequestFunc() -> URLRequest {
        
        guard let url = URL(string: GloballyApplied.baseURLString) else {
            let emptURL = URL(fileURLWithPath: GloballyApplied.nothingness)
            let emptRequest = URLRequest(url: emptURL)
            return emptRequest
        }
        let urlWithPath = url.appendingPathComponent(path)
        var poRequest = URLRequest(url: urlWithPath)
        poRequest.httpMethod = GloballyApplied.postMethod
        
        do {
            let encoder = JSONEncoder.init()
            let encodedData = try encoder.encode(encodableModel)
            poRequest.httpBody = encodedData
            poRequest.setValue(GloballyApplied.applicationSlashJson, forHTTPHeaderField: GloballyApplied.contentType)
            
        } catch let erro {
            print(erro.localizedDescription)
     //       BorrowableLog.assertFailure("post request encoding effort wasted")
        }
        return poRequest
    }
}


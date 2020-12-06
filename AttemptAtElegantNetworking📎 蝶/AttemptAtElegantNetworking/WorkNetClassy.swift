//
//  WorkNetClassy.swift
//  AttemptAtElegantNetworking
//
//  Created by Jerry Ren on 11/10/20.
//

import Foundation

protocol WorkNetProtocol {
    func sending(urlRequest: URLRequest, completion: (Result<Data, Error>)->Void)
}

class WorkNet {
    static let shared = WorkNet.init()
    let nwSessionDeprecated = URLSession() //deprecated in ios 13 though
    let nwSessionObject: URLSession? = URLSession(configuration: .default)
    
    private let nwQueue = DispatchQueue(label: GloballyApplied.dispatchQueueLabel, qos: .userInitiated, attributes: .concurrent)
    
    func sending<T: CodaModel> (_ urlRequest: RequestabilityProtocol, completion:@escaping (Result<T, Error>) -> Void) {
        let nwRequest = urlRequest.urlRequestFunc()
                            
        nwQueue.async {
            
            let dTask = self.nwSessionObject?.dataTask(with: nwRequest) { data, response, erro in
                
                let result: Result<T, Error>
                
                if let erro = erro { // redundant if let?
                    result = .failure(erro)
                } else if let data = data {
                    do {
                        result = .success(try JSONDecoder.init().decode(T.self, from: data))
                    } catch {
                        guard let erro = erro else { return }
                        result = .failure(erro)
                    }
                }
            }.resume()
        }
    }
    enum NetworkerErro: Error {
        case noData
        case noDataAndNoError
    }
}




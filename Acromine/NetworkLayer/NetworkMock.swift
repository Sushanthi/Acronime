//
//  NetworkMock.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation

class NetworkMock: NetworkProtocol {
    
    static let shared = NetworkMock()
    
    private init() { }
    
    func getAcromines(endPoint:EndPoint, onCompletion: @escaping (AcromineModelArray?,Error?) -> Void) {
        let jsonData = readMockJSON("Acromines")
        do {
            let codableModel = try JSONDecoder().decode(AcromineModelArray.self, from: jsonData)
            onCompletion(codableModel, nil)
        } catch let error {
            onCompletion(nil,error)
        }
    }
}

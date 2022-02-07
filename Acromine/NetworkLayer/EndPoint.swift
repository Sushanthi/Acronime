//
//  EndPoint.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//
import Foundation
enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
}
enum APIPath:String {
    case acromine = "dictionary.py"
}

class EndPoint {
    var path:String = ""
    var urlParameters:[String:Any]
    var method: HTTPMethod = HTTPMethod.get

    init(path:String? = "", urlParameters:[String:String]? = [:], method:HTTPMethod? = .get) {
        self.path = path!
        self.urlParameters = urlParameters!
        self.method = method!
    }
    
}

//
//  Network.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation

let BASE_URL = "http://www.nactem.ac.uk/software/acromine/"
typealias completionHandler = (Bool,Any?) -> Void

protocol NetworkProtocol {
    func getAcromines(endPoint:EndPoint, onCompletion: @escaping (AcromineModelArray?,Error?) -> Void)
}

class Network: NetworkProtocol {
    public static var shared = Network()
    
    private init () {}
    // Made this a sprivate so that othe classes can not create this object again
    func getAcromines(endPoint: EndPoint, onCompletion: @escaping (AcromineModelArray?,Error?) -> Void) {
        self.get(endPoint: endPoint) { (isSuccess, jsonData) in
            if let error = jsonData as? Error {
                onCompletion(nil,error)
                return
            }
            if let dataObj = jsonData as? Data{
                do {
                    let codableModel = try JSONDecoder().decode(AcromineModelArray.self, from: dataObj)
                    onCompletion(codableModel,nil)
                } catch let error {
                    onCompletion(nil,error)
                }
            }
        }
    }
    
    /*
     wrote only get call here as we have only GET api's for retriving the Acromines
     */
    func get(endPoint:EndPoint, compleationHandler:@escaping completionHandler ) {
        
        guard var url = URL(string: BASE_URL + endPoint.path) else {
            return
        }
        if endPoint.urlParameters.count > 0 {
            let queryItems = endPoint.urlParameters.map {
                return URLQueryItem(name: "\($0)", value: "\($1)")
            }
            var urlComponents = URLComponents(url: url , resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            url = urlComponents?.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue

        print("GET request:\(request)");
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.validateResponse(data: data, response: response, error: error) { (isSuccess, jsonData) in
                compleationHandler(isSuccess,jsonData)
            }
        }.resume()
    }
    // For all GET/PUT/POST cals we can use this function to validate response
    private func validateResponse(data:Data?, response:URLResponse?, error:Error?, compleationHandler:@escaping completionHandler ) {

        if !(response?.isSuccessStausCode ?? false) || error != nil {
            if let err = error {
                compleationHandler(false,err)
                return
            }
        }
        guard let data = data else {
            compleationHandler(false,error)
            return
        }
        compleationHandler(true,data)
    }
    
}
extension URLResponse {
    
    var isSuccessStausCode:Bool {
       if let httpResponse = self as? HTTPURLResponse {
            return (200...299).contains(httpResponse.statusCode)
        }
        return false
    }

}

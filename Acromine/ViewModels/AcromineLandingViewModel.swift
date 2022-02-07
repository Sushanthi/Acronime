//
//  AcromineLandingViewModel.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation

class AcromineLandingViewModel {
    
    var error: Observable<String?> = Observable(nil)
    var networkManager: NetworkProtocol?
    var acromines: Observable<AcromineModelArray> = Observable([])
    
    init(manager: NetworkProtocol = NetworkMock.shared) {
        self.networkManager = manager
    }

    func retieveAcromines(acromine:String) {
        showLoding()
        let endPoint = EndPoint(path: APIPath.acromine.rawValue, urlParameters: ["sf" : acromine])
        self.networkManager?.getAcromines(endPoint: endPoint, onCompletion: { [weak self] (respModel, error) in
            hideLoding()
            if let model = respModel {
                if model.count > 0 {
                    self?.acromines.value = model
                    return
                }
                self?.setError("No Acromines found for \(acromine)")
            }
            if let error = error {
                self?.setError(error.localizedDescription)
            }
        })
    }

    func setError(_ message: String) {
        self.error.value = message
    }

}

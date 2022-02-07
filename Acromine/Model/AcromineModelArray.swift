//
//  AcromineModel.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation
typealias AcromineModelArray = [AcromineModel]


struct AcromineModel: Codable {
    let sf: String?
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [LF]?
}


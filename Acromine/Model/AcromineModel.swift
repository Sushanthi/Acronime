//
//  AcromineModel.swift
//  Acromine
//
//  Created by Balaji Veeranala on 30/01/22.
//

import Foundation
typealias AcromineModelArray = [AcromineModelElement]

struct AcromineModelElement: Codable {
    let sf: String?
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [LF]?
}


//
//  TableCellProtocol.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation
import UIKit

protocol TableCellProtocol: UITableViewCell {
    static var nibName: String { get }
    static var identifier: String { get }
    func update(model: Any)
}

extension TableCellProtocol {
    static var nibName: String {
        return String(describing: self)
    }
    public static var identifier: String {
        return String(describing: self)
    }
}

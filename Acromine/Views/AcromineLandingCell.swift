//
//  AcromineLandingCell.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import UIKit

class AcromineLandingCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var freqLabel:UILabel!
    @IBOutlet var sinceLabel:UILabel!
    
    var longFormModel: LF? {
        didSet {
            bind()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func bind() {
        guard let model = self.longFormModel else { return }
                
        nameLabel.text = model.lf ?? "Not Available"
        freqLabel.text = "\(model.freq ?? 0)"
        sinceLabel.text = "\(model.since ?? 0)"
        layoutIfNeeded()
    }
    
}
extension AcromineLandingCell: TableCellProtocol
{
    func update(model: Any) {
        guard let model = model as? LF else {
            return
        }
        self.longFormModel = model
    }
}

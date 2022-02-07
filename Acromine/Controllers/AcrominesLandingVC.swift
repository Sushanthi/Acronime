//
//  AcrominesLandingVC.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import UIKit

class AcrominesLandingVC: UIViewController {
    var viewModel:AcromineLandingViewModel?

    var landingView:AcrominesLandingView {
        return self.view as! AcrominesLandingView
    }
    init(_ viewModel: AcromineLandingViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        return nil
    }
    override func loadView() {
        self.view = AcrominesLandingView(viewModel: self.viewModel!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Acromines"
        viewModel?.acromines.bind { acromines in
            DispatchQueue.main.async {
                self.landingView.tableview.isHidden = false
                self.landingView.errorLabel.isHidden = true
                self.landingView.tableview.reloadData()
            }
        }
        viewModel?.error.bind { message in
            DispatchQueue.main.async {
                self.landingView.tableview.isHidden = true
                self.landingView.errorLabel.isHidden = false
                self.landingView.errorLabel.text = message
            }
        }
    }
}




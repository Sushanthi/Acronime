//
//  AcromineVMTests.swift
//  AcromineTests
//
//  Created by Shanthi Nukala on 02/06/22.
//

import XCTest
import XCTest
@testable import Acromine


class AcromineVMTests: XCTestCase {
    
    var viewModel:AcromineLandingViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = AcromineLandingViewModel(manager: NetworkMock.shared)
        viewModel.retieveAcromines(acromine: "AIDS")
    }

    func testViewModel() {
        XCTAssertNil(AcrominesLandingVC(coder: NSCoder()))
        XCTAssertNil(AcrominesLandingView(coder: NSCoder()))

        let vc = AcrominesLandingVC(viewModel)
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.loadView())
        XCTAssertNotNil(vc.viewDidLoad())

        vc.landingView.layoutSubviews()
        XCTAssertNotNil(vc.landingView.layoutSubviews())
        XCTAssertNotNil(vc.landingView)
        XCTAssertNotNil(vc.landingView.viewModel)
        XCTAssertNotNil(vc.landingView.configureView())
        
        
        vc.landingView.searchBar.text = "AIDS"
        
        XCTAssertEqual(UITableView.automaticDimension, vc.landingView.tableView(vc.landingView.tableview, heightForRowAt: IndexPath(row: 0, section: 0)))
        
        let cellItem = vc.landingView.tableView(vc.landingView.tableview, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cellItem)
        let firstItem = self.viewModel.acromines.value.first?.lfs?[0]
        if let cell = cellItem as? AcromineLandingCell {
            cell.update(model: firstItem as Any)
            XCTAssertEqual(cell.nameLabel.text, firstItem?.lf)
        }
        XCTAssertTrue(vc.landingView.textFieldShouldClear(vc.landingView.searchBar.searchTextField))
        XCTAssertNotNil(vc.landingView.refreshTableViewContent())
    }
    
    func testViewModelFunctions() {
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(self.viewModel.acromines.value.count, 1)
        XCTAssertEqual(self.viewModel.acromines.value.first?.lfs?.count, 6)

    }
}

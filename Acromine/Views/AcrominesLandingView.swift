//
//  AcrominesLandingView.swift
//  Acromine
//
//  Created by Shanthi Nukala on 02/06/22.
//

import Foundation
import UIKit


class AcrominesLandingView: UIView {

    var viewModel:AcromineLandingViewModel?
    var tableview = UITableView()
    var searchBar = UISearchBar()
    var errorLabel = UILabel()
    
    var searchString = ""

    init(viewModel: AcromineLandingViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        configureView()
    }
    
    func configureView() {
        let guide = self.safeAreaLayoutGuide

        self.backgroundColor = .white
        
        self.addSubview(searchBar)
        searchBar.placeholder = "Search Acronyms"
        //searchBar.searchTextField.backgroundColor = .lightGray//UIColor(red: 1.0/255.0, green: 8.0/255.0, blue: 18.0/225.0, alpha: 1)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.delegate = self
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        //searchBar.tintColor = .darkGray
        searchBar.delegate = self
        searchBar.pin(top: guide.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 10, right: self.trailingAnchor, paddingRight: 10, centerX: nil, centerY: nil, width: 0, height: 35)

        
        self.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 160.0
        tableview.separatorStyle = .singleLine
        let nib = UINib(nibName: AcromineLandingCell.nibName, bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: AcromineLandingCell.identifier)

        tableview.tableFooterView = UIView()
        tableview.keyboardDismissMode = .onDrag
        tableview.pin(top: searchBar.bottomAnchor, paddingTop: 10, bottom: self.bottomAnchor, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 0, right: self.trailingAnchor, paddingRight: 0, centerX: nil, centerY: nil, width: 0, height: 0)
        
        self.addSubview(errorLabel)
        errorLabel.textColor = .black
        errorLabel.font = UIFont.systemFont(ofSize: 15)
        errorLabel.text = ""
        errorLabel.numberOfLines = 2
        errorLabel.textAlignment = .center
        errorLabel.pin(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 16, right: self.trailingAnchor, paddingRight: 16, centerX: self.centerXAnchor, centerY: self.centerYAnchor, width: 0, height: 40)


    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = bounds

    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
extension AcrominesLandingView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.acromines.value.first?.lfs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: AcromineLandingCell.identifier)
        let lfs = viewModel?.acromines.value.first?.lfs?[indexPath.row]
        if let cell = itemCell as? TableCellProtocol {
            cell.update(model: lfs as Any)
        }
        return itemCell ?? UITableViewCell()
    }
}
extension AcrominesLandingView : UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = searchBar.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        if updatedText.count >= 2 {
            searchString = updatedText
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(refreshTableViewContent), object: nil)
            self.perform(#selector(refreshTableViewContent), with: nil, afterDelay: 0.6)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.text = ""
        searchString = ""
        return true
    }
    @objc func refreshTableViewContent(){
        viewModel?.retieveAcromines(acromine: searchString)
    }
}

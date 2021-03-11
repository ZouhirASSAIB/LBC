//
//  CategoriesViewController.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 11/03/2021.
//

import UIKit

// MARK: - CategoriesViewController
class CategoriesViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterCategoriesProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
}

extension CategoriesViewController: PresenterToViewCategoriesProtocol{
    
    func deselectRowAt(row: Int) {
        self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
}

// MARK: - UITableView Delegate & Data Source
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = presenter?.numberOfRowsInSection() ?? 0
        
        numberOfRowsInSection == 0 ? self.tableView.setNoDataPlaceholder("No categories fetched yet.") :
            self.tableView.removeNoDataPlaceholder()
        
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.getCategoryName(indexPath: indexPath)
        let currentCategoryID = presenter?.getCategoryID(indexPath: indexPath)
        cell.accessoryType = presenter?.selectedCategoryID == currentCategoryID ? .checkmark : .none
        cell.tintColor = .orange
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
        presenter?.deselectRowAt(index: indexPath.row)
    }
}

// MARK: - UI Setup
extension CategoriesViewController {
    
    func setupUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}

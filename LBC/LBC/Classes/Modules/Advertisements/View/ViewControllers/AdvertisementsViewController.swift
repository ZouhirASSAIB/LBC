//
//  AdvertisementsViewController.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import UIKit

// MARK: - AdvertisementsViewController
class AdvertisementsViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterAdvertisementsProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdTableViewCell.self, forCellReuseIdentifier: AdTableViewCell.cellID)
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
}

extension AdvertisementsViewController: ActivityPresentable, ErrorPresentable {}

extension AdvertisementsViewController: PresenterToViewAdvertisementsProtocol{
    
    func onFetchAdvertisementsSuccess() {
        print("AdvertisementsViewController receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func onFetchAdvertisementsFailure(error: Error) {
        print("View receives the response from Presenter with error: \(error)")
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.present(error)
        }
    }
    
    func presentActivity() {
        DispatchQueue.main.async {
            self.presentActivity()
        }
    }
    
    func dismissActivity() {
        DispatchQueue.main.async {
            self.dismissActivity()
        }
    }
    
    func deselectRowAt(row: Int) {
        self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
}

// MARK: - UITableView Delegate & Data Source
extension AdvertisementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = presenter?.numberOfRowsInSection() ?? 0
        
        numberOfRowsInSection == 0 ? self.tableView.setNoDataPlaceholder("No Advertisements fetched, try pull to refresh data.") :
            self.tableView.removeNoDataPlaceholder()
        
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.cellID,
                                                       for: indexPath) as? AdTableViewCell else {
            return UITableViewCell()
        }
        
        let adImage = presenter?.getAdvertisementImage(indexPath: indexPath)
        let adTitle = presenter?.getAdvertisementTitle(indexPath: indexPath)
        let adPrice = presenter?.getAdvertisementPrice(indexPath: indexPath)
        let adCreationDate = presenter?.getAdvertisementCreationDate(indexPath: indexPath)
        let adCategoryName = presenter?.getAdvertisementCategoryName(indexPath: indexPath)
        let isAdUrgent = presenter?.isAdvertisementUrgent(indexPath: indexPath)
        
        cell.setCell(thumbURL: adImage, title: adTitle, price: adPrice,
                     creationDate: adCreationDate, categoryName: adCategoryName,
                     isUrgent: isAdUrgent)
              
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
        presenter?.deselectRowAt(index: indexPath.row)
    }
}

// MARK: - UI Setup
extension AdvertisementsViewController {
    
    func setupUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        let categoriesBarButtonItem = UIBarButtonItem(title: "Categories", style: .plain, target: self, action: #selector(showCategories))
        categoriesBarButtonItem.tintColor = .orange
        self.navigationItem.rightBarButtonItem = categoriesBarButtonItem
        
        self.view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.navigationItem.title = "LBC"
    }
}

// MARK: - Actions
extension AdvertisementsViewController {
    
    @objc func showCategories(sender: UIBarButtonItem) {
        presenter?.presentCategories()
    }
}

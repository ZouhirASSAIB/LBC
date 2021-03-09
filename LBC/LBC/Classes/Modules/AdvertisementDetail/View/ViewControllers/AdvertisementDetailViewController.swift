//
//  AdvertisementDetailViewController.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 09/03/2021.
//

import UIKit

// MARK: - AdvertisementDetailViewController
class AdvertisementDetailViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterAdvertisementDetailProtocol?
    
    lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
}

extension AdvertisementDetailViewController: PresenterToViewAdvertisementDetailProtocol {
    func onGetImageFromURLSuccess(smallURL: URL?, title: String?, description: String?,
                                  price: String?, creationDate: String?, categoryName: String?,
                                  isUrgent: Bool?, siret: String?) {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            self.descriptionLabel.text = description
            if let smallURL = smallURL {
                self.adImageView.loadImage(at: smallURL)
            }
            self.navigationItem.title = title
        }
    }
    
    func onGetImageFromURLFailure(title: String?, description: String?, price: String?, creationDate: String?, categoryName: String?, isUrgent: Bool?, siret: String?) {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            self.descriptionLabel.text = description
            self.navigationItem.title = title
        }
    }
}

// MARK: - UI Setup
extension AdvertisementDetailViewController {
    func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(adImageView)
        self.view.addSubview(descriptionLabel)
        
        let widthHeightConstant = self.view.frame.width * 0.8
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.widthAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: widthHeightConstant)
            .isActive = true
        adImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        adImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
            .isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: adImageView.bottomAnchor)
            .isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
    }
    
}

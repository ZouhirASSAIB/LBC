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
    
    lazy var advertisementImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Placeholder"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var advertisementTitleLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(bold: true, numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var advertisementPriceLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(textColor:.orange, fontSize: 14, bold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var advertisementCreationDateLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var advertisementDescriptionLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14, numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var subStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
}

extension AdvertisementDetailViewController: PresenterToViewAdvertisementDetailProtocol {
    
    func onGetImageFromURLSuccess(thumbImage: UIImage) {
        print("View receives the response from Presenter and updates itself.")
        
        DispatchQueue.main.async {
            self.advertisementImage.image = thumbImage
        }
    }
    
    func onGetImageFromURLFailure(title: String?, description: String?, price: String?, creationDate: String?, isUrgent: Bool?, siret: String?) {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            if let title = title, !title.isEmpty {
                self.advertisementTitleLabel.text = title
            }
            
            if let price = price, !price.isEmpty {
                self.advertisementPriceLabel.text = price
            }
            
            if let creationDate = creationDate, !creationDate.isEmpty {
                self.advertisementCreationDateLabel.text = creationDate
            }
            
            if let description = description, !description.isEmpty {
                self.advertisementDescriptionLabel.text = description
            }
        }
    }
}

// MARK: - UI Setup
extension AdvertisementDetailViewController {
    
    func setupScrollView() {
        
        // Add scroll view
        self.view.addSubview(self.scrollView)
        
        // Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true;
    }
    
    func setupUI() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        self.view.backgroundColor = .white
        
        self.setupScrollView()
        
        self.scrollView.addSubview(self.advertisementImage)
        
        self.advertisementImage.anchor(top: self.scrollView.topAnchor, left: self.scrollView.leftAnchor,
                                       bottom: nil, right: self.scrollView.rightAnchor,
                                       paddingTop: 0, paddingLeft: 0,
                                       paddingBottom: 0, paddingRight: 0,
                                       width: 0, height: 300, enableInsets: false)
        
        self.subStackView.addArrangedSubview(self.advertisementTitleLabel)
        self.subStackView.addArrangedSubview(self.advertisementPriceLabel)
        self.subStackView.addArrangedSubview(self.advertisementCreationDateLabel)
        self.subStackView.addArrangedSubview(self.advertisementDescriptionLabel)
        self.stackView.addArrangedSubview(subStackView)
        self.scrollView.addSubview(stackView)
        
        // Constrain stack view to scroll view
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.advertisementImage.bottomAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        // Add subStackView to handle Layout Margins
        self.subStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.subStackView.isLayoutMarginsRelativeArrangement = true
    }
}

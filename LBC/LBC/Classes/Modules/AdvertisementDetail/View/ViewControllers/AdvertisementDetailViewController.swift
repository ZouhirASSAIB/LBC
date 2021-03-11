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
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
    
    lazy var advertisementImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PlaceholderImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(displayFullScreenImage))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var advertisementFullScreenImage : UIImageView = {
        let fullScreenImageView = UIImageView(image:  self.advertisementImage.image)
        fullScreenImageView.frame = self.view.frame
        fullScreenImageView.backgroundColor = .black
        fullScreenImageView.contentMode = .scaleAspectFit
        fullScreenImageView.isUserInteractionEnabled = true
        fullScreenImageView.addGestureRecognizer(tap)
        return fullScreenImageView
    }()
    
    lazy var dismissButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseImage"), for: .normal)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseImage"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
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
    
    lazy var advertisementUrgentImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "UrgentImage"))
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var advertisementDescriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.basicUILabel(fontSize: 14, bold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var advertisementDescriptionValueLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14, numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var advertisementSiretLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14, textAlignment: .center)
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
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var subStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var horizontalStackView : UIStackView = {
        let stackView = UIStackView(frame: self.subStackView.frame)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

extension AdvertisementDetailViewController: PresenterToViewAdvertisementDetailProtocol {
    
    func onGetImageFromURLSuccess(thumbImage: UIImage) {
        print("AdvertisementDetailViewController receives the success response from Presenter and updates itself.")
        
        DispatchQueue.main.async {
            self.advertisementImage.image = thumbImage
        }
    }
    
    func onGetImageFromURLFailure(title: String?, description: String?, price: String?, creationDate: String?, isUrgent: Bool?, siret: String?) {
        print("AdvertisementDetailViewController receives the failure response from Presenter and updates itself.")
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
            
            if let isUrgent = isUrgent, !isUrgent {
                self.advertisementUrgentImage.isHidden = !isUrgent
            }
            
            if let description = description, !description.isEmpty {
                self.advertisementDescriptionValueLabel.text = description
            }
            
            if let siret = siret, !siret.isEmpty {
                self.advertisementSiretLabel.text = "N° SIREN \(siret.replacingOccurrences(of: " ", with: ""))"
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
        
        self.advertisementImage.addSubview(self.dismissButton)
        
        self.dismissButton.anchor(top: self.scrollView.topAnchor, left: self.scrollView.leftAnchor,
                                        bottom: nil, right: nil,
                                        paddingTop: 15, paddingLeft: 15,
                                        paddingBottom: 0, paddingRight: 0,
                                        width: 30, height: 30, enableInsets: false)
        
        self.advertisementImage.anchor(top: self.scrollView.topAnchor, left: self.scrollView.leftAnchor,
                                       bottom: nil, right: self.scrollView.rightAnchor,
                                       paddingTop: 0, paddingLeft: 0,
                                       paddingBottom: 0, paddingRight: 0,
                                       width: 0, height: 250, enableInsets: false)
        
        self.subStackView.addArrangedSubview(self.advertisementTitleLabel)
        self.subStackView.addArrangedSubview(self.advertisementPriceLabel)
        self.horizontalStackView.addArrangedSubview(self.advertisementCreationDateLabel)
        self.horizontalStackView.addArrangedSubview(self.advertisementUrgentImage)
        self.subStackView.addArrangedSubview(horizontalStackView)
        self.subStackView.addArrangedSubview(self.advertisementDescriptionLabel)
        self.subStackView.addArrangedSubview(self.advertisementDescriptionValueLabel)
        self.subStackView.addArrangedSubview(self.advertisementSiretLabel)
        
        self.stackView.addArrangedSubview(subStackView)
        self.scrollView.addSubview(stackView)
        
        // Constrain stack view to scroll view
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.advertisementImage.bottomAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
}

// MARK: - Actions
extension AdvertisementDetailViewController {
    
    @objc func dismiss(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func close(sender: UIButton) {
       self.dismissFullScreenImage(sender: self.tap)
    }
    
    @objc func displayFullScreenImage(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.addSubview(self.advertisementFullScreenImage)
            self.advertisementFullScreenImage.addSubview(self.closeButton)
            self.closeButton.anchor(top: self.scrollView.topAnchor, left: nil,
                                            bottom: nil, right: self.scrollView.rightAnchor,
                                            paddingTop: 15, paddingLeft: 0,
                                            paddingBottom: 0, paddingRight: 15,
                                            width: 30, height: 30, enableInsets: false)
        }
    }
    
    @objc func dismissFullScreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}

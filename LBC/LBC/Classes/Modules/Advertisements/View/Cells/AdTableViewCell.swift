//
//  AdTableViewCell.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import UIKit

class AdTableViewCell : UITableViewCell {
    
    public static let cellID = "AdTableViewCell"
    
    var advertisement : AdvertisementModel? {
        didSet {
            
            if let thumb = advertisement?.imagesURL?.thumb,
               let thumbURL = URL(string:thumb) {
                advertisementImage.loadImage(at: thumbURL)
            }
            
            advertisementTitleLabel.text = advertisement?.title
            
            if let price = advertisement?.price {
                advertisementPriceLabel.text =  NumberFormatter.localizedString(from: NSNumber(value: price), number: .currency)
            }
            
            if let creationDate = advertisement?.creationDate,
               let realDate = AppDateFormatter.shared.isoDate(from: creationDate) {
                advertisementCreationDateLabel.text = AppDateFormatter.shared.longDateShortTimeString(from: realDate)
            }
            
//            advertisementCategoryLabel.text = advertisement?.categoryID
//            advertisementUrgentImage.image = UIImage(named: "urgent")
        }
    }
    
    private let advertisementTitleLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(bold: true)
        return label
    }()
    
    private let advertisementPriceLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel()
        return label
    }()
    
    private let advertisementCreationDateLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel()
        return label
    }()
    
    private let advertisementCategoryLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel()
        return label
    }()
    
    private let advertisementImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let advertisementUrgentImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AdTableViewCell.cellID)
        addSubview(advertisementImage)
        
        advertisementImage.anchor(top: topAnchor, left: leftAnchor,
                                  bottom: bottomAnchor, right: nil,
                                  paddingTop: 5, paddingLeft: 5,
                                  paddingBottom: 5, paddingRight: 0,
                                  width: 90, height: 0, enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [advertisementTitleLabel,advertisementPriceLabel,
                                                       advertisementCreationDateLabel,advertisementCategoryLabel,
                                                       advertisementUrgentImage])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: advertisementImage.rightAnchor,
                         bottom: bottomAnchor, right: rightAnchor,
                         paddingTop: 5, paddingLeft: 5,
                         paddingBottom: 5, paddingRight: 5,
                         width: 0, height: 0, enableInsets: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertisementImage.image = nil
        advertisementImage.cancelImageLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

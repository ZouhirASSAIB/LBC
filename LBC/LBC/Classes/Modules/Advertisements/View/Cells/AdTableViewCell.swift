//
//  AdTableViewCell.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import UIKit

class AdTableViewCell : UITableViewCell {
    
    public static let cellID = "AdTableViewCell"
    
    func setCell(thumbURL:URL?, title: String?, price: String?,
                 creationDate: String?, categoryName: String?,
                 isUrgent:Bool?) {
        
        if let thumbURL = thumbURL {
            advertisementImage.loadImage(at: thumbURL)
        }
        
        advertisementTitleLabel.text = title
        advertisementPriceLabel.text = price
        advertisementCreationDateLabel.text = creationDate
        advertisementCategoryLabel.text = categoryName
        advertisementUrgentLabel.isHidden = !(isUrgent ?? true)
    }
    
    private let advertisementTitleLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(bold: true, numberOfLines: 2)
        return label
    }()
    
    private let advertisementPriceLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(textColor:.orange, fontSize: 14, bold: true)
        return label
    }()
    
    private let advertisementCreationDateLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14)
        return label
    }()
    
    private let advertisementCategoryLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(fontSize: 14)
        return label
    }()
    
    private let advertisementImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PlaceholderImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let advertisementUrgentLabel : UILabel = {
        let label = UILabel()
        label.basicUILabel(textColor:.orange, fontSize: 12,
                           bold: true, textAlignment: .center,
                           borderWidth: 1, borderColor: UIColor.orange.cgColor,
                           cornerRadius: 3, backgroundColor: UIColor.white.cgColor)
        label.text = "URGENT"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: AdTableViewCell.cellID)
        addSubview(advertisementImage)
        advertisementImage.addSubview(advertisementUrgentLabel)
        
        advertisementImage.anchor(top: topAnchor, left: leftAnchor,
                                  bottom: bottomAnchor, right: nil,
                                  paddingTop: 0, paddingLeft: 10,
                                  paddingBottom: 0, paddingRight: 0,
                                  width: 120, height: 0, enableInsets: false)
        
        advertisementUrgentLabel.anchor(top: topAnchor, left: leftAnchor,
                                        bottom: nil, right: nil,
                                        paddingTop: 15, paddingLeft: 15,
                                        paddingBottom: 0, paddingRight: 0,
                                        width: 70, height: 15, enableInsets: false)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [advertisementTitleLabel,advertisementPriceLabel,
                                                       advertisementCategoryLabel, advertisementCreationDateLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: advertisementImage.rightAnchor,
                         bottom: bottomAnchor, right: rightAnchor,
                         paddingTop: 5, paddingLeft: 10,
                         paddingBottom: 5, paddingRight: 5,
                         width: 0, height: 0, enableInsets: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        advertisementImage.image = UIImage(named: "PlaceholderImage")
        advertisementImage.cancelImageLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

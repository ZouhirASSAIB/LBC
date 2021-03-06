//
//  UIImageView+Extension.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import UIKit

// MARK: -  UIImage+Extension
extension UIImageView {
    
    func loadImage(at url: URL) {
        UIImageLoader.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}

//
//  UILabel+Extension.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import UIKit

extension UILabel {
    func basicUILabel(textColor: UIColor = .black,
                 fontSize:CGFloat = 16,
                 bold:Bool = false,
                 textAlignment:NSTextAlignment = .left,
                 numberOfLines:Int = 1) {
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.numberOfLines = numberOfLines
        self.sizeToFit()
    }
}

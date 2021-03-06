//
//  UITableView+Extension.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 06/03/2021.
//

import UIKit

// MARK: - UITableView+Extension
extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: self.bounds.size.width,
                                          height: self.bounds.size.height))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = message
        label.sizeToFit()
        self.backgroundView = label
    }
    
    func removeNoDataPlaceholder() {
        self.backgroundView = nil
    }
}

//
//  UITableView+Extention.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(_ cellReuseIdentifier: String) {
        self.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func scrollToBottom() {
        guard self.numberOfRows(inSection: 0) > 0 else {
            return
        }
        DispatchQueue.main.async {
            guard self.numberOfSections > 0, self.numberOfRows(inSection: self.numberOfSections-1) > 0 else {
                return
            }
            let indexPath = IndexPath.init(row: self.numberOfRows(inSection: self.numberOfSections-1)-1, section: self.numberOfSections-1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

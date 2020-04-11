//
//  UICollectionView+Extention.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//
import Foundation
import UIKit

extension UICollectionView {
    func registerCell(_ cellReuseIdentifier: String) {
        self.register(UINib.init(nibName: cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
    }
}

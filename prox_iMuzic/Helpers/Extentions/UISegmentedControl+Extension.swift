//
//  File.swift
//  prox_iMuzic
//
//  Created by Nguyen Trung Hieu on 4/9/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl {

// create a 1x1 image with this color
private func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor);
    context!.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!
}

func removeBackgroundColors() {
    self.setBackgroundImage(imageWithColor(color: .clear), for: .normal, barMetrics: .default)
    self.setBackgroundImage(imageWithColor(color: .clear), for: .selected, barMetrics: .default)
    self.setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
}

struct viewPosition {
    let originX: CGFloat
    let originIndex: Int
}

func updateTintColor(selected: UIColor, normal: UIColor) {
    let views = self.subviews
    var positions = [viewPosition]()
    for (i, view) in views.enumerated() {
        let position = viewPosition(originX: view.frame.origin.x, originIndex: i)
        positions.append(position)
    }
    positions.sort(by: { $0.originX < $1.originX })

    for (i, position) in positions.enumerated() {
        let view = self.subviews[position.originIndex]
        if i == self.selectedSegmentIndex {
            view.tintColor = selected
        } else {
            view.tintColor = normal
        }
    }
}
}

//
//  UiTextField+Extention.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/6/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func addRightImage(_ strImgname: String){
        let imageView = UIImageView(image: UIImage(named: strImgname))
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width , height: imageView.image!.size.height)
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: imageView.image!.size.height))
        paddingView.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = paddingView
    }
    
    func addLeftImage(_ strImage: String) {
        let imageView = UIImageView(image: UIImage(named: strImage))
        imageView.frame = CGRect(x: 10, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
        let leftview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: imageView.image!.size.height))
        leftview.addSubview(imageView)
        self.leftView = leftview
        self.leftViewMode = .always
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

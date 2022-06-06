//
//  UILabelExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//


import UIKit

//MARK: UILabel
extension UILabel {
    public func setUpGenLabel(text:String, textColor:UIColor = .black, font:UIFont, numberOfLines:Int = 1,textAlignment:NSTextAlignment = .left){
        self.text = text
        self.font = font
        self.textColor = textColor
        self.sizeToFit()
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

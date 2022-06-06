//
//  UIImageExtension.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//


import UIKit
import Kingfisher

extension UIImageView {
    public func setUpImageView(image:String, contentMode:UIView.ContentMode = .scaleAspectFill, cornerRadius:CGFloat = 0.0){
        self.image = UIImage(named: image)
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func loadImageUsingKingFisher(urlString:String,placeholder:String, cornerRadius:CGFloat){
        let image = UIImage(named: placeholder)
        let url = URL(string:urlString)
        let processor = RoundCornerImageProcessor(cornerRadius:cornerRadius)
        self.kf.setImage(with: url,placeholder: image, options: [.processor(processor)])
    }
}

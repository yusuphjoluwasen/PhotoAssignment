//
//  UiViewExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//

import UIKit

extension UIView{
    public func setUpView(bgColor:UIColor = .clear, cornerRadius:CGFloat = 0.0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
    }
}

extension UICollectionView{
    public func setUpCollectionView(bgColor:UIColor = .clear){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = bgColor
    }
}

extension UIScrollView{
    func atBottom(_ collection:UIScrollView) -> Bool{
        let position = self.contentOffset.y
        if position != 0.0{
            if position > (collection.contentSize.height - 100 - self.frame.size.height){
               return true
            }else{
                
            }
        }
        return false
    }
}





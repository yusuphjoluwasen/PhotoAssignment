//
//  TableLoader.swift
//  PhotosAssignment
//
//  Created by Guru on 05/06/2022.
//

import UIKit
class TableLoader{
    static let shared = TableLoader()
    
    let spinner = UIActivityIndicatorView()
    
     func spinnerFooter(_ parent:UIView) -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: parent.frame.size.width, height: 100))
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        return footerView
    }
    
    func show() {
        spinner.startAnimating()
    }
    
    func hide() {
        spinner.stopAnimating()
    }
    
    
}

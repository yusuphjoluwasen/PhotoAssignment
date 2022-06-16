//
//  ViewControllerExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//


import UIKit

extension UIViewController{
    public func simpleAlert(alertType:UIAlertController.Style? = .alert, title:String?, message:String = ""){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: alertType ?? .alert)
        actionSheet.addAction(UIAlertAction(title: "OKAY", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    public func setUpNavigationTitle(_ title:String?){
        self.navigationItem.title = title
    }
}


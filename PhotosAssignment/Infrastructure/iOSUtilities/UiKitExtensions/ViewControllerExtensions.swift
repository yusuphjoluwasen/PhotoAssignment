//
//  ViewControllerExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//


import UIKit

extension UIViewController{
    public func setupNavSettings(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: nil)
    }
    
    public func simpleAlert(alertType:UIAlertController.Style? = .alert, title:String?, message:String = ""){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: alertType ?? .alert)
        actionSheet.addAction(UIAlertAction(title: "OKAY", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    public func setUpNavigationTitle(_ title:String){
        self.navigationItem.title = title
    }
    
    public func setUpBackButtonItemColor(){
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}

public func setUpDidHighlightCellAnimation(action:@escaping () -> Void){
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
        action()
    }, completion: nil)
}

public func setUpDidUnHighlightCellAnimation(action:@escaping () -> Void){
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
       
    }, completion: nil)
}



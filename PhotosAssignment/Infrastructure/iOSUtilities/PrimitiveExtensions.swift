//
//  StringExtensions.swift
//  Evaluation
//
//  Created by Guru on 28/05/2022.
//

import Foundation

extension Int {
    var doubleValue: Double {
        return Double(self)
    }
    
    func toString() -> String {
        return  String(describing: self )
    }
}

extension Double {
    func toString() -> String {
        return  String(describing: self )
    }
}

extension String {
    func toInt()->Int{
        return (self as NSString).integerValue
    }
}

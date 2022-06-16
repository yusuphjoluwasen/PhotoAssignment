//
//  GeneralFunctions.swift
//  PhotosAssignment
//
//  Created by Guru on 06/06/2022.
//

import Foundation
import UIKit

func resolveResponse<T:Any>(_ data:[T]?, _ err:String?, _ completion: @escaping ([T]?, String?) -> Void){
    if let err = err {
        completion(nil, err)
    }
    if let data = data{
        completion(data, nil)
    }
}

func doNothing(){}

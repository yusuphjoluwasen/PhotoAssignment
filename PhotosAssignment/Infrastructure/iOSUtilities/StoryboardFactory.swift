//
//  StoryboardFactory.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import UIKit

class StoryboardInitializable{
    static func initFromStoryboard(name: String = "Main", storyboardIdentifier:String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
    }
}

//
//  SceneDelegate.swift
//  PhotosAssignment
//
//  Created by Guru on 02/06/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        composeDependencies()
    }
}

extension SceneDelegate {
    func composeDependencies() {
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}


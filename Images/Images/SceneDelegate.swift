//
//  SceneDelegate.swift
//  Images
//
//  Created by 2lup on 30.10.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        guard let safeWindow = window else { return }
        let imagesViewController = ImagesViewController()
        let navigationController = UINavigationController(rootViewController: imagesViewController)
        safeWindow.rootViewController = navigationController
        safeWindow.makeKeyAndVisible()
    }
}

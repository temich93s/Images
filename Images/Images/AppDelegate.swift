//
//  AppDelegate.swift
//  Images
//
//  Created by 2lup on 30.10.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            if #available(iOS 13, *) { } else {
                window = UIWindow()
                guard let safeWindow = window else { return false }
                let imagesViewController = ImagesViewController()
                let navigationController = UINavigationController(rootViewController: imagesViewController)
                safeWindow.rootViewController = navigationController
                safeWindow.makeKeyAndVisible()
            }
            return true
    }
}

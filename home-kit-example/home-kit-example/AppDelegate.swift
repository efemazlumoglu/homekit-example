//
//  AppDelegate.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigation = window!.rootViewController as! UINavigationController
        let target = navigation.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigation.pushViewController(target, animated: false)
        return true
    }

}


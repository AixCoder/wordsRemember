//
//  AppDelegate.swift
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/1.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let tabBarController: HomeTabBarController = HomeTabBarController.init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//WordViewController
        let wordVC = WordViewController.init()
        wordVC.tabBarItem.title = "一言"
//        tabBarController.addChild(wordVC)
        
        let articleVC = ArticleSummaryViewController.init()
//        tabBarController.addChild(articleVC)
        let articleRootNav = UINavigationController.init(rootViewController: articleVC)
        articleRootNav.tabBarItem.title = "阅读"
        
        tabBarController.setViewControllers([wordVC, articleRootNav], animated: false)
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()

        #if DEBUG
            Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
        return true
    }


}


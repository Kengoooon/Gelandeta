//
//  AppDelegate.swift
//  GelanData
//
//  Created by 藤本健悟 on 2017/02/08.
//  Copyright © 2017年 kengo. All rights reserved.
//

import UIKit
import GoogleMaps;
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let cGoogleMapsAPIKey = "AIzaSyAB0vfMdryt9KtBtOOXKfZUr5YrjoI0q0k"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Google Mapsの初期設定
        GMSServices.provideAPIKey(cGoogleMapsAPIKey)
        Fabric.with([Twitter.self])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}


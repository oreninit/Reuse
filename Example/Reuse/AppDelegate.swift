//
//  AppDelegate.swift
//  Reuse
//
//  Created by OreniOS on 03/28/2018.
//  Copyright (c) 2018 OreniOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: Navigator?
    lazy var data: PeopleDatabase = PeopleDatabase()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        navigator = ApplicationNavigator(navigationController: window?.rootViewController as? UINavigationController)
        navigator?.showTable(of: data)
        
        return true
    }
}

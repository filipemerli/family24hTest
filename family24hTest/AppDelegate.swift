//
//  AppDelegate.swift
//  family24hTest
//
//  Created by Filipe Merli on 18/03/2019.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func verificarFirstLaunch() {
        if(UserDefaults.standard.bool(forKey: "jaFoiFirstLaunch")) {
            //Nada por enquanto
        } else {
            UserDefaults.standard.set(true, forKey: "jaFoiFirstLaunch")
            UserDefaults.standard.set(false, forKey: "userPermiteFotos")
            UserDefaults.standard.synchronize()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        verificarFirstLaunch()
        return true
    }


}


//
//  AppDelegate.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit


var fuelingList = [Fueling]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let fuel1 = Fueling()
        fuel1.id = 1
        fuel1.lat = 55.746574
        fuel1.lng = 37.601494
        fuel1.name = "Автозаправка Shell"
        fuel1.distance = "0,3 км"
        fuel1.address = "ул. Садовническая, 57"
        fuel1.cost = "35.5"
        fuel1.time = "час назад"
        
        let fuel2 = Fueling()
        fuel2.id = 2
        fuel2.lat = 55.750931
        fuel2.lng = 37.601237
        fuel2.name = "Газпром"
        fuel2.distance = "1,3 км"
        fuel2.address = "ул. Карла-Маркса, 112"
        fuel2.cost = "35.5"
        fuel2.time = "час назад"
        
        let fuel3 = Fueling()
        fuel3.id = 3
        fuel3.lat = 55.746404
        fuel3.lng = 37.607545
        fuel3.name = "Газпром"
        fuel3.distance = "5,3 км"
        fuel3.address = "ул. Первомайская, 33"
        fuel3.cost = "35.5"
        fuel3.time = "час назад"
        
        fuelingList.append(fuel1)
        fuelingList.append(fuel2)
        fuelingList.append(fuel3)
        
        return true
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


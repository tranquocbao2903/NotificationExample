//
//  AppDelegate.swift
//  NotificationExample
//
//  Created by Bao on 2/16/17.
//  Copyright © 2017 TMA Solutions. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    static var mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.registerForRemoteNotification()
        
//        // iOS 10 support
//        if #available(iOS 10, *) {
//            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
//            application.registerForRemoteNotifications()
//        }
//            // iOS 9 support
//        else if #available(iOS 9, *) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//            // iOS 8 support
//        else if #available(iOS 8, *) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//            // iOS 7 support
//        else {  
//            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
//        }

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

//    // Called when APNs has assigned the device a unique token
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // Convert token to string
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//        
//        // Print it to console
//        print("APNs device token: \(deviceTokenString)")
//        
//        // Persist it in your backend in case it's new
//    }
//    
//    // Called when APNs failed to register the device for push notifications
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        // Print the error to console (you should alert the user that registration failed)
//        print("APNs registration failed: \(error)")
//    }
//    
//    // Push notification received
//    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
//        // Print notification payload data
//        print("Push notification received: \(data)")
//    }
    
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //print("User Info = ",notification.request.content.userInfo)
        
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //print("User Info = ",response.notification.request.content.userInfo)
        
        //print(response.notification.request.identifier)
        
        let taskDetailViewController = AppDelegate.mainStoryBoard.instantiateViewController(withIdentifier: "TaskDetailViewController") as! TaskDetailViewController
        
        let taskItem = TaskItem(name: response.notification.request.content.title, deadline: Date(), UUID: response.notification.request.identifier)
        
        taskDetailViewController.taskItem = taskItem
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.pushViewController(taskDetailViewController, animated: true)
        
        completionHandler()
    }
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
}


//
//  AppDelegate.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  The AppDelegate class is extended with Google Firebase and a request for permission to send notifications.

import UIKit
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    /// link Google Firebase to application
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let center = UNUserNotificationCenter.current()
        
        // ask for permission to show notifications
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("testing")
                self.createNotificationSchedule()
                
            }
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        // don't create notifications if disabled
        notificationCenter.getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else {
                return
            }
        }
        
        
        return true
    }
    
    /// create schedule for repeating notification
    func createNotificationSchedule() {
        let content = UNMutableNotificationContent()
        content.title = "Do you eat at home tonight?"
        content.body = "Set availability in app"
        
        // configure the recurring time
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        // schedule at 17:00
        dateComponents.hour = 17
        
        // create the trigger as a repeating event
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // schedule the request with the system
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
        }
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


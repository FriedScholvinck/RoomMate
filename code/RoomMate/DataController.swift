//
//  RoomMateController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This shared class holds function to collect all data from Firebase Realtime Database. Below is also a function that checks if the device is connected to the internet. All these functions are called from getAllData() in Extensions.swift.

import Foundation
import UIKit
import Firebase
import SystemConfiguration

class DataController {
    static let shared = DataController()
    let ref = Database.database().reference()
    
    /// call functions to get user and house data correctly into structs
    func getUserAndHouseData(completion: @escaping () -> Void) {
        
        // because the completion is not able to know whether getUsers() or getHouses() will be finished first, it waits for finished to become 2
        var finished = 0
        deleteExistingData()
        
        getUsers { ()
            finished += 1
            if finished == 2 {
                completion()
            }
        }
        
        getHouses { ()
            finished += 1
            if finished == 2 {
                completion()
            }
        }
    }
    
    /// empty existing dictionaries in structs
    func deleteExistingData() {
        CurrentUser.houses = [:]
        CurrentUser.users = [:]
    }
    
    /// get users from Firebase into structs
    func getUsers(completion: @escaping () -> Void) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            for (key, value) in data {
                
                // use key (Firebase uid) as user id in structs as well
                var user = User()
                user.id = key
                
                // set other variables
                let userData = value as! Dictionary <String, Any>
                user.name = userData["name"]! as! String
                user.email = userData["email"]! as! String
                user.drinks = userData["drinks"] as! Int
                user.drinksToBuy = userData["drinksToBuy"] as! Int
                user.dinner = userData["dinner"] as! Bool
                
                // house is an optional
                if let house = userData["house"] {
                    user.house = (house as! String)
                }
                
                // put user into dicitonary with uid as key
                CurrentUser.users[user.id] = user
            }
            
            // when data is loaded, set current user
            DispatchQueue.main.async {
                
                // house is optional
                if let houseName = CurrentUser.users[CurrentUser.user.id]!.house {
                    CurrentUser.user.house = houseName
                }
                
                // set other variables + reference to user in Firebase Database
                CurrentUser.user.drinks = CurrentUser.users[CurrentUser.user.id]!.drinks
                CurrentUser.user.drinksToBuy = CurrentUser.users[CurrentUser.user.id]!.drinksToBuy
                CurrentUser.user.dinner = CurrentUser.users[CurrentUser.user.id]!.dinner
                CurrentUser.ref = self.ref.child("users/\(CurrentUser.user.id)")
            }
            
            completion()
        })
    }
    
    /// get houses from Firebase into structs, the same as the above function for users
    func getHouses(completion: @escaping () -> Void) {
        ref.child("houses").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            for (key, value) in data {
                
                // house name
                var house = House()
                house.name = key
                
                // password & drinks
                let houseData = value as! Dictionary <String, Any>
                house.password = houseData["password"]! as! String
                house.drinks = houseData["drinks"]! as! Int
                house.firstWeek = houseData["firstWeek"] as! Int
                
                // residents, sort them alphabetically so the cleaning schedule will maintain its order
                let residentData = houseData["residents"]! as! Dictionary <String, Any>
                for resident in residentData.keys {
                    house.residents.append(resident)
                }
                house.residents = house.residents.sorted()
                
                // tasks, also sort them to maintain cleaning schedule order
                let tasksData = houseData["tasks"]! as! Dictionary <String, Any>
                for task in tasksData.keys {
                    house.tasks.append(task)
                }
                house.tasks  = house.tasks.sorted()
                
                // remove default task (set whenever a house is created)
                if house.tasks[0] == "default" {
                    house.tasks.remove(at: 0)
                }
                
                // set house in dictionary with name as key
                CurrentUser.houses[house.name] = house
            }
            
            completion()
        })
    }
    
    /// checks for internet connection, code from youtube video (https://www.youtube.com/watch?v=WYPrSBI243A)
    func checkInternetConnection() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // working for cellular and wifi
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}

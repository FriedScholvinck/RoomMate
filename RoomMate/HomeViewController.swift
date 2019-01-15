//
//  HomeViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  COMMMENTS

import UIKit
import Firebase


class HomeViewController: UIViewController {
    let ref = Database.database().reference()
    
    
    @IBOutlet weak var toDoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoButton.applyDesign()
        
        getUsers()
        getHouses()
    }
    
    func getUsers() {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            for (key, value) in data {
                
                // id
                var user = User()
                user.id = key
                
                // name, email, drinks
                let houseData = value as! Dictionary <String, Any>
                user.name = houseData["name"]! as! String
                user.email = houseData["email"]! as! String
                user.drinks = houseData["drinks"] as! Int
                
                // house
                if let house = houseData["house"] {
                    user.house = (house as! String)
                }
                
                
                CurrentUser.users[user.id] = user
                
                DispatchQueue.main.async {
                    
                    // set house of current user
                    if let house = CurrentUser.users[CurrentUser.user.id]!.house {
                        CurrentUser.user.house = house
                    }
                    
                    CurrentUser.user.drinks = CurrentUser.users[CurrentUser.user.id]!.drinks
                    CurrentUser.ref = self.ref.child("users/\(CurrentUser.user.id)")
                }
            }
        })
    }
    
    func getHouses() {
        ref.child("houses").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            for (key, value) in data {
                // name
                var house = House()
                house.name = key
                
                // password & drinks
                let houseData = value as! Dictionary <String, Any>
                house.password = houseData["password"]! as! String
                house.drinks = houseData["drinks"]! as! Int
                
                // residents
                let residentData = houseData["residents"]! as! Dictionary <String, Any>
                for resident in residentData.keys {
                    house.residents.append(resident)
                }
                
                CurrentUser.houses[house.name] = house
                
            }
            DispatchQueue.main.async {
                
            }
        })
    }
    
    
    
}

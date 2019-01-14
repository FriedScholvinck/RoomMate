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
    var users: [User] = []
    var houses: [House] = []
    var uid: String = ""
    
    @IBOutlet weak var toDoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoButton.applyDesign()
        getUserInfo()
        getHouseInfo()
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        getUserInfo()
        getHouseInfo()
    }
    
    @IBAction func toDoButtonTapped(_ sender: UIButton) {

        
    }
    
    /// call getUsers() to download from local server
    func getUserInfo() {
        DataController.shared.getUsers() { (users) in
            if let users = users {
                self.users = users
            }
            DispatchQueue.main.async {
                self.makeUserDictionary()
            }
        }
    }
    
    /// call getHouses() to download from local server
    func getHouseInfo() {
        DataController.shared.getHouses() { (houses) in
            if let houses = houses {
                self.houses = houses
            }
            DispatchQueue.main.async {
                self.makeHouseDictionary()
            }
        }
    }
    
    /// put all users in global dictionary
    func makeUserDictionary() {
        for user in users {
            CurrentUser.users[user.id] = user
        }
    }
    
    /// put all houses in global dictionary
    func makeHouseDictionary() {
        for house in houses {
            CurrentUser.houses[house.name] = house
        }
    }
        
}

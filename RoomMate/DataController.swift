//
//  RoomMateController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import Foundation
import UIKit

class DataController {
    static let shared = DataController()
    
    /// get all users from local server
    func getUsers(completion: @escaping ([User]?) -> Void) {
        let url = URL(string: "https://ide50-fried-scholvinck.legacy.cs50.io:8080/users")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(users)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    /// get all houses from local server
    func getHouses(completion: @escaping ([House]?) -> Void) {
        let url = URL(string: "https://ide50-fried-scholvinck.legacy.cs50.io:8080/houses")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    
                    let houses = try JSONDecoder().decode([House].self, from: data)
                    completion(houses)
                } else {
                    completion(nil)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    /// upload new user to local server
    func createNewUser(id: String, name: String, email: String) {
        let url = URL(string: "https://ide50-fried-scholvinck.legacy.cs50.io:8080/users")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "id=\(id)&name=\(name)&email=\(email)&house="
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
        task.resume()
    }
    
    /// upload new house to local server
    func createNewHouse(name: String, password: String, residents: [String]) {
        let url = URL(string: "https://ide50-fried-scholvinck.legacy.cs50.io:8080/houses")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name)&password=\(password)&residents=\(residents)&drinks=0"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
        task.resume()
    }
    
    
    
}


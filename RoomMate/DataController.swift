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
    
}


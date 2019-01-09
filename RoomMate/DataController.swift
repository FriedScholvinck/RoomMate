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
    
    func getUser(completion: @escaping (User?) -> Void) {
        let url = URL(string: "https://ide50-fried-scholvinck.cs50.io:8080/list")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(user)
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

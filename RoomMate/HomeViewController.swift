//
//  HomeViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var users: [User] = []
    var houses: [House] = []
    
    @IBOutlet weak var toDoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoButton.applyDesign()
        getUserInfo()
    }
    
    func getUserInfo() {
        DataController.shared.getUsers() { (users) in
            if let users = users {
                self.users = users
            }
            DispatchQueue.main.async {
                print(users!)
                print("test")
            }
            print("TEST")
        }
    }
    
    
    func loadData() {
        let url = URL(string: "https://ide50-fried-scholvinck.legacy.cs50.io:8080/users")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = ""
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeViewController.swift
//  RoomMate
//
//  Created by Fried on 07/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  

import UIKit
import Firebase

class HomeViewController: UIViewController {
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    /// get data from database again
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        getData()
    }
    
    
    
}

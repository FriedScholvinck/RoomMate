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
        getData()
        toDoButton.applyDesign()
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        getData()
    }
    
    
    
}

//
//  AboutViewController.swift
//  RoomMate
//
//  Created by Fried on 17/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    var text = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.scrollsToTop = false
    }
    
    func makeText() {
        text = " - Home\nHome View\n\n - Clean\nAdd house tasks to be divided by the system on a 5 week schedule. Simply create a new schedule when you want to change the current one.\n\n - Drinks\nAdd beer drinking information for all your Room Mates. Drinks Behind tells you how many you have to buy. Press 'Drink One' whenever you \n\n - Profile\nJoin or create your house and ask your Room Mates to join with the correct password."
    }

    

}

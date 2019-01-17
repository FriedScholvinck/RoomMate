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
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeText()
    }
    
    func makeText() {
        text = "Home\n\n\n\nClean\n\n\nDrinks\nThis is a system for that holds beer drinking information for all your Room Mates\n\nProfile\n"
        infoLabel.text = text
    }

    

}

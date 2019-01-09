//
//  NewHouseViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//

import UIKit

class NewHouseViewController: UIViewController {

    @IBOutlet weak var addRoomMatesLabel: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var plusTextfieldButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.applyDesign()
        // Do any additional setup after loading the view.
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

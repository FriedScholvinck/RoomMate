//
//  AboutViewController.swift
//  RoomMate
//
//  Created by Fried on 17/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view controller contains a scroll view that holds information about the application.

import UIKit


class AboutViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.scrollsToTop = false
    }
}

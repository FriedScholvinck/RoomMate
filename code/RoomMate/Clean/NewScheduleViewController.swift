//
//  NewScheduleViewController.swift
//  RoomMate
//
//  Created by Fried on 09/01/2019.
//  Copyright © 2019 Fried. All rights reserved.
//
//  This view contoller holds the functionality for creating a new cleaning schedule. The user adds house tasks by typing the task in the textfield and pressing the plus button. The tasks will be shown in a table view and only be saved when the save button is tapped. The user will be redirected to the CleanViewController and presented with the updated schedule.

import UIKit
import Firebase

class NewScheduleViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    let ref = Database.database().reference()
    var tasks: [String] = []
    
    @IBOutlet weak var addHouseTasksLabel: UILabel!
    @IBOutlet weak var taskTextfield1: UITextField!
    @IBOutlet weak var plusTaskButton: UIButton!
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextfield1.delegate = self
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    /// save tasks in database and alert user, schedule will be created in CleanViewController
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if tasks == [] {
            return
        }
        
        // empty old schedule
        ref.child("houses/\(CurrentUser.user.house!)/tasks").removeValue()
        
        // set new tasks
        for task in tasks {
            ref.child("houses/\(CurrentUser.user.house!)/tasks/\(task)").setValue(true)
        }
        
        // set creation date as week of the year
        ref.child("houses/\(CurrentUser.user.house!)/firstWeek").setValue(getCurrentWeek())
        
        // get data from database and pop to CleanViewController
        getAllData {
            self.createAlert(title: "Tasks Set!", message: "", pop: true)
        }
    }
    
    /// add task from textfield to list of new tasks
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        if taskTextfield1.text != "" {
            tasks.append(taskTextfield1.text!)
            taskTextfield1.text = ""
            taskTableView.reloadData()
        } else {
            return
        }
    }
    
    /// give amount of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    /// give cell to table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    /// set cell text from tasks
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = tasks[indexPath.row]
    }
    
    /// every task can be deleted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// deleting a task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /// hide keyboard with click on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// hide keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskTextfield1.resignFirstResponder()
        return true
    }
}

//
//  TaskDetailViewController.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 23/09/22.
//

import UIKit

class TaskDetailViewController: UITableViewController {

    @IBOutlet var taskDetailTextField: UITextField!
    @IBOutlet var taskDetailDatePicker: UIDatePicker!
    @IBOutlet var taskDetailNotesTextView: UITextView!
    @IBOutlet var cancelAddTaskButton: UIBarButtonItem!
    @IBOutlet var saveTaskButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

}

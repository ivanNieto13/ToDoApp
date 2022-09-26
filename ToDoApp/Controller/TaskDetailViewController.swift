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
    
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var toDoDetailTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoDetailTask != nil {
            taskDetailTextField.text = toDoDetailTask?.title
            taskDetailDatePicker.date = (toDoDetailTask?.date)!
            taskDetailNotesTextView.text = toDoDetailTask?.notes
        } else {
            toDoDetailTask = Task(context: self.context)
            toDoDetailTask?.id_task = UUID()
            taskDetailTextField.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        toDoDetailTask?.notes = taskDetailNotesTextView.text
        toDoDetailTask?.title = taskDetailTextField.text
        taskDetailDatePicker?.date = taskDetailDatePicker.date
        
        print("UUID:", toDoDetailTask?.id_task?.description)
        
//         destination.current = toDoDetailTask
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if validateText(text: (taskDetailTextField?.text)!) {
            perform = true
        } else {
            userMessage(alertTitle: "Atención", message: "Escriba un texto para la actividad", actionTitle: "Ok", vc: self)
        }
        return perform
    }

    @IBAction func cancelAddTaskButtonPressed(_ sender: UIBarButtonItem) {
        let isModal = self.presentingViewController is UINavigationController
        if isModal {
            self.dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
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

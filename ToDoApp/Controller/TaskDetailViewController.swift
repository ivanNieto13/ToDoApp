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
        setupTextFields()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        toDoDetailTask?.notes = taskDetailNotesTextView.text
        toDoDetailTask?.title = taskDetailTextField.text
        toDoDetailTask?.date = taskDetailDatePicker.date
        if ((toDoDetailTask?.id_task?.uuidString.isEmpty) != nil) {
            toDoDetailTask?.id_task = UUID()
        }
        destination.currentTask = toDoDetailTask
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        if validateText(text: taskDetailTextField.text!) {
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
    
    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(doneButtonTapped) )
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        taskDetailTextField.inputAccessoryView = toolbar
        taskDetailNotesTextView.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

}

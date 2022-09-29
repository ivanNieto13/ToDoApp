//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 23/09/22.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet var toDoListTableView: UITableView!
    @IBOutlet var addTaskButton: UIBarButtonItem!
    @IBOutlet var editTaskButton: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var currentTask: Task?
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        let dataManager = TaskDataManager(context: self.context)
        tasks = dataManager.fetch()
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell") as! ToDoTaskTableViewCell
        let row = indexPath.row
        cell.taskTitleLabel.text = tasks[row].title
        cell.taskDate = tasks[row].date
        cell.taskNotes = tasks[row].notes
        cell.taskUUID = tasks[row].id_task?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "taskDetailSegue", sender: Self.self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTask = self.tasks[indexPath.row]
            self.context.delete(currentTask!)
            do {
                try self.context.save()
                self.tasks.remove(at: indexPath.row)
                tableView.reloadData()
            } catch {
                print("Error: ", error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetailSegue" {
            let destination = segue.destination as! TaskDetailViewController
            let selectedIndexPath = toDoListTableView.indexPathForSelectedRow!
            destination.toDoDetailTask = tasks[selectedIndexPath.row]
            
        }
    }
    
    @IBAction  func unWindFromDetail(segue: UIStoryboardSegue) {
            let source = segue.source as! TaskDetailViewController
            currentTask = source.toDoDetailTask
            do{
                try context.save()
            }
            catch{
                print("error al salvar",error)
            }
            
            let dataManager = TaskDataManager(context: context)
            tasks = dataManager.fetch()
            self.toDoListTableView.reloadData()
    }
    
    @IBAction func editTaskButton(_ sender: UIBarButtonItem) {
        if toDoListTableView.isEditing {
            toDoListTableView.setEditing(false, animated: true)
            sender.title = "Editar"
            addTaskButton.isEnabled = true
        } else {
            toDoListTableView.setEditing(true, animated: true)
            sender.title = "Listo"
            addTaskButton.isEnabled = false
        }
    }
    
    
        
    

}

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
    
    let context = (UIApplication.shared.delegate! as! AppDelegate).persistentContainer.viewContext
    var currentTask: Task?
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        
        let dataManager = TaskDataManager(context: self.context)
        tasks = dataManager.fetch()
        print("Tasks")
    }
    
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoTaskCell") as! ToDoTaskTableViewCell
        let row = indexPath.row
        print(tasks[row])
        cell.taskTitleLabel.text = tasks[row].title
        cell.taskDate = tasks[row].date
        cell.taskNotes = tasks[row].notes
        cell.taskUUID = tasks[row].id_task?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "taskDetailSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetailSegue" {
            let destination = segue.destination as! TaskDetailViewController
            let selectedIndexPath = toDoListTableView.indexPathForSelectedRow!
            print("->", tasks[selectedIndexPath.row])
            destination.toDoDetailTask = tasks[selectedIndexPath.row]
            
        }
    }
    
    @IBAction  func unWindFromDetail(segue: UIStoryboardSegue ){
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
    
        
    

}

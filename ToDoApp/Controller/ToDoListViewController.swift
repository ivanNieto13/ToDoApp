//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 23/09/22.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet var toDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
    }
    
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

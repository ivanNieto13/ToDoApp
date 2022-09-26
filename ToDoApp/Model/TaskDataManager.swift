//
//  TaskDataManager.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 24/09/22.
//

import Foundation
import CoreData

class TaskDataManager {
    private var tasks: [Task] = []
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetch() -> [Task] {
        do {
            self.tasks = try self.context.fetch(Task.fetchRequest())
        } catch {
            print("Error")
        }
        return tasks
    }
    
    func getTask(index: Int) -> Task {
        return tasks[index]
    }
    
    func countTasks() -> Int {
        return tasks.count
    }
}

//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Ivan Nieto on 24/09/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var notes: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var id_task: UUID?

}

extension Task : Identifiable {

}

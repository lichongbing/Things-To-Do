//
//  ToDoItem.swift
//  CoreDataToDo
//
//  Created by Umayanga Alahakoon on 9/13/19.
//  Copyright © 2019 Umayanga Alahakoon. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var order: Int
}

extension ToDoItem {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

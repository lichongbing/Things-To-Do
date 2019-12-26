//
//  AddToDoItem.swift
//  CoreDataToDo
//
//  Created by Umayanga Alahakoon on 12/26/19.
//  Copyright © 2019 Umayanga Alahakoon. All rights reserved.
//

import SwiftUI

struct AddToDoItem: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
     @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
     
     @State private var newToDoItem = ""
    
    var body: some View {
        HStack {
            
            Button(action: {
                if self.newToDoItem != "" {
                    let toDoItem = ToDoItem(context: self.managedObjectContext)
                    toDoItem.title = self.newToDoItem
                    toDoItem.isDone = false
                    toDoItem.order = (self.toDoItems.last?.order ?? 0) + 1
                    
                    self.saveItems()
                    
                    self.newToDoItem = ""
                    
                    self.saveItems()
                }
                
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .imageScale(.large)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.green)
            }
            
            //ResizableTextField()
            
            TextField("What do you have to do?", text: $newToDoItem) {
                if self.newToDoItem != "" {
                    let toDoItem = ToDoItem(context: self.managedObjectContext)
                    toDoItem.title = self.newToDoItem
                    toDoItem.isDone = false
                    toDoItem.order = (self.toDoItems.last?.order ?? 0) + 1
                    
                    self.saveItems()
                    
                    self.newToDoItem = ""
                    
                    self.saveItems()
                    
                }
            }
            .lineLimit(nil)
            .padding(.leading, 10)
            //.textFieldStyle(RoundedBorderTextFieldStyle())
            
            
        }
    }
    
    func saveItems() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct AddToDoItem_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoItem()
    }
}





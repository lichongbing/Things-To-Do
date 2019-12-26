//
//  ToDoItemView.swift
//  CoreDataToDo
//
//  Created by Umayanga Alahakoon on 9/13/19.
//  Copyright © 2019 Umayanga Alahakoon. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var toDoItem: ToDoItem
    
    @State var title: String
    @State var isDone: Bool = false
    @State var isTextEditing: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: self.toDoItem.isDone ? "largecircle.fill.circle" : "circle")
                .resizable()
                .imageScale(.large)
                .frame(width: 25, height: 25)
                .foregroundColor(self.toDoItem.isDone ? Color.purple : Color.gray.opacity(0.4))
                .onTapGesture {
                    self.toDoItem.isDone.toggle()
                    
                    let order = self.toDoItem.order
                    self.toDoItem.order = 0
                    self.saveItems()
                    
                    self.toDoItem.order = order
                    self.saveItems()
                }
            
            if self.isTextEditing == false {
                Text(title) 
                    .padding(.leading, 10)
                    .onTapGesture {
                        self.isTextEditing.toggle()
                    }
            } else {
                TextField("\(self.title)", text: $title) {
                    self.toDoItem.title = self.title
                    self.isTextEditing.toggle()
                    
                    let order = self.toDoItem.order
                    self.toDoItem.order = 0
                    self.saveItems()
                    
                    self.toDoItem.order = order
                    self.saveItems()
                }
                    .padding(.leading, 10)
                    .lineLimit(nil)
            }
            
            /*
            if self.isTextEditing {
                Button(action: {
                    self.toDoItem.title = self.title
                    self.isTextEditing.toggle()
                    
                    let order = self.toDoItem.order
                    self.toDoItem.order = 0
                    self.saveItems()
                    
                    self.toDoItem.order = order
                    self.saveItems()
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
            } */
            
            
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

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(toDoItem: ToDoItem(), title: "Just Do This", isDone: false)
    }
}

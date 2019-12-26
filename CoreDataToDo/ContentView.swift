//
//  ContentView.swift
//  CoreDataToDo
//
//  Created by Umayanga Alahakoon on 9/13/19.
//  Copyright © 2019 Umayanga Alahakoon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    
    //@ObservedObject var toDoItem: ToDoItem
    
   
    
    @State private var newToDoItem = ""
    @State var value : CGFloat = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    //Section(header: Text("Tasks")) {
                    ForEach(self.toDoItems, id: \.self) { toDoItems in
                        ToDoItemView(toDoItem: toDoItems, title: toDoItems.title ?? "asd" , isDone: toDoItems.isDone)
                        }
                        .onDelete(perform: deleteItem)
                        .onMove(perform: moveItem)
                //}
                   
                    AddToDoItem()
                    .padding(.vertical , 10)
                    
                    
                }
                
                
            }
            .padding(.bottom, self.value == 0 ? 30 : 0)
            .offset(y: -self.value)
            .animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                    
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    
                    if self.toDoItems.count > 5 && self.toDoItems.count <= 9  {
                        self.value = height/2
                    }
                    
                    if self.toDoItems.count > 9 {
                        self.value = height
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                    
                    self.value = 0
                }
            }
                
                
            
            .navigationBarTitle(Text("Things To Do"), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
            
        }.accentColor(Color.purple)
    }//.accentColor(Color.purple)
    
    func moveItem(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        
        if source < destination {
            var startIndex = source + 1
            let endIndex = destination - 1
            var startOrder = toDoItems[source].order
            while startIndex <= endIndex {
                toDoItems[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            
            toDoItems[source].order = startOrder
            
        } else if destination < source {
            var startIndex = destination
            let endIndex = source - 1
            var startOrder = toDoItems[destination].order + 1
            let newOrder = toDoItems[destination].order
            while startIndex <= endIndex {
                toDoItems[startIndex].order = startIndex
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            toDoItems[source].order = newOrder
        }
        
        saveItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        let source = indexSet.first
        let deleteItem = toDoItems[source!]
        self.managedObjectContext.delete(deleteItem)
        
        self.saveItems()
    }
    
    func saveItems() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

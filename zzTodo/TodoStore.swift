//
//  TodoStore.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 11. 1..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit

class TodoStore: NSObject {

    static let sharedInstance = TodoStore()
    var todos: [TodoItem] = []
    
    var filePath: String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        return documentDirectory! + "/todolist.json"
    }
    
    func initialize() {
        self.load()
    }
    
    func save() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        NSKeyedArchiver.archiveRootObject(self.todos, toFile: self.filePath)
    }
    
    func load() {
        if NSFileManager.defaultManager().fileExistsAtPath(self.filePath) {
            self.todos = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath) as! [TodoItem]
        }
    }
    
    func count() -> Int {
        return todos.count
    }
    
//    func addItem(title: String) {
//        let todoItem = TodoItem(title: title)
//        todos.append(todoItem)
//    }
    
    func addItem(item: TodoItem) {
        todos.append(item)
    }
    
    func itemForIndexPath(indexPath: NSIndexPath) -> TodoItem {
        return todos[indexPath.row]
    }
    
    func removeItemForIndexPath(indexPath: NSIndexPath) {
        todos.removeAtIndex(indexPath.row)
    }
}

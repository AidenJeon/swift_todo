//
//  TodoListViewController.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 10. 7..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var todoStore = TodoStore.sharedInstance
    var tableView: UITableView!
    var selectedIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        self.title = "Todo List"
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.yellowColor()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = 200
        tableView.registerClass(TodoListViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        self.view.addSubview(tableView)
        
//        tableView.editing = true
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        addButton.setImage(UIImage(named: "btn_add"), forState: .Normal)
        addButton.addTarget(self, action: #selector(self.gotoAddTodoScene(_:)), forControlEvents: .TouchUpInside)
        
        let addBarButton = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = addBarButton
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let indexPath = self.selectedIndexPath {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.reloadData()
            self.selectedIndexPath = nil
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = todoStore.itemForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TodoListViewCell
        cell.configureForItem(item)
//        cell.imageView?.image = UIImage(named: "btn_add")
//        cell.accessoryType = .Checkmark
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todoItem = todoStore.itemForIndexPath(indexPath)
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.delegate = self
        todoAddViewController.todoItem = todoItem
        
        self.selectedIndexPath = indexPath
        self.navigationController?.pushViewController(todoAddViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            todoStore.removeItemForIndexPath(indexPath)
            self.tableView.reloadData()
        default:
            print("dddd")
        }
    }

//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        
//    }
    
    // MARK: - Actions
    
    func gotoAddTodoScene(sender: UIButton) {
        let todoAddViewController = TodoAddViewController()
        todoAddViewController.delegate = self
        self.navigationController?.pushViewController(todoAddViewController, animated: true)
//        self.presentViewController(todoAddViewController, animated: true, completion: nil)
    }
}


extension TodoListViewController: TodoAddViewControllerDelegate {
    
//    func addTodo(title: String) {
//        todoStore.addItem(title)
//        self.tableView.reloadData()
//    }
    func addTodo(item: TodoItem) {
        todoStore.addItem(item)
        self.tableView.reloadData()
    }
}
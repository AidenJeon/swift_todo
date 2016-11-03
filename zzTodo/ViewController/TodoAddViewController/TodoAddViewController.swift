//
//  TodoAddViewController.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 10. 7..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit
import PureLayout

protocol TodoAddViewControllerDelegate {
    func addTodo(title: String)
}

class TodoAddViewController: UIViewController {

    var todoTextField: UITextField!
    var saveButton: UIButton!

    var delegate: TodoAddViewControllerDelegate?
    
    var todoItem: TodoItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupSubview()
        self.setupAutolayout()
        
        if let todoItem = self.todoItem {
            todoTextField.text = todoItem.title
        }
        
        todoTextField.becomeFirstResponder();
    }

    func setupSubview() {
        todoTextField = UITextField(frame: CGRectZero)
        todoTextField.backgroundColor = UIColor.greenColor()
        self.view.addSubview(todoTextField)
        
        saveButton = UIButton(frame: CGRectZero)
        saveButton.setTitle("저장", forState: .Normal)
        saveButton.backgroundColor = UIColor.redColor()
        saveButton.addTarget(self, action: #selector(self.didTapSaveBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(saveButton)
    }
    
    func setupAutolayout() {
        // textfield
        todoTextField.autoPinToTopLayoutGuideOfViewController(self, withInset: 20)
        todoTextField.autoPinEdge(.Left, toEdge: .Left, ofView: self.view, withOffset: 20);
        todoTextField.autoPinEdge(.Right, toEdge: .Right, ofView: self.view, withOffset: -20);
        todoTextField.autoSetDimension(.Height, toSize: 30)
        
        // button
        saveButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: todoTextField, withOffset: 10)
        saveButton.autoPinEdge(.Right, toEdge: .Right, ofView: todoTextField)
        saveButton.autoSetDimensionsToSize(CGSize(width: 50, height: 30))
    }
    
    override func viewDidLayoutSubviews() {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func didTapSaveBtn() {
        if let delegate = delegate, title = todoTextField.text {
            if let todoItem = self.todoItem {
                todoItem.title = title
            } else {
                delegate.addTodo(title)
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}

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
    func addTodo(item: TodoItem)
}

class TodoAddViewController: UIViewController {

    var todoTextView: UITextView!
    var takePictureButton: UIButton!
    var saveButton: UIButton!
    var selectedImageView: UIImageView!

    var delegate: TodoAddViewControllerDelegate?
    
    var todoItem: TodoItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupSubview()
        self.setupAutolayout()
        
        if let todoItem = self.todoItem {
            todoTextView.text = todoItem.title
            selectedImageView.image = todoItem.image
        }
        
        //todoTextView.becomeFirstResponder();
    }

    func setupSubview() {
        todoTextView = UITextView(frame: CGRectZero)
        todoTextView.textAlignment = NSTextAlignment.Left
        todoTextView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(todoTextView)
        
        takePictureButton = UIButton()
        takePictureButton.setTitle("첨부", forState: .Normal)
        takePictureButton.backgroundColor = UIColor.blueColor()
        takePictureButton.addTarget(self, action: #selector(self.didTapTakePicture), forControlEvents: .TouchUpInside)
        self.view.addSubview(takePictureButton)
        
        saveButton = UIButton(frame: CGRectZero)
        saveButton.setTitle("저장", forState: .Normal)
        saveButton.backgroundColor = UIColor.redColor()
        saveButton.addTarget(self, action: #selector(self.didTapSaveBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(saveButton)
        
        selectedImageView = UIImageView()
        selectedImageView.backgroundColor = UIColor.purpleColor()
        selectedImageView.contentMode = .ScaleAspectFit
        self.view.addSubview(selectedImageView)
    }
    
    func setupAutolayout() {
        // textfield
        todoTextView.autoPinToTopLayoutGuideOfViewController(self, withInset: 20)
        todoTextView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view, withOffset: 20);
        todoTextView.autoPinEdge(.Right, toEdge: .Right, ofView: self.view, withOffset: -20);
        todoTextView.autoSetDimension(.Height, toSize: 200)
        
        // take picture button
        takePictureButton.autoSetDimensionsToSize(CGSize(width: 50, height: 30))
        takePictureButton.autoPinEdge(.Top, toEdge: .Top, ofView: saveButton)
        takePictureButton.autoPinEdge(.Right, toEdge: .Left, ofView: saveButton, withOffset: -10)
        
        // button
        saveButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: todoTextView, withOffset: 10)
        saveButton.autoPinEdge(.Right, toEdge: .Right, ofView: todoTextView)
        saveButton.autoSetDimensionsToSize(CGSize(width: 50, height: 30))
        
        // selected image
        selectedImageView.autoPinEdge(.Top, toEdge: .Bottom, ofView: saveButton, withOffset: 10)
        selectedImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        selectedImageView.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        selectedImageView.autoSetDimension(.Height, toSize: 100)
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
        if let delegate = delegate, title = todoTextView.text {
            if let todoItem = self.todoItem {
                todoItem.title = title
                todoItem.image = selectedImageView.image
            } else {
                let item = TodoItem(title: title)
                item.image = selectedImageView.image
                delegate.addTodo(item)
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func didTapTakePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .SavedPhotosAlbum
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
}

extension TodoAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        selectedImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
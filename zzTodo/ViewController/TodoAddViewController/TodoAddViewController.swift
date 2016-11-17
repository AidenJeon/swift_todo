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
    var timeTextField: UITextField!
    var selectedTextView: UITextView?
    var datePicker: UIDatePicker?

    var delegate: TodoAddViewControllerDelegate?
    
    var todoItem: TodoItem?
    
    var aniButton: MyButton!
    
    
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
        todoTextView.delegate = self
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
        
        timeTextField = UITextField()
        timeTextField.backgroundColor = UIColor.yellowColor()
        timeTextField.delegate = self
        self.view.addSubview(timeTextField)
        
        datePicker = UIDatePicker()
        
        aniButton = MyButton(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        aniButton.backgroundColor = UIColor.redColor()
        aniButton.addTarget(self, action: #selector(self.didTapAniButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(aniButton)
    }
    
    func setupAutolayout() {
        // textfield
        todoTextView.autoPinToTopLayoutGuideOfViewController(self, withInset: 10)
        todoTextView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view, withOffset: 10);
        todoTextView.autoPinEdge(.Right, toEdge: .Right, ofView: self.view, withOffset: -10);
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
        
        // time text field
        timeTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: selectedImageView, withOffset: 10)
        timeTextField.autoPinEdge(.Left, toEdge: .Left, ofView: selectedImageView, withOffset: 0)
        timeTextField.autoPinEdge(.Right, toEdge: .Right, ofView: selectedImageView, withOffset: 0)
        timeTextField.autoSetDimension(.Height, toSize: 30)
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
                todoItem.todoTime = datePicker?.date
            } else {
                let item = TodoItem(title: title)
                item.image = selectedImageView.image
                item.todoTime = datePicker?.date
                delegate.addTodo(item)
            }
            
            // 푸시 등록
            let noti = UILocalNotification()
            noti.alertBody = "TEST"
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.fireDate = NSDate.init(timeIntervalSinceNow: 5)
            UIApplication.sharedApplication().scheduleLocalNotification(noti)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func didTapTakePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .SavedPhotosAlbum
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func didTapAniButton(sender: MyButton) {
//        aniButton.moveRight(50)
        sender.pulseAni()
        
    }
}

extension TodoAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        selectedImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension TodoAddViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.selectedTextView = textView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let okButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.hideKeyboard))
        toolbar.setItems([spacer, okButton], animated: false)
        
        toolbar.backgroundColor = UIColor.yellowColor()
        textView.inputAccessoryView = toolbar
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let okButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.updateDate))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(self.hideKeyboard))
        toolbar.setItems([cancelButton, spacer, okButton], animated: false)

        
        toolbar.backgroundColor = UIColor.yellowColor()
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        return true
    }
    
    func hideKeyboard() {
//        selectedTextView?.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func updateDate() {
        timeTextField.text = String(datePicker!.date)
        self.hideKeyboard()
    }
}
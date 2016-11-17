//
//  TodoItem.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 10. 18..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit

class TodoItem: NSObject, NSCoding {
    
    var title: String?
    var order: Int = 0
    var done: Bool = false
    var imageURL: String?
    var image: UIImage?
    var todoTime: NSDate?
    
    init(title: String?) {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
//        self.todoTime = aDecoder.decodeObjectForKey("todoTime") as? NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.image, forKey: "image")
//        aCoder.encodeObject(self.image, forKey: "todoTime")
    }
}

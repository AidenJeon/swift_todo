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
    
    init(title: String?) {
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.image = aDecoder.decodeObjectForKey("image") as? UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.image, forKey: "image")
    }
}

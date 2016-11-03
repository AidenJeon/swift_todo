//
//  UIViewExtension.swift
//  zzTodo
//
//  Created by 김형운 on 2016. 10. 18..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit

extension UIView {
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width / 2
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width / 2
        }
    }
}
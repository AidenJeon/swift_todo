//
//  MoveAnimation.swift
//  zzTodo
//
//  Created by JeonSangMin on 2016. 11. 15..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit

protocol MoveAnimation {
    func moveRight(offset: CGFloat)
    
    func pulseAni()
}

extension MoveAnimation where Self: UIView {
    func moveRight(offset: CGFloat) {
        UIView.animateWithDuration(0.3) {
            self.right = self.right + offset
        }
    }
    
    func pulseAni() {
        UIView.animateWithDuration(0.3, animations: {
            self.frame.size = CGSize(width: 100, height: 100)
            }) { (state) in
                UIView.animateWithDuration(0.3, animations: {
                    self.frame.size = CGSize(width: 50, height: 50)
                }) { (state) in
                }
        }
    }
}
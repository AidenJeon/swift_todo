//
//  ColorInfo.swift
//  zzTodo
//
//  Created by JeonSangMin on 2016. 11. 17..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import UIKit
import ObjectMapper

class ColorInfo: Mappable {
    var value: String?
    var color: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        value <- map["value"]
        color <- map["color"]
    }
}

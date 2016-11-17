//
//  APIClient.swift
//  zzTodo
//
//  Created by JeonSangMin on 2016. 11. 17..
//  Copyright © 2016년 hwkim03. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class APIClient {
    
    static let sharedInstance = APIClient()
    
    func getData(callback: ([ColorInfo]) -> ()) {
        
        Alamofire.request(NSURLRequest(URL: NSURL(string: "http://lensvil.me/data.json")!)).responseJSON { (response) in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //print(json["sample"][0]["value"].string)
                
                let colorInfoList: [ColorInfo]? = Mapper<ColorInfo>().mapArray(json["sample"].object)
                if let colorInfos = colorInfoList {
                    callback(colorInfos)
                }
                
                break
            case .Failure:
                break
            }
        }
    }
}
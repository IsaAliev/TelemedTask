//
//  NSObject+Xib.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import Foundation

extension NSObject {
    
    static func fromXib(_ owner: AnyObject? = nil) -> AnyObject {
        return objectFromXib(nibName(), owner: owner)
    }
    
    static func objectFromXib(_ nibName: String, owner: AnyObject? = nil) -> AnyObject {
        let object = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)!.first!
        
        return object as AnyObject
    }
    
    static func nibName() -> String {
        return Utils.stringFromSwiftClass(self)
    }
}

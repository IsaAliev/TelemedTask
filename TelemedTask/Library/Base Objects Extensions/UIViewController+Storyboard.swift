//
//  UIViewController+Storyboard.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var loadFromXib: Bool {
        return false
    }
    
    class func controller() -> Self {
        
        func controller<T>(_ type: T.Type) -> T {
            if (loadFromXib) {
                return fromXib() as! T
            } else {
                let storyboard = UIStoryboard(name: storyboardName(), bundle: nil)
                return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier()) as! T
            }
        }
        
        return controller(self)
    }
    
    class func storyboardName() -> String {
        return "Main"
    }
    
    class func storyboardIdentifier() -> String {
        return Utils.stringFromSwiftClass(self)
    }
    
}

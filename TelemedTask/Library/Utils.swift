//
//  Utils.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import Foundation

class Utils {
    static let executableName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    
    static func apiHash() -> (timeStamp: String, hash: String) {
        let timeStampString = String(Date().timeIntervalSince1970)
        let stringToMakeHashFrom = timeStampString + Constants.API.privateKey + Constants.API.publicKey
        
        return (timeStampString, stringToMakeHashFrom.MD5String())
    }
    
    static func swiftClassFromString(_ className: String) -> AnyClass? {
        return NSClassFromString(executableName + "." + className)
    }
    
    static func stringFromSwiftClass(_ swiftClass: Any) -> String {
        return NSStringFromClass(swiftClass as! AnyClass).components(separatedBy: ".").last!
    }

}

//
//  Utils.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import Foundation

class Utils {
    static func apiHash() -> (timeStamp: String, hash: String) {
        let timeStampString = String(Date().timeIntervalSince1970)
        let stringToMakeHashFrom = timeStampString + Constants.API.privateKey + Constants.API.publicKey
        
        return (timeStampString, stringToMakeHashFrom.MD5String())
    }
}

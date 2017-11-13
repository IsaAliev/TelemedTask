//
//  MarvelCharacter.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import ObjectMapper

class MarvelCharacter: Mappable {
    
    var thumbnailUrl: URL?
    var name: String
    var description: String
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        thumbnailUrl <- map["thumbnail.path"]
        name <- map["name"]
        description <- map["description"]
    }

}

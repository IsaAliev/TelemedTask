//
//  MarvelCharacter.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import ObjectMapper

class MarvelCharacter: Mappable {
    
    var thumbnailUrlString: String?
    var thumbnailExtenstion: String?
    var name: String!
    var description: String!
    
    var image: UIImage?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        thumbnailUrlString <- map["thumbnail.path"]
        thumbnailExtenstion <- map["thumbnail.extension"]
        name <- map["name"]
        description <- map["description"]
    }

    var thumbnailUrl: URL? {
        guard let urlString = thumbnailUrlString,
            let extenstion = thumbnailExtenstion else {
                return nil
        }
        
        return URL(string: urlString + "/landscape_large." + extenstion)
    }
    
}

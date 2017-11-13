//
//  CharactersApi.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import Alamofire
import ObjectMapper

class CharactersApi {
    
    typealias Completion = ([MarvelCharacter]) -> ()
    typealias Failure = (Error) -> ()
    
    let path = "characters"
    var offset = 0
    let limit = 10
    
    var isRequestInProgress = false
    
    func sendRequest(completion: @escaping Completion, failure: @escaping Failure) {
        let hashTuple = Utils.apiHash()
        let params = ["ts": hashTuple.timeStamp,
                      "apikey": Constants.API.publicKey,
                      "hash": hashTuple.hash,
                      "limit": limit,
                      "offset": offset] as [String : Any]
        
        Alamofire.request(Constants.API.baseUrl + path, parameters: params).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.updateOffset()
                
                let charactersArray = strongSelf.parseResponseToModelsArray(response: value)
                
                completion(charactersArray)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    private func updateOffset() {
        self.offset += self.limit
    }
    
    private func parseResponseToModelsArray(response: Any) -> [MarvelCharacter] {
        let responseArray = ((response as! [String: Any])["data"]! as! [String: Any])["results"] as! [[String: Any]]
        var charactersArray = [MarvelCharacter]()
        
        for characterJson in responseArray {
            guard let character = Mapper<MarvelCharacter>().map(JSON: characterJson) else {
                continue
            }
            charactersArray.append(character)
        }
        
        return charactersArray
    }
    
    func requestNextPage(completion: @escaping Completion, failure: @escaping Failure) {
        guard !isRequestInProgress else {
            return
        }
        
        sendRequest(completion: completion, failure: failure)
    }
    
    func requestFromFirstPage(completion: @escaping Completion, failure: @escaping Failure) {
        guard !isRequestInProgress else {
            return
        }
        
        offset = 0
        requestNextPage(completion: completion, failure: failure)
    }
    
}

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
    var limit = 20
    var isLastPage = false
    
    var isRequestInProgress = false
    
    convenience init(limit: Int) {
        self.init()
        self.limit = limit
    }
    
    func sendRequest(completion: @escaping Completion, failure: Failure? = nil) {
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
                
                if charactersArray.count < strongSelf.limit {
                    strongSelf.isLastPage = true
                }
                
                completion(charactersArray)
            case .failure(let error):
                failure?(error)
            }
        }
    }
    
    func requestNextPage(failure: Failure? = nil, completion: @escaping Completion) {
        guard !isRequestInProgress else {
            return
        }
        
        sendRequest(completion: completion, failure: failure)
    }
    
    func requestFromFirstPage(failure: Failure? = nil, completion: @escaping Completion) {
        guard !isRequestInProgress else {
            return
        }
        
        offset = 0
        requestNextPage(failure: failure, completion: completion)
    }
    
}

extension CharactersApi {
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
}

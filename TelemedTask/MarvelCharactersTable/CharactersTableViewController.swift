//
//  CharactersTableViewController.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import Foundation
import UIKit

class CharactersTableViewController: UITableViewController {
    
    let cellIdentifier = "CharacterCell"
    let loaderCellIdentifier = "LoaderCell"
    let cellHeigth: CGFloat = 200.0
    let loaderCellHeight: CGFloat = 44.0
    let prefetchDistance = 5
    
    let api = CharactersApi()
    
    var characters = [MarvelCharacter] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadPages()
        addRefreshControl()
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadPages), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func reloadPages() {
        api.requestFromFirstPage { [weak self] (characters) in
            self?.characters = characters
            
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func loadNextPage() {
        api.requestNextPage { [weak self] (characters) in
            
            guard let strongSelf = self else {
                return
            }
            
            var indices = [IndexPath]()
            
            let countBeforeUpdate = strongSelf.characters.count
            let countAfterUpdate = strongSelf.characters.count + characters.count
            
            for i in countBeforeUpdate..<countAfterUpdate {
                indices.append(IndexPath(row: i, section: 0))
            }
                
            strongSelf.characters.append(contentsOf: characters)
            
            strongSelf.tableView.beginUpdates()
            strongSelf.tableView.insertRows(at: indices, with: .bottom)
            strongSelf.tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellAt(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellAt(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.isLastPage ? characters.count : characters.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == characters.count {
            return tableView.dequeueReusableCell(withIdentifier: loaderCellIdentifier, for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CharacterCell
        cell.character = characters[indexPath.row]
        
        if indexPath.row == characters.count - prefetchDistance {
            loadNextPage()
        }
        
        return cell
    }
    
    func heightForCellAt(row: Int) -> CGFloat {
        if row == characters.count {
            return loaderCellHeight
        } else {
            return cellHeigth
        }
    }
    
}

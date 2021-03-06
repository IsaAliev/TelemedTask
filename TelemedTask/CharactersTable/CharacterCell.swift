//
//  CharacterCell.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var character:  MarvelCharacter? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let character = character else {
            return
        }
        
        nameLabel.text = character.name
        thumbnailImageView.sd_setImage(with: character.thumbnailUrlForDownloading, placeholderImage: UIImage(color: .gray)) { [weak self] (image, error, cacheType, url) in
            self?.character?.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.sd_cancelCurrentImageLoad()
    }
    
}

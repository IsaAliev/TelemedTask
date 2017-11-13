//
//  CharacterInfoViewController.swift
//  TelemedTask
//
//  Created by Isa Aliev on 13.11.17.
//  Copyright © 2017 IA. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController {
    
    var character: MarvelCharacter!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
        
        if let image = character.image {
            imageView.image = image
        } else {
            imageView.sd_setImage(with: character.thumbnailUrl, placeholderImage: UIImage(color: .gray))
        }
    }
    
}

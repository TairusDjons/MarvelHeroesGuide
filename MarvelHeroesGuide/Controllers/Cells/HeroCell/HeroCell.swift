//
//  HeroCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = Colors.marvelRed
        self.nameLabel.textColor = .white
        self.layer.cornerRadius = 8
    }
    
}

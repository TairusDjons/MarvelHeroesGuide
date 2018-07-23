//
//  HeroCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        self.nameLabel.textColor = .white
        self.nameLabel.layer.cornerRadius = 16
        self.nameLabel.backgroundColor = Colors.marvelRed
        
        self.imageView.layer.cornerRadius = 16
        self.imageView.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        
    }
    
    func setOutlets(thumbnail: Thumbnail, name: String, placeholder: UIImage? = nil) {
        self.nameLabel.text = name
        let path = URL(string: thumbnail.path + "." + thumbnail.exten)
        guard let placeholder = placeholder
            else {
                self.imageView.kf.setImage(with: path)
                return
        }
        self.imageView.kf.setImage(with: path, placeholder: placeholder)
    }
}


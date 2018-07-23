//
//  ThumbnailCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 22.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class ThumbnailCell: UITableViewCell {
    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Colors.backgroundMarvelRed
        nameLabel.textColor = .white
        nameLabel.layer.cornerRadius = 16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setOutlets(thumbnail: Thumbnail, name: String, placeholder: UIImage? = nil) {
        self.nameLabel.text = name
        let path = URL(string: thumbnail.path + "." + thumbnail.exten)
        guard let placeholder = placeholder
            else {
                self.thumbnailImageView.kf.setImage(with: path)
                return
        }
        self.thumbnailImageView.kf.setImage(with: path, placeholder: placeholder)
    }
    
}

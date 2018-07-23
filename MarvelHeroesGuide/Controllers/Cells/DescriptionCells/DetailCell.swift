//
//  DetailCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 22.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet fileprivate weak var detailTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailTextView.layer.masksToBounds = true
        detailTextView.layer.cornerRadius = 16
        detailTextView.backgroundColor = Colors.marvelRed
        detailTextView.textColor = .white
        
        self.backgroundColor = Colors.backgroundMarvelRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setOutlets(description: String) {
        if description.isEmpty {
            self.detailTextView.text = "Whoopsie, no description for you =("
            return
        }
        
        detailTextView.text = description
    }
    
}

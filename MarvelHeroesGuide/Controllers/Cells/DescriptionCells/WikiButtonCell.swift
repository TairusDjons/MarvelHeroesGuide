//
//  WikiButtonCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 24.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import UIKit

class WikiButtonCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var wikiButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Colors.backgroundMarvelRed
        
        // Initialization code
    }

    func setAction(target: Any?, action: Selector, event: UIControlEvents) {
        wikiButton.addTarget(target, action: action, for: event)
    }
}

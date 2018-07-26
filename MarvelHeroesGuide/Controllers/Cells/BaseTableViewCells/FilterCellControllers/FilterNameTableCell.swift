//
//  TableViewCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 26.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class FilterNameCell: UITableViewCell {

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func getName() -> String {
        return self.nameTextField.text!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

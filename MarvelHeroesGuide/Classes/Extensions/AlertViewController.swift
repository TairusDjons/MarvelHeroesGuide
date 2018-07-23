//
//  AlertViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: Alertable {
    func alertMessage(view: UIViewController,
                      title: String,
                      usrMessage: String,
                      action: ((UIAlertAction) -> ())? = nil,
                      OnCompletion: (() -> ())? = nil ) {
        let alert = UIAlertController(title: title, message: usrMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: action)
        
        alert.addAction(action)
        view.present(alert, animated: true, completion: OnCompletion)
    }
}

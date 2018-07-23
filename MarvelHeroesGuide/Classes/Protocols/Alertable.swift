//
//  Alertable.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 23.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import Foundation
import UIKit

protocol Alertable {
     func alertMessage(view: UIViewController,
                       title: String,
                       usrMessage: String,
                       action: ((UIAlertAction) -> ())?,
                       OnCompletion: (() -> ())?)
}

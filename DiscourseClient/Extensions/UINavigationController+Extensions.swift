//
//  UINavigationController+Extensions.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 25/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

extension UINavigationController {
    func showBg() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func hideBg() {
        self.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layoutIfNeeded()
    }
}

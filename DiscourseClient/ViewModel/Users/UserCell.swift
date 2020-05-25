//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell : UITableViewCell {
    
    
    @IBOutlet weak var imageUserOutlet: UIImageView!
    
    @IBOutlet weak var nameUserOutlet: UILabel!
    @IBOutlet weak var usernameUserOutlet: UILabel!
    
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            imageUserOutlet.layer.cornerRadius = 28
            nameUserOutlet?.text = viewModel.user.user.name
            usernameUserOutlet?.text = viewModel.user.user.username
        }
    }
    
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        guard let imageData = self.viewModel?.imageData else { return }
        self.imageUserOutlet.image = UIImage(data: imageData)
        setNeedsLayout()
    }
}

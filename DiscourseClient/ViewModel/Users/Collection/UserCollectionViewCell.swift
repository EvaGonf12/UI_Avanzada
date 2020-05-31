//
//  UserCollectionViewCell.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 27/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameTextOutlet: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var contentShadowOutlet: UIView!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            nameTextOutlet?.text = viewModel.user.user.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.imageOutlet.layer.cornerRadius = imageOutlet.frame.height / 2
        
        // Shadow de la imagen de la tabla
        self.contentShadowOutlet.backgroundColor = .clear
        self.contentShadowOutlet.layer.shadowColor = UIColor.dark.cgColor
        self.contentShadowOutlet.layer.shadowOpacity = 0.20
        self.contentShadowOutlet.layer.shadowRadius = 5
        self.contentShadowOutlet.layer.shadowOffset = CGSize(width: 0, height: 7)
    }

}

extension UserCollectionViewCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        self.imageOutlet.image = viewModel?.image
        self.imageOutlet.alpha = 0
        UIView.animate(withDuration: 1.0) {
            self.imageOutlet.alpha = 1
        }
        setNeedsLayout()
    }
}



//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            userImageOutlet.layer.cornerRadius = 28
            titleOutlet?.text = viewModel.topic.title
        }
    }
    
}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        guard let imageData = self.viewModel?.imageData else { return }
        self.userImageOutlet.image = UIImage(data: imageData)
        setNeedsLayout()
    }
}

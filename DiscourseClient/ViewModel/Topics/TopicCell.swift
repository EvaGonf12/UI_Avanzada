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
    @IBOutlet weak var shadowViewOutlet: UIView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var postsCountOutlet: UILabel!
    @IBOutlet weak var msgCountOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!

    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            self.titleOutlet?.text = viewModel.topic.title
            self.postsCountOutlet.text = "\(viewModel.topic.postsCount)"
            guard let posters = viewModel.topic.posters else { return }
            msgCountOutlet.text = "\(posters.count)"
            
            // Fecha - "2020-05-24T17:33:42.064Z"
            let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = inputFormat

            guard let date = dateFormatter.date(from: viewModel.topic.createdAt) else { return }
            let outputFormat = "MMM d, YYYY"
            dateFormatter.dateFormat = outputFormat
            let outputStringDate = dateFormatter.string(from: date)
            self.dateOutlet.text = outputStringDate.capitalized
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    
    fileprivate func setupUI() {
        self.contentView.layer.borderWidth = 0
        self.userImageOutlet.layer.cornerRadius = userImageOutlet.frame.height/2

        // Shadow de la imagen de la tabla
        self.shadowViewOutlet.backgroundColor = .clear
        self.shadowViewOutlet.layer.shadowColor = UIColor.dark.cgColor
        self.shadowViewOutlet.layer.shadowOpacity = 0.20
        self.shadowViewOutlet.layer.shadowRadius = 5
        self.shadowViewOutlet.layer.shadowOffset = CGSize(width: 0, height: 7)
    }
    
}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        self.userImageOutlet.image = viewModel?.image
        self.userImageOutlet.alpha = 0
        UIView.animate(withDuration: 1.0) {
            self.userImageOutlet.alpha = 1
        }
        setNeedsLayout()
    }
}

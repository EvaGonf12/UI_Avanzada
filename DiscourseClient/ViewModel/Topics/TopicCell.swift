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
    @IBOutlet weak var postsCountOutlet: UILabel!
    @IBOutlet weak var msgCountOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!

    override func awakeFromNib() {
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 0
        let separatorFrame = CGRect(x: 13, y: self.contentView.frame.size.height - 1.0, width: 287, height: 1)
        let separator = UIView(frame: separatorFrame)
        separator.backgroundColor = UIColor.grayThin
        separator.alpha = 0.5
        self.contentView.addSubview(separator)
    }
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            self.userImageOutlet.layer.cornerRadius = userImageOutlet.frame.height/2
            self.titleOutlet?.text = viewModel.topic.title
            self.postsCountOutlet.text = "\(viewModel.topic.postsCount)"
            guard let posters = viewModel.topic.posters else { return }
            msgCountOutlet.text = "\(posters.count)"
            
            // Fecha - "2020-05-24T17:33:42.064Z"
            let inputFormat = "YYYY-MM-DD'T'HH:mm:ss.SSSZ"
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
    
}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userImageFetched() {
        guard let imageData = self.viewModel?.imageData else { return }
        //TODO: meter animación
        self.userImageOutlet.image = UIImage(data: imageData)
        setNeedsLayout()
    }
}

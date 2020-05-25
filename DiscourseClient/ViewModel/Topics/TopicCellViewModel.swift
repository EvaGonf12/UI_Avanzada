//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol TopicCellViewModelViewDelegate: class {
    func userImageFetched()
}

class TopicCellViewModel {
    
    weak var viewDelegate: TopicCellViewModelViewDelegate?
    
    let topic: Topic
    let user: UserInfo
    var imageData: Data?
    
    init(topic: Topic, user: UserInfo) {
        self.topic = topic
        self.user = user
        
        let userPath = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(56)")
        let urlString = apiURL + userPath
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.imageData = try? Data.init(contentsOf: url)
            DispatchQueue.main.async {
                self?.viewDelegate?.userImageFetched()
            }
        }
    }
    
}

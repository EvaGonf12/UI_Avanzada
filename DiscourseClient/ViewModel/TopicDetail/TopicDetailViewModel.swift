//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func deletedSuccess()
    func errorFetchingTopicDetail(error: String)
}

class TopicDetailViewModel {
    var title: String
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicPostsCount: Int?
    var topicCanDelete: Bool?
    
    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int
    
    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.title = "Detalle"
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }
    
    func viewDidLoad() {
        self.topicDetailDataManager.fetchTopic(id: self.topicID, completion: {[weak self] result in
            switch result {
                case .failure(let error):
                    self?.viewDelegate?.errorFetchingTopicDetail(error: error.localizedDescription)
                case .success(let topicDetails):
                    self?.labelTopicIDText = "\(topicDetails.id)"
                    self?.labelTopicNameText = topicDetails.title
                    self?.labelTopicPostsCount = topicDetails.postsCount
                    if let topicCanDelete = topicDetails.details.canDelete {
                        self?.topicCanDelete = topicCanDelete
                    } else {
                        self?.topicCanDelete = false
                    }
                    self?.viewDelegate?.topicDetailFetched()
            }
        })
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
    
    func deleteButtonTapped(topic id: String) {
        self.topicDetailDataManager.deleteTopic(id: id) {[weak self] (result) in
            switch result {
                case .failure(let error):
                    switch error._domain {
                        case "DiscourseClient.SessionAPIError":
                            if error as! SessionAPIError == SessionAPIError.emptyData {
                                self?.viewDelegate?.deletedSuccess()
                            } else {
                                self?.viewDelegate?.errorFetchingTopicDetail(error: error.localizedDescription)
                            }
                        default:
                            self?.viewDelegate?.errorFetchingTopicDetail(error: error.localizedDescription)
                    }
                case .success(_):
                    self?.viewDelegate?.deletedSuccess()
            }
        }
    }
    
    func alertDismiss() {
        self.coordinatorDelegate?.topicDetailBackButtonTapped()
    }
}

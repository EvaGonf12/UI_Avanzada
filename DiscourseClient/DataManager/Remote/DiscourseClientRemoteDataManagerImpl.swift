//
//  DiscourseClientRemoteDataManagerImpl.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación por defecto del protocolo remoto, en este caso usando SessionAPI
class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func deleteTopic(id: String, completion: @escaping (Result<DeleteTopicResponse, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse, Error>) -> ()) {
        let request = UsersRequest(period: "all", order: "likes_received")
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ()) {
        let request = SingleUserRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }
    
    func changeUserName(username: String, name: String, completion: @escaping (Result<ChangeUserNameResponse, Error>) -> ()) {
        let request = ChangeUserNameRequest(username: username, name: name)
        session.send(request: request) { result in
            completion(result)
        }
    }
}

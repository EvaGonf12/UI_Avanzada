//
//  DiscourseClientDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation


/// DataManager de la app. Usa un localDataManager y un remoteDataManager que colaboran entre ellos
/// En las extensiones de abajo, encontramos la implementación de aquellos métodos necesarios en cada módulo de la app
/// Este DataManager sólo utiliza llamadas remotas, pero podría extenderse para serialziar las respuestas, y poder implementar un offline first en el futuro
class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ()) {
        self.remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
    
    func deleteTopic(id: String, completion: @escaping (Result<DeleteTopicResponse, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse, Error>) -> ()) {
        self.remoteDataManager.fetchAllUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDetailDataManager {
    func changeUserName(username: String, name: String, completion: @escaping (Result<ChangeUserNameResponse, Error>) -> ()) {
        self.remoteDataManager.changeUserName(username: username, name: name, completion: completion)
    }
    
    func fetchUser(username: String, completion: @escaping (Result<SingleUserResponse, Error>) -> ()) {
        self.remoteDataManager.fetchUser(username: username, completion: completion)
    }
}

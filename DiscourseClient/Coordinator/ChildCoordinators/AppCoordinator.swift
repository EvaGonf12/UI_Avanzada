//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        topicsNavigationController.navigationBar.barTintColor = UIColor.colorBgLight

        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()
        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController,
                                                usersDataManager: dataManager,
                                                userDetailDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.barTintColor = UIColor.breakWhite
        tabBarController.tabBar.tintColor = UIColor.orange
        tabBarController.tabBar.unselectedItemTintColor = UIColor.dark
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.tabbarText],
                                                      for: .normal)

        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(named: "homeSelected")
        tabBarController.tabBar.items?[1].image = UIImage(named: "userUnselectedDark")

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}

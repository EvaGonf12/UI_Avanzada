//
//  UsersViewControllerCollection.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 27/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewControllerCollection: UIViewController {
    
    lazy var menu: Menu = {
        let menu = Menu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    lazy var notification: NotificationView = {
        let notification = NotificationView()
        notification.translatesAutoresizingMaskIntoConstraints = false
        notification.buttonAction = { [weak self] in
            print("TODO: cambiar la página")
        }
        return notification
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 35))
        //searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Buscar"
        searchBar.backgroundColor = .clear
        searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBg"), for: .normal)
        searchBar.tintColor = UIColor.dark
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        //searchBar.barTintColor = UIColor.dark
        
        return searchBar
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .orangeLight
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let sectionInset: CGFloat = 20.0
        let minimumInteritemSpacing: CGFloat = 48.0
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 79.0, height: 126.0)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        return collectionView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 54, height: 53))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "buttonAdd"), for: .normal)
        //button.addTarget(self, action: #selector(self.addTopic), for: .touchUpInside)
        return button
    }()
    
    var topConstrain: NSLayoutConstraint?
        
    let viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        title = self.viewModel.title
        self.navigationItem.title = ""
        self.navigationController?.hideBg()
        
        view = UIView()
        view.backgroundColor = .white

        topConstrain = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 289)
        
        menu.title = self.viewModel.title
        view.addSubview(menu)
        NSLayoutConstraint.activate([
            menu.topAnchor.constraint(equalTo: view.topAnchor),
            menu.leftAnchor.constraint(equalTo: view.leftAnchor),
            menu.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(notification)
        NSLayoutConstraint.activate([
            notification.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notification.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            notification.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11),
            notification.heightAnchor.constraint(lessThanOrEqualToConstant: 155)
        ])
        
        view.addSubview(collectionView)
        guard let topConstrainCollection = self.topConstrain else { return }

        NSLayoutConstraint.activate([
            topConstrainCollection,
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56),
            addButton.heightAnchor.constraint(equalToConstant: 53),
            addButton.widthAnchor.constraint(equalToConstant: 54)
        ])
        
        notification.buttonAction = { [weak self] in
            // Tiene que ocultar toda la notificación y hacer el menú pequeño
            self?.notification.isHidden = true
            self?.menu.menuType = MenuBGName.small
            self?.topConstrain?.constant = 114
            self?.collectionView.layoutIfNeeded()
        }
        
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        collectionView.refreshControl = refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    @objc func refreshControlPulled() {
        self.viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingUsersAlert(error : String) {
        let alertMessage: String = NSLocalizedString("Error fetching categories:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
    
}

extension UsersViewControllerCollection: UsersViewDelegate {
    func usersFetched() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
    func errorFetchingUsers(error : String) {
        showErrorFetchingUsersAlert(error: error)
    }
}

extension UsersViewControllerCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as? UserCollectionViewCell else { fatalError() }
        cell.viewModel = viewModel.viewModel(at: indexPath)
        return cell
    }
}

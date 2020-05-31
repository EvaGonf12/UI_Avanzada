//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    var viewModel: TopicsViewModel
    
    lazy var menu: Menu = {
        let menu = Menu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 35))
        searchBar.placeholder = "Buscar"
        searchBar.backgroundColor = .clear
        searchBar.setSearchFieldBackgroundImage(UIImage(named: "searchBg"), for: .normal)
        searchBar.tintColor = UIColor.dark
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.backgroundColor = .clear
        table.estimatedRowHeight = 94
        table.rowHeight = 94
        table.layer.borderWidth = 0
        table.layer.cornerRadius = 24
        table.separatorStyle = .singleLine
        return table
    }()
    
    lazy var notification: NotificationView = {
        let notification = NotificationView()
        notification.translatesAutoresizingMaskIntoConstraints = false
        return notification
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .orangeLight
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 54, height: 53))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "buttonAdd"), for: .normal)
        button.addTarget(self, action: #selector(self.addTopic), for: .touchUpInside)
        return button
    }()
    
    var topConstrain: NSLayoutConstraint?
    
    init(viewModel: TopicsViewModel) {
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
        view.backgroundColor = UIColor.breakWhite
        
        topConstrain = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 289)
        
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
        
        view.addSubview(tableView)
        guard let topConstrainTable = self.topConstrain else { return }
        
        NSLayoutConstraint.activate([
            topConstrainTable,
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
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
            self?.tableView.layoutIfNeeded()
        }
        
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        tableView.refreshControl = refreshControl

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }

    @objc func refreshControlPulled() {
        self.viewModel.viewWasLoaded()
    }
    
    @objc func addTopic() {
        viewModel.plusButtonTapped()
    }
    
    fileprivate func showErrorFetchingTopicsAlert(error : String) {
        let alertMessage: String = NSLocalizedString("Error fetching topics:\n'\(error)'\nPlease try again later", comment: "")
        showAlert(alertMessage, "ERROR", "OK", nil)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }

    func errorFetchingTopics(error : String) {
        showErrorFetchingTopicsAlert(error: error)
    }
}

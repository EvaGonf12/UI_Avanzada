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

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleNavBar: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Temas"
        title.font = UIFont.titleNavbar
        title.textColor = UIColor.breakWhite
        return title
    }()

    lazy var bgMenu: UIImageView = {
        let image = UIImage(named: "menuBgBig")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 305)
        imageView.contentMode = .scaleToFill
        return imageView
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
        notification.buttonAction = { [weak self] in
            print("TOMAAAAAA")
        }
        return notification
    }()
    
    
    override func loadView() {
        title = "Temas"
        self.navigationItem.title = ""
        self.navigationController?.hideBg()

        view = UIView()
        view.backgroundColor = UIColor.breakWhite
        
        view.addSubview(bgMenu)
        NSLayoutConstraint.activate([
            bgMenu.topAnchor.constraint(equalTo: view.topAnchor),
            bgMenu.leftAnchor.constraint(equalTo: view.leftAnchor),
            bgMenu.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgMenu.heightAnchor.constraint(equalToConstant: 305)
        ])
        
        view.addSubview(notification)
        NSLayoutConstraint.activate([
            notification.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            notification.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            notification.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11),
            notification.heightAnchor.constraint(lessThanOrEqualToConstant: 155)
        ])
        
        view.addSubview(titleNavBar)
        NSLayoutConstraint.activate([
            titleNavBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 53),
            titleNavBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11)
        ])
        
//        view.addSubview(searchBar)
//        NSLayoutConstraint.activate([
//            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125)
//        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 289),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewWasLoaded()
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    
    @objc func reloadButtonTapped() {
        viewModel.viewWasLoaded()
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
        tableView.reloadData()
    }

    func errorFetchingTopics(error : String) {
        showErrorFetchingTopicsAlert(error: error)
    }
}

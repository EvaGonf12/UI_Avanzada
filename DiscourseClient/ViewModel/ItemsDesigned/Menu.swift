//
//  Menu.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 27/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

enum MenuBGName: String {
    case big = "menuBgBig"
    case small = "menuBg"
}

class Menu: UIView {
    
    var menuType: MenuBGName = .big {
        didSet {
            bgMenu.image = UIImage(named: menuType.rawValue)
        }
    }
    
    var title: String = "" {
        didSet {
            titleNavBar.text = title
        }
    }
    
    lazy var bgMenu: UIImageView = {
        let image = UIImage(named: menuType.rawValue)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 375, height: 305)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var titleNavBar: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.titleNavbar
        title.textColor = UIColor.breakWhite
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        let height : CGFloat = menuType == .big ? 305 : 133
        
        self.addSubview(bgMenu)
        NSLayoutConstraint.activate([
            bgMenu.topAnchor.constraint(equalTo: self.topAnchor),
            bgMenu.leftAnchor.constraint(equalTo: self.leftAnchor),
            bgMenu.rightAnchor.constraint(equalTo: self.rightAnchor),
            bgMenu.heightAnchor.constraint(equalToConstant: height)
        ])
        
        self.addSubview(titleNavBar)
        NSLayoutConstraint.activate([
            titleNavBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 53),
            titleNavBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 11)
        ])
    }
}

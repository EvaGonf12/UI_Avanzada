//
//  Notification.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 25/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    var buttonAction : (() -> Void)?
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 353, height: 155))
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.backgroundColor = UIColor.breakWhite.cgColor
        contentView.layer.cornerRadius = 24
        return contentView
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Verifica tu cuenta de email"
        title.font = UIFont.titleNotification
        title.textColor = UIColor.dark
        return title
    }()
    
    lazy var textNotification: UILabel = {
        let textNotification = UILabel()
        textNotification.translatesAutoresizingMaskIntoConstraints = false
        textNotification.text = "Revisa tu bandeja de entrada para tener acceso a todas las funcionalidades de Keepcoding."
        textNotification.numberOfLines = 0
        textNotification.font = UIFont.textNotification
        textNotification.textColor = UIColor.grayText
        return textNotification
    }()
    
    lazy var iconNotification: UIImageView = {
        let image = UIImage(named: "path")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 21)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.orangeDark
        button.frame = CGRect(x: 0, y: 0, width: 115, height: 28)
        button.setTitle("Acceder", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = button.frame.height / 2
        button.addTarget(self, action: #selector(self.buttonActionFunc), for: .touchUpInside)
        button.setTitleColor(UIColor.dark, for: .normal)
        button.setTitleColor(UIColor.breakWhite, for: .highlighted)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        self.backgroundColor = UIColor.breakWhite
        self.layer.cornerRadius = 24
        
//        self.addSubview(contentView)
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: self.topAnchor),
//            contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
//            contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
//            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
        
        self.addSubview(iconNotification)
        NSLayoutConstraint.activate([
            iconNotification.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            iconNotification.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            iconNotification.heightAnchor.constraint(equalToConstant: 21),
            iconNotification.widthAnchor.constraint(equalToConstant: 18)
        ])
        
        self.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -90)
        ])
        
        self.addSubview(textNotification)
        NSLayoutConstraint.activate([
            textNotification.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            textNotification.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 19),
            textNotification.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -21)
        ])
                
        self.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textNotification.bottomAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 28),
            button.widthAnchor.constraint(equalToConstant: 115)
        ])
        
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
//        self.addGestureRecognizer(gesture)
    }
        
    func addActions() {
        //button.addTarget(self, action: #selector(self.buttonActionFunc), for: .touchUpInside)
    }
    
    @objc func buttonActionFunc() {
        //self.buttonAction?()
        print("TOMAAAAAAAAAAA")
    }
    
}

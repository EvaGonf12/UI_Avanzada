
//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserCellViewModelViewDelegate: class {
    func userImageFetched()
}

/// ViewModel que representa una categoría en la lista
class UserCellViewModel {
    
    weak var viewDelegate: UserCellViewModelViewDelegate?
    
    let user: User
    var image: UIImage?
    var heightCellCollectionLabel: CGFloat?
    
    init(user: User) {
        self.user = user
        let userPath = user.user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(78)")
        let urlString = apiURL + userPath
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.image = image
                self?.viewDelegate?.userImageFetched()
            }
        }
    }
    
}

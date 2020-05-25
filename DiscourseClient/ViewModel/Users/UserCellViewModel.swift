
//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 11/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserCellViewModelViewDelegate: class {
    func userImageFetched()
}

/// ViewModel que representa una categoría en la lista
class UserCellViewModel {
    
    weak var viewDelegate: UserCellViewModelViewDelegate?
    
    let user: User
    var imageData: Data?
    
    init(user: User) {
        self.user = user
        let userPath = user.user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(56)")
        let urlString = apiURL + userPath
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.imageData = try? Data.init(contentsOf: url)
            DispatchQueue.main.async {
                self?.viewDelegate?.userImageFetched()
            }
        }
    }
    
}

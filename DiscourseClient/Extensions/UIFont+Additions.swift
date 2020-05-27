//
//  UIFont+Additions.swift
//  eh.ho_practica
//
//  Generated on Zeplin. (25/5/2020).
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var textButton: UIFont {
      return UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    }

    class var textNotification: UIFont {
      return UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }

    class var titleNotification: UIFont {
      return UIFont.systemFont(ofSize: 20.0, weight: .semibold)
    }

    class var titleNavbar: UIFont {
      return UIFont.systemFont(ofSize: 26.0, weight: .bold)
    }

    class var cellTitle: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .medium)
    }
    
    class var cellData: UIFont {
        return UIFont.systemFont(ofSize: 17.0, weight: .light)
    }
    
    class var tabbarText: UIFont {
        return UIFont.systemFont(ofSize: 11.0, weight: .regular)
    }
}

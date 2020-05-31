//
//  CustomizedTabbar.swift
//  DiscourseClient
//
//  Created by Eva Gonzalez Ferreira on 31/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class CustomizedTabbar {
        
    static func createCustomTabbar() -> UIView {
        let tabbarFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 83)//49
        let customShapeView = UIView(frame: tabbarFrame)
        // Creamos una shape layer
        let shapeLayer = CAShapeLayer()
        
        customShapeView.layer.addSublayer(shapeLayer)

        shapeLayer.path = createTabbarPath(tabbarFrame: tabbarFrame)
        shapeLayer.strokeColor = UIColor.breakWhite.cgColor
        shapeLayer.fillColor = UIColor.breakWhite.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.shadowRadius = 4
        shapeLayer.shadowColor = UIColor.dark.cgColor
        shapeLayer.shadowOpacity = 0.4
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
            
        // La añadimos como hija de la layer principal
        
        return customShapeView
    }
    
    static func createTabbarPath(tabbarFrame: CGRect) -> CGPath {
        let height: CGFloat = 54/2
        let path = UIBezierPath()
        let centerWidth = tabbarFrame.width / 2
        let space: CGFloat = 5.0
        
        let curveLateralSize: CGFloat = 10
        
        path.move(to: CGPoint(x: curveLateralSize, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height - space), y: 0))
        
        path.addCurve(to: CGPoint(x: centerWidth + height + space, y: 0),
                      controlPoint1: CGPoint(x: (centerWidth - height - space), y: (height + space / 2 + height / 2)),
                      controlPoint2: CGPoint(x: (centerWidth + height + space), y: (height + space / 2 + height / 2)))
        
        path.addLine(to: CGPoint(x: tabbarFrame.width - curveLateralSize, y: 0))
        
        path.addCurve(to: CGPoint(x: tabbarFrame.width, y: curveLateralSize),
                      controlPoint1: CGPoint(x: (tabbarFrame.width - curveLateralSize / 3), y: 0),
                      controlPoint2: CGPoint(x: tabbarFrame.width, y: curveLateralSize / 2 ))

        
        path.addLine(to: CGPoint(x: tabbarFrame.width, y: tabbarFrame.height))
        path.addLine(to: CGPoint(x: 0, y: tabbarFrame.height ))
        path.addLine(to: CGPoint(x: 0, y: curveLateralSize))
        path.addCurve(to: CGPoint(x: curveLateralSize, y: 0),
                      controlPoint1: CGPoint(x: 0, y: curveLateralSize / 2),
                      controlPoint2: CGPoint(x: curveLateralSize / 3, y: 0 ))
        path.close()
        
        return path.cgPath
    }

}


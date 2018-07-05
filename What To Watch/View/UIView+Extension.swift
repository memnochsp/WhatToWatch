//
//  UIView+Extension.swift
//  What To Watch
//
//  Created by Sean Ogden Power on 27/4/18.
//  Copyright © 2018 Sean Ogden Power. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func setGradientBackground (colorOne: UIColor, colorTwo: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint (x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint (x: 0.0, y: 0.0)
        
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setCardFrame (){
        self.layer.backgroundColor = Colors.whiteOverlay.cgColor
        self.layer.shadowOffset = CGSize (width: 7, height: 7)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
        roundCorners()
    }
    
    func roundCorners (){
        self.layer.cornerRadius = 8
    }

}

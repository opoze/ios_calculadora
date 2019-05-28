//
//  Extensions.swift
//  Calculadora
//
//  Created by Luis Alberto Zagonel Pozenato on 28/05/2019.
//  Copyright © 2019 LuisPozenato. All rights reserved.
//

import Foundation

import UIKit

extension UILabel {
    
    func startBlink() {
        UIView.animate(withDuration: 0.1,
                       delay:0.0,
                       options:[.allowUserInteraction, .curveEaseInOut],
                       animations: { self.alpha = 0 },
                       completion: { (_) -> Void in self.stopBlink() } )
    }
    
    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}

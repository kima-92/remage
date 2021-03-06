//
//  ThemeController.swift
//  Remage
//
//  Created by macbook on 7/28/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import UIKit

class ThemeController {
    
    // MARK: - Properties
    
    let colorList = ColorList()
    
    var bgColors: [BGColor] {
        return colorList.bgColors
    }
    
    var currentColor: BGColor?
    var userBGColor: BGColor?
    
    // MARK: - Methods
    
    // Setup CurrentColor
    func setCurrentColor() {
        
        // Try to get User's prefered color
        if userBGColor != nil {
            currentColor = userBGColor
            
        // Set as default: Magical Sea
        } else {
            let colors = bgColors.filter({$0.name == "Light Sunset"})
            currentColor = colors[0]
        }
    }
    
    func userSetColorAs(color: BGColor) {
        currentColor = color
        userBGColor = color
        
        // TODO: - Set User's new color preference in CoreData
    }
}

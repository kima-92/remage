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
}

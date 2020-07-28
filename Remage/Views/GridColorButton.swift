//
//  GridColorButton.swift
//  Remage
//
//  Created by macbook on 7/28/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class GridColorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = 10
    }
}

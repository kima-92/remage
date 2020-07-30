//
//  TestingColorsViewController.swift
//  Remage
//
//  Created by macbook on 7/28/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class TestingColorsViewController: UIViewController {
    
    let themeController = ThemeController()
    
    //var color: BGColor?
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardColorLabel: UILabel!
    @IBOutlet weak var fontColorLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var someTextField: UITextField!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    private func updateViews() {
        let colors = themeController.bgColors.filter({$0.name == "Forest Green"})
        let color = colors[0]
        
        view.backgroundColor = color.bgColor
        cardColorLabel.backgroundColor = color.bgCardColor
        fontColorLabel.textColor = color.fontColor
        fontColorLabel.backgroundColor = color.textLabelColor
        cardColorLabel.textColor = color.fontColor
        
        cardColorLabel.layer.cornerRadius = 15
        cardColorLabel.layer.masksToBounds = true
        
        emptyView.backgroundColor = color.bgCardColor
        someTextField.backgroundColor = color.textLabelColor
        someTextField.textColor = color.fontColor
    }
}

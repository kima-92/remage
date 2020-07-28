//
//  SettingsMenuViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class SettingsMenuViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var backgroundColorChoiceButton: UIButton!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        backgroundCardView.layer.cornerRadius = 15
        backgroundColorChoiceButton.layer.cornerRadius = 10
    }
}

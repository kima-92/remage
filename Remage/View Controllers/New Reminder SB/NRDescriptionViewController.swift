//
//  NRDescriptionViewController.swift
//  Remage
//
//  Created by macbook on 7/25/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NRDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    var reminder: Reminder?
    
    // MARK: - Outlets
    
    @IBOutlet weak var addDescriptionLabel: UILabel!
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func saveBarButtomTapped(_ sender: UIBarButtonItem) {
    }
}

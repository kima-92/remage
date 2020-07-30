//
//  SettingsMenuViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class SettingsMenuViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var backgroundColorChoiceButton: UIButton!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromTabBar()
        updateViews()
    }
    
    // MARK: - Methods
    
    // To receive the ThemeController and ReminderController from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.themeController = tabBar.themeController
        self.reminderController = tabBar.reminderController
    }
    
    // Update Views
    private func updateViews() {
        backgroundCardView.layer.cornerRadius = 15
        backgroundColorChoiceButton.layer.cornerRadius = 10
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
       if segue.identifier == "ShowBGColorSelectionVCSegue" {
           
        guard let bgColorSelectionVC = segue.destination as? BGColorSelectionViewController else { return }
           
           bgColorSelectionVC.themeController = themeController
       }
    }
}

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
    
    var controllers: ModelControllers?
    var user: User?
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollSubView: UIView!
    @IBOutlet weak var scrollPushingView: UIView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var backgroundColorChoiceButton: UIButton!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromTabBar()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBGColors()
    }
    
    // MARK: - Methods
    
    // To receive the ModelControllers from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.controllers = tabBar.controllers
        self.user = tabBar.user
    }
    
    // Update Views
    private func updateViews() {
        
        // Round Corners
        backgroundCardView.layer.cornerRadius = 15
        backgroundColorChoiceButton.layer.cornerRadius = 10
        
        // Setup Current Color Button
        backgroundColorChoiceButton.layer.borderColor = UIColor.black.cgColor
        backgroundColorChoiceButton.layer.borderWidth = 3
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        scrollSubView.backgroundColor = color.bgColor
        scrollPushingView.backgroundColor = color.bgColor
        backgroundCardView.backgroundColor = color.bgCardColor
        
        // Background Color Settings
        backgroundColorChoiceButton.backgroundColor = color.highlightColor
        backgroundLabel.textColor = color.fontColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        navigationController?.navigationBar.tintColor = color.barTintColor
        navigationController?.navigationBar.barTintColor = color.barBGTintColor // Entire bar BG color
        
        tabBarController?.tabBar.barTintColor = color.barBGTintColor // Entire bar BG color
        tabBarController?.tabBar.tintColor = color.barTintColor // Selected tab bar button
        tabBarController?.tabBar.unselectedItemTintColor = color.barUnselectedTintColor // Unselected bar buttons
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowBGColorSelectionVCSegue" {
            
            guard let bgColorSelectionVC = segue.destination as? BGColorSelectionViewController else { return }
            
            bgColorSelectionVC.controllers = controllers
            bgColorSelectionVC.user = user
        }
    }
}

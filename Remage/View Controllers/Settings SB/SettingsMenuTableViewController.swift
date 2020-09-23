//
//  SettingsMenuTableViewController.swift
//  Remage
//
//  Created by macbook on 9/23/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class SettingsMenuTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var controllers: ModelControllers?
    var user: User?
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        receiveDataFromTabBar()
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
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        setTabBarsBGColors(color: color)
        view.backgroundColor = color.bgColor
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsList.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsMenuCell", for: indexPath)
        cell.textLabel?.text = SettingsList.allCases[indexPath.row].rawValue

        return cell
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

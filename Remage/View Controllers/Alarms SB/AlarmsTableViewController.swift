//
//  AlarmsTableViewController.swift
//  Remage
//
//  Created by macbook on 8/5/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class AlarmsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromTabBar()
        setBGColors()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Methods
    
    // To receive the ThemeController and ReminderController from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.themeController = tabBar.themeController
        self.reminderController = tabBar.reminderController
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        
        // CollectionView
        //remindersCollectionView.backgroundColor = color.textLabelColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        
        navigationController?.navigationBar.tintColor = color.fontColor
        navigationController?.navigationBar.barTintColor = color.bgCardColor.withAlphaComponent(0.5)
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        tabBarController?.tabBar.barTintColor = color.bgColor.withAlphaComponent(0.5)
        tabBarController?.tabBar.tintColor = color.fontColor
        tabBarController?.tabBar.unselectedItemTintColor = color.fontColor.withAlphaComponent(0.3)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

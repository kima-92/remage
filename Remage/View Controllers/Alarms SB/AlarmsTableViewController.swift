//
//  AlarmsTableViewController.swift
//  Remage
//
//  Created by macbook on 8/5/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit
import CoreData

class AlarmsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    var controllers: ModelControllers?
    var reminders: [Reminder]?
    
    var fetchResultsController: NSFetchedResultsController<Reminder> {
        
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        // Sort Reminders by Alarm Date
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "alarmDate", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController.delegate = self
        
        // Try to perform Fetch
        do {
            try fetchResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch reminder entities: \(error)")
        }
        return fetchResultsController
    }
    
    // MARK: - DidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
        setupReminders()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as? AlarmTableViewCell,
            let controllers = controllers else { return UITableViewCell() }
        
        cell.themeController = controllers.themeController
        cell.reminder = reminders?[indexPath.row]

        return cell
    }
    

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
    
    // To receive the ModelControllers from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.controllers = tabBar.controllers
    }
    
    // Get only the Reminders with an Alarm
    private func setupReminders() {
        let allReminders = fetchResultsController.fetchedObjects
        reminders = allReminders?.filter({ $0.alarmDate != nil })
    }
    
    // Background Colors Setup
    private func setBGColors() {
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        setTabBarsBGColors(color: color)
        tableView.separatorColor = color.bgCardColor
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

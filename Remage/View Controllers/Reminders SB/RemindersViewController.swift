//
//  RemindersViewController.swift
//  Remage
//
//  Created by macbook on 4/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit
import CoreData

class RemindersViewController: UIViewController {
    
    // MARK: - Properties
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    var fetchResultsController: NSFetchedResultsController<Reminder> {
        
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        // Sort Reminders by Title
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
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
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var remindersCollectionView: UICollectionView!
    
    // MARK: - ViewDidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromTabBar()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        remindersCollectionView.reloadData()
        setBGColors()
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
        
        // RemindersCollectionView's delegate and data source
        remindersCollectionView.delegate = self
        remindersCollectionView.dataSource = self
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        //scrollSubView.backgroundColor = color.bgColor
        //scrollPushingView.backgroundColor = color.bgColor
        
        // CollectionView
        remindersCollectionView.backgroundColor = color.textLabelColor
        
        // Header View
        //headerView.backgroundColor = color.bgCardColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        
        navigationController?.navigationBar.tintColor = color.fontColor
        navigationController?.navigationBar.barTintColor = color.bgCardColor.withAlphaComponent(0.5)
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        tabBarController?.tabBar.barTintColor = color.bgColor.withAlphaComponent(0.5)
        tabBarController?.tabBar.tintColor = color.fontColor
        tabBarController?.tabBar.unselectedItemTintColor = color.fontColor.withAlphaComponent(0.3)
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowReminderImageSegue" {

            let cell = sender as? ReminderCollectionViewCell
            
            guard let reminderPhotoVC = segue.destination as? ReminderPhotoViewController,
                let indexPath = remindersCollectionView.indexPath(for: cell!)
                    else { return }
            
            let reminder = fetchResultsController.object(at: indexPath)
            reminderPhotoVC.reminder = reminder
            reminderPhotoVC.themeController = themeController
        }
     }
}

// MARK: - Extension

// CollectionView Protocols
extension RemindersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let reminderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reminderCell", for: indexPath) as? ReminderCollectionViewCell else { return UICollectionViewCell() }
        
        reminderCell.reminder = fetchResultsController.object(at: indexPath)
        
        return reminderCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

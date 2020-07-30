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
    @IBOutlet weak var remindersCollectionView: UICollectionView!
    @IBOutlet weak var remindersCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveDataFromTabBar()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        remindersCollectionView.reloadData()
    }
    
    // MARK: - Methods
    
    // To receive the ThemeController and ReminderController from the Main TabBar
    private func receiveDataFromTabBar() {
        guard let tabBar = tabBarController as? MainTabBarController else { return }
        
        self.themeController = tabBar.themeController
        self.reminderController = tabBar.reminderController
    }
    
    // Setting the height of the remindersCollectionView
    func setCollectionViewHeight(cell: ReminderCollectionViewCell) {
        
        let cellHeight = cell.insideCellView.layer.bounds.height
        let remindersCount = fetchResultsController.fetchedObjects?.count ?? 0
        
        let heightCGFloat = CGFloat(remindersCount / 3)
        let heightDouble = Double(remindersCount) / 3
        
        var roundedCellHeight: CGFloat = 0
        
        // Check if it has a remeinder
        if heightDouble.truncatingRemainder(dividingBy: 1) == 0 {
            roundedCellHeight = heightCGFloat
        } else {
            roundedCellHeight = (heightCGFloat + 1)
        }
        
        let height = roundedCellHeight * (cellHeight + 10)
        remindersCollectionViewHeight.constant = height
    }
    
    // Update Views when ViewDidLoad is called
    private func updateViews() {
        
        // Set up the remindersCollectionView's delegate and data source
        remindersCollectionView.delegate = self
        remindersCollectionView.dataSource = self
        
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // TODO: - Tapping on the cell does not hit prepareFroSegue
        
        if segue.identifier == "SegueFromVCTOVC" || segue.identifier == "ShowReminderImageSegue" {

            let cell = sender as? UICollectionViewCell
            
            guard let reminderPhotoVC = segue.destination as? ReminderPhotoViewController,
                    let indexPath = remindersCollectionView.indexPathsForSelectedItems?.first
                    else { return }
            
            let reminder = fetchResultsController.object(at: indexPath)
            reminderPhotoVC.reminder = reminder
        }
     }
}

// MARK: - Extension for CollectionView
extension RemindersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    // CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let reminderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reminderCell", for: indexPath) as? ReminderCollectionViewCell else { return UICollectionViewCell() }
        
        reminderCell.reminder = fetchResultsController.object(at: indexPath)
        
        // Set the height of the collectionView
        setCollectionViewHeight(cell: reminderCell )
        
        return reminderCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == indexPath.item {
            performSegue(withIdentifier: "SegueFromVCTOVC", sender: self)
        }
    }
}

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
    var testReminders = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    
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
        
        updateViews()
    }
    
    
    // MARK: - Methods
    
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
    func updateViews() {
        
        // Set up the remindersCollectionView's delegate and data source
        remindersCollectionView.delegate = self
        remindersCollectionView.dataSource = self
        
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

// MARK: - Extension for CollectionView
extension RemindersViewController: UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    // CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let reminderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reminderCell", for: indexPath) as? ReminderCollectionViewCell else { return UICollectionViewCell() }
        
        reminderCell.backgroundColor = .cyan
        
        // Set the height of the collectionView
        setCollectionViewHeight(cell: reminderCell )
        
        return reminderCell
    }
}

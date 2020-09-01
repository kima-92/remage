//
//  ReminderPhotoViewController.swift
//  Remage
//
//  Created by macbook on 7/3/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ReminderPhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    var controllers: ModelControllers?
    var reminder: Reminder?
    
    // MARK: - Outlets

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    // MARK: - Methods
    private func updateViews() {
        guard let reminder = reminder else { return }
        
        if let image = reminder.defaultImage {
            imageView.image = UIImage(data: image)
            
        } else {
            // TODO: - Perform Segue to see Reminder Details with no Image
        }
    }
    
    // Background Colors Setup
    private func setBGColors() {
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Background
        setTabBarsBGColors(color: color)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowReminderDetailsSegue" {
            guard let reminderDetailsVC = segue.destination as? ReminderDetailsViewController else { return }
            
            reminderDetailsVC.reminder = reminder
            reminderDetailsVC.controllers = controllers
        }
    }
}

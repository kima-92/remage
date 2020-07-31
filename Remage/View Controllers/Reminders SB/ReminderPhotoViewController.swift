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
    
    var themeController: ThemeController?
    var reminderController: ReminderController?
    
    var reminder: Reminder?
    
    // MARK: - Outlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    
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
        guard let themeController = themeController,
            let color = themeController.currentColor else { return }
        
        // Background
        view.backgroundColor = color.bgColor
        bottomView.backgroundColor = color.bgColor
        //scrollSubView.backgroundColor = color.bgColor
        //scrollPushingView.backgroundColor = color.bgColor
        
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

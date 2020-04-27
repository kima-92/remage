//
//  NewReminderTypeViewController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NewReminderTypeViewController: UIViewController {
    
    // MARK: - Properties
    let cdModelController = CoreDataModelController()
    
    // MARK: - Outlets
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func noteButtonPressed(_ sender: UIButton) {
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

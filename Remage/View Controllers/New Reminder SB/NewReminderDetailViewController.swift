//
//  NewReminderDetailViewController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class NewReminderDetailViewController: UIViewController {
    
    // MARK: - Properties
    var cdModelController: CoreDataModelController?
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addImagesButton: UIButton!
    @IBOutlet weak var setAlertButton: UIButton!
    @IBOutlet weak var setDueDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addImagesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func setAlertButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func setDueDateButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
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

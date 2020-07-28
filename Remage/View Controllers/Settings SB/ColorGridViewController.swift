//
//  BackgroundColorViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ColorGridViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var chooseColorLabel: UILabel!
    
    @IBOutlet weak var backgoundCardView: UIView!
    @IBOutlet weak var backgroundCardView2: UIView!
    
    @IBOutlet weak var currentColorLabel: UILabel!
    @IBOutlet weak var currentColorView: UIView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func gridSquareButtonTapped(_ sender: UIButton) {
        print("Tapped on \(sender.tag)")
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

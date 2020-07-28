//
//  BackgroundColorViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class BackgroundColorViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var chooseColorLabel: UILabel!
    
    @IBOutlet weak var backgoundCardView: UIView!
    @IBOutlet weak var backgroundCardView2: UIView!
    
    @IBOutlet weak var gridSquareButton: UIButton!
    
    @IBOutlet weak var currentColorLabel: UILabel!
    @IBOutlet weak var currentColorView: UIView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func gridSquareButtonTapped(_ sender: UIButton) {
        print("Tapped on \(sender.tag)")
    }
    
    private func updateViews() {
        //gridSquareButton.clipsToBounds = false
        gridSquareButton.layer.cornerRadius = 10
        
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

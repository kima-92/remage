//
//  BackgroundColorViewController.swift
//  Remage
//
//  Created by macbook on 7/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class ColorGridViewController: UIViewController {
    
    var gridSquares: [GridColorButton] = []
    
    // MARK: - Outlets
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func selectColor(sender: GridColorButton) {
        
        // Clear all borders
        clearBorders()
        
        // Append this GridColorButton
        gridSquares.append(sender)
        
        // Add a border to this GridColorButton
        if sender.tag != 9 { // 9 is black
            
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.borderWidth = 3
        } else {
            sender.layer.borderColor = UIColor.white.cgColor
            sender.layer.borderWidth = 3
        }
        
        // Set Current color
        //currentColorView.backgroundColor = sender.backgroundColor
        //backgoundCardView.backgroundColor = sender.backgroundColor
    }
    
    // Clear borders of all GridColorButtons in the array
    private func clearBorders() {
        for cube in gridSquares {
            cube.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: - UpdateViews
    private func updateViews() {
        
        // Round corners
        //backgoundCardView.layer.cornerRadius = 15
        //currentColorView.layer.cornerRadius = 10
        
        // Border
        //currentColorView.layer.borderColor = UIColor.black.cgColor
        //currentColorView.layer.borderWidth = 3
    }
}

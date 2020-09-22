//
//  ViewControllerExtension.swift
//  Remage
//
//  Created by macbook on 7/23/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Hiding the Keyboard when the User taps on the Screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Background Colors Setup for the NavigationBar and the TabBar
    func setTabBarsBGColors(color: BGColor) {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Set the Background for this VC
        view.backgroundColor = color.bgColor
        
        // Set NavigationBar and TabBar Colors
        let textAttribute = [NSAttributedString.Key.foregroundColor: color.fontColor]
        navigationController?.navigationBar.titleTextAttributes = textAttribute
        
        navigationController?.navigationBar.tintColor = color.barTintColor                  // Bar Buttons
        navigationController?.navigationBar.barTintColor = color.barBGTintColor             // Entire bar BG color
        
        tabBarController?.tabBar.barTintColor = color.barBGTintColor                        // Entire bar BG color
        tabBarController?.tabBar.tintColor = color.barTintColor                             // Selected tab bar button
        tabBarController?.tabBar.unselectedItemTintColor = color.barUnselectedTintColor     // Unselected bar buttons
    }
}

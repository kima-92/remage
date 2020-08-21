//
//  DynamicSizeLabel.swift
//  Remage
//
//  Created by macbook on 8/21/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class DynamicLabelHeight {
    
    static func heighWith(attributedText: NSMutableAttributedString, width: CGFloat) -> CGFloat {
        
        // Get height considering the full length of the text
        
        var currentHeight = CGFloat.greatestFiniteMagnitude
        
        // Create a Dummy Label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: currentHeight))
        
        // Give the Dummy the same properties the real Label will have
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        // Get the correct Height after adding those properties
        currentHeight = label.frame.height + 5
        
        // Make sure this Dummy Label is not added to any view
        label.removeFromSuperview()
        
        return currentHeight
    }
    
    static func heighWith(font: UIFont, text: String, width: CGFloat) -> CGFloat {
        
        // Get height considering the full length of the text
        
        var currentHeight = CGFloat.greatestFiniteMagnitude
        
        // Create a Dummy Label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: currentHeight))
        
        // Give the Dummy the same properties the real Label will have
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        // Get the correct Height after adding those properties
        currentHeight = label.frame.height
        
        // Make sure this Dummy Label is not added to any view
        label.removeFromSuperview()
        
        return currentHeight
    }
}

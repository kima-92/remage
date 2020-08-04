//
//  ColorList.swift
//  Remage
//
//  Created by macbook on 7/28/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import Foundation
import UIKit

class ColorList {
    
    // MARK: - Colors Array
    
    var bgColors: [BGColor] {
        return addColors()
    }
    
    // MARK: - Add Colors Function
    
    private func addColors() -> [BGColor] {
        var colors: [BGColor] = []
        
        // MARK: - Forest green
        
        // All colors
        let fgColor1 = UIColor(red: 8/255, green: 28/255, blue: 21/255, alpha: 1)       // super dark green
        let fgColor2 = UIColor(red: 27/255, green: 67/255, blue: 50/255, alpha: 1)      // forest green
        let fgColor3 = UIColor(red: 45/255, green: 106/255, blue: 79/255, alpha: 1)     //
        let fgColor4 = UIColor(red: 64/255, green: 145/255, blue: 108/255, alpha: 1)    // green
        let fgColor5 = UIColor(red: 82/255, green: 183/255, blue: 136/255, alpha: 1)    //
        let fgColor6 = UIColor(red: 116/255, green: 198/255, blue: 157/255, alpha: 1)   // light green
        let fgColor7 = UIColor(red: 149/255, green: 213/255, blue: 178/255, alpha: 1)   //
        let fgColor8 = UIColor(red: 183/255, green: 228/255, blue: 199/255, alpha: 1)   // super light green
        let fgColor9 = UIColor(red: 216/255, green: 243/255, blue: 220/255, alpha: 1)   // white-ish green
        
        // Assign colors
        var forestGreen = BGColor(name: "Forest Green", fontColor: fgColor9, bgCardColor: fgColor2, bgColor: fgColor1, textLabelColor: fgColor3.withAlphaComponent(0.5))
        
        forestGreen.color1 = fgColor1
        forestGreen.color2 = fgColor2
        forestGreen.color3 = fgColor3
        forestGreen.color4 = fgColor4
        forestGreen.color5 = fgColor5
        forestGreen.color6 = fgColor6
        forestGreen.color7 = fgColor7
        forestGreen.color8 = fgColor8
        forestGreen.color9 = fgColor9
        
        // Assign Images
        forestGreen.docImage = UIImage(named: "fgDoc")
        forestGreen.cameraImage = UIImage(named: "fgCamera")
        forestGreen.cameraButton = UIImage(named: "fgCameraButton")
        forestGreen.emptyPictureImage = UIImage(named: "darkEmptyPicture")
        
        // Append
        colors.append(forestGreen)
        
        // MARK: - Magical Sea
        
        // All colors
        let msColor1 = UIColor(red: 128/255, green: 255/255, blue: 219/255, alpha: 1)  // light teal
        let msColor2 = UIColor(red: 114/255, green: 239/255, blue: 221/255, alpha: 1)  // darker teal
        let msColor3 = UIColor(red: 100/255, green: 223/255, blue: 223/255, alpha: 1)  // darker teal
        let msColor4 = UIColor(red: 86/255, green: 207/255, blue: 225/255, alpha: 1)   // blue-ish
        let msColor5 = UIColor(red: 72/255, green: 191/255, blue: 227/255, alpha: 1)   // light blue
        let msColor6 = UIColor(red: 78/255, green: 168/255, blue: 222/255, alpha: 1)   // blue-ish
        let msColor7 = UIColor(red: 83/255, green: 144/255, blue: 217/255, alpha: 1)   // darker blue
        let msColor8 = UIColor(red: 94/255, green: 96/255, blue: 206/255, alpha: 1)    // light violet
        let msColor9 = UIColor(red: 105/255, green: 48/255, blue: 195/255, alpha: 1)   // light indigo
        let msColor10 = UIColor(red: 116/255, green: 0/255, blue: 184/255, alpha: 1)   // purple
        
        // Assign colors
        var magicalSea = BGColor(name: "Magical Sea", fontColor: msColor10, bgCardColor: msColor6, bgColor: msColor1, textLabelColor: msColor2.withAlphaComponent(0.5))
        
        magicalSea.color1 = msColor1
        magicalSea.color2 = msColor2
        magicalSea.color3 = msColor3
        magicalSea.color4 = msColor4
        magicalSea.color5 = msColor5
        magicalSea.color6 = msColor6
        magicalSea.color7 = msColor7
        magicalSea.color8 = msColor8
        magicalSea.color9 = msColor9
        magicalSea.color10 = msColor10
        
        // Assign Images
        magicalSea.docImage = UIImage(named: "msDoc")
        magicalSea.cameraImage = UIImage(named: "msCamera")
        magicalSea.cameraButton = UIImage(named: "msCameraButton")
        magicalSea.emptyPictureImage = UIImage(named: "lightEmptyPicture")
        
        //Append
        colors.append(magicalSea)
        
        return colors
    }
}

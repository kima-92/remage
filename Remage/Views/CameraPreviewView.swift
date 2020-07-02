//
//  CameraPreviewView.swift
//  Remage
//
//  Created by macbook on 7/2/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
    
    // Override the default layer,
    // To now display the data streaming from the camera using AVCaptureVideoPreviewLayer
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPlayerView: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    // The newValue session has to be passed before setting up an instance
    var session: AVCaptureSession? {
        get { return videoPlayerView.session }
        set { videoPlayerView.session = newValue }
    }
}

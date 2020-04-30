//
//  CameraViewController.swift
//  Remage
//
//  Created by macbook on 4/27/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    // MARK: - Properties
    var cdModelController: CoreDataModelController?
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    var backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    
    // MARK: - Outlets
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var captureImageButton: UIButton!
    @IBOutlet weak var rotateCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIOSVersion()
    }
    
    // MARK: - Actions
    @IBAction func captureImageButtonTapped(_ sender: UIButton) {
    }
    @IBAction func rotateCameraButtonTapped(_ sender: UIButton) {
    }
    @IBAction func flashButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    func checkIOSVersion() {
        if #available(iOS 10.2, *) {
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice!)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.frame = view.layer.bounds
                captureSession?.startRunning()
            } catch {
                NSLog("Could not access Camera due to the iOS Version of the device")
            }
        }
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

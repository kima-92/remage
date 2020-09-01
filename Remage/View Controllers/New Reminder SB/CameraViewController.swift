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
    
    var controllers: ModelControllers?
    var cameraController: CameraController?
    
    var captureType: CaptureType = .picture
    var selectedCamera: SelectedCamera = .back
    
    var photoOutput: AVCapturePhotoOutput?
    var videoOutput: AVCaptureMovieFileOutput?
    
    var image: UIImage?
    var didStartNewReminder: Bool?
    var nrDetailDelegate: ImageSelectionDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var cameraView: CameraPreviewView!
    
    @IBOutlet weak var captureImageButton: UIButton!
    @IBOutlet weak var rotateCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGColors()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
//        setupSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSession()
    }
    
    // MARK: - Actions
    
    @IBAction func captureImageButtonTapped(_ sender: UIButton) {
        takePicture()
    }
    @IBAction func rotateCameraButtonTapped(_ sender: UIButton) {
    }
    @IBAction func flashButtonTapped(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    
    // Setup CaptureSession
    private func setupSession() {
        guard let cameraController = cameraController else { return }
        
        cameraController.cameraPreviewView = cameraView
        cameraController.captureType = captureType
        cameraController.selectedCamera = selectedCamera
        
        cameraController.setupCaptureSession()
    }
    
    // Stop Running CaptureSession
    private func stopSession() {
        guard let cameraController = cameraController else { return }
        cameraController.stopRunningSession()
    }
    
    private func takePicture() {
        guard let cameraController = cameraController else { return }
        
        let photoSettings = AVCapturePhotoSettings()
        cameraController.photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    // Background Colors Setup
    private func setBGColors() {
        
        // Get BGColor
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        // Set Buttons Images
        captureImageButton.setImage(color.cameraButton, for: .normal)
        flashButton.setImage(nil, for: .normal)
        rotateCameraButton.setImage(nil, for: .normal)
        
        // TODO: - Set Images for flashButton and rotateCameraButton
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Send image to PhotoPreviewVC
        if segue.identifier == "ShowPhotoPreviewSegue" {
            
            guard let photoPreviewVC = segue.destination as? PhotoPreviewViewController else { return }
            photoPreviewVC.controllers = controllers
            photoPreviewVC.image = image
            photoPreviewVC.didStartNewReminder = didStartNewReminder
            photoPreviewVC.nrDetailDelegate = nrDetailDelegate
        }
    }
}

// MARK: - Extensions

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    // To get information about the captured image, with the data captured from output
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        // This method gives you the still image in data, in the parameter "photo"
        // Convert it to UIImage
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            
            performSegue(withIdentifier: "ShowPhotoPreviewSegue", sender: self)
        }
    }
}

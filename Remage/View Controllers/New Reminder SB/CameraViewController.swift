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
    
    var reminderController: ReminderController?
    var cameraController: CameraController?
    
    var captureType: CaptureType = .picture
    var selectedCamera: SelectedCamera = .back
    
    var photoOutput: AVCapturePhotoOutput?
    var videoOutput: AVCaptureMovieFileOutput?
    
    var image: UIImage?
    
    // MARK: - Outlets
    
    @IBOutlet weak var cameraView: CameraPreviewView!
    
    @IBOutlet weak var captureImageButton: UIButton!
    @IBOutlet weak var rotateCameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        setupSession()
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Send image to PhotoPreviewVC
        if segue.identifier == "ShowPhotoPreviewSegue" {
            
            guard let photoPreviewVC = segue.destination as? PhotoPreviewViewController else { return }
            photoPreviewVC.reminderController = reminderController
            photoPreviewVC.image = image
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

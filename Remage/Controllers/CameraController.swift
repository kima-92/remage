//
//  CameraController.swift
//  Remage
//
//  Created by macbook on 7/2/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController {
    
    // MARK: - Properties
    var captureSession = AVCaptureSession()
    var cameraPreviewView: CameraPreviewView?
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var microphone: AVCaptureDevice?
    
    var currentCamera: AVCaptureDevice?
    
    var captureType: CaptureType = .picture
    var selectedCamera: SelectedCamera = .back
    var newImage: UIImage?
    
    lazy var photoOutput = AVCapturePhotoOutput()
    lazy var videoOutput = AVCaptureMovieFileOutput()
    
    // MARK: - Methods
    
    func setupCameraPreviewView() {
        
        guard let cameraPreviewView = cameraPreviewView else { return }
        
        // Set Photo Orientation
        if UIDevice.current.orientation == .portrait {
            cameraPreviewView.videoPlayerView.connection?.videoOrientation = .portrait
        } else if UIDevice.current.orientation == .portraitUpsideDown {
            cameraPreviewView.videoPlayerView.connection?.videoOrientation = .portraitUpsideDown
        } else if UIDevice.current.orientation == .landscapeLeft {
            cameraPreviewView.videoPlayerView.connection?.videoOrientation = .landscapeLeft
        } else if UIDevice.current.orientation == .landscapeRight {
            cameraPreviewView.videoPlayerView.connection?.videoOrientation = .landscapeRight
        }
        
        // Full screen camera interface
        cameraPreviewView.videoPlayerView.videoGravity = .resizeAspectFill
    }
    
    // Setup Capture Session
    func setupCaptureSession() {
        
        guard let cameraPreviewView = cameraPreviewView else { return }
        
        // Setup the preview Layer
        setupCameraPreviewView()
        
        // Choose the Resolution
        if captureSession.canSetSessionPreset(.hd1920x1080) {
            captureSession.sessionPreset = .hd1920x1080
        }
        
        // BackCamera choosen for Picture
        if captureType == .picture && selectedCamera == .back {
            
            setBackCamera()
            guard let backCamera = backCamera else { return }
            
            // Add inputs if not added yet
            if captureSession.inputs.isEmpty {
                
                let isInputAdded = addInputFrom(device: backCamera)
                guard isInputAdded else { return }
                
                // Set photoSettings to encode as jpeg
                let photoSettings = [AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])]
                photoOutput.setPreparedPhotoSettingsArray(photoSettings, completionHandler: nil)
                
                // Add Output
                if captureSession.canAddOutput(photoOutput) {
                    captureSession.addOutput(photoOutput)
                    
                } else {
                    // TODO: - Inform the user
                    NSLog("Can't add photoOutput")
                }
            }
            cameraPreviewView.session = captureSession
            captureSession.startRunning()
        }
        
        // FrontCamera choosen for Picture
        else if captureType == .picture && selectedCamera == .front {
            
            // TODO: - Setup for front Camera
            setFrontCamera()
        }
    }
    
    // Stop Running
    func stopRunningSession() {
        captureSession.stopRunning()
    }
    
    // Add input to CaptureSession from a device
    private func addInputFrom(device: AVCaptureDevice) -> Bool {
        
        if let deviceInput = try? AVCaptureDeviceInput(device: device) {
            captureSession.addInput(deviceInput)
            return true
            
        } else {
            // TODO: - Inform the user
            NSLog("Can't create input from camera")
            return false
        }
    }
    
    // Get the best backCamera option for this device
    private func setBackCamera() {
        
        if let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) {
            backCamera = ultraWideCamera
            
        } else if let wideCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = wideCamera
            
        } else {
            // TODO: - Look for a better way of searching for ALL possible back cameras
            
            // Get all the cameras for this device
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
            
            let devices = deviceDiscoverySession.devices
            
            for camera in devices {
                
                if camera.position == AVCaptureDevice.Position.back {
                    backCamera = camera
                    
                } else {
                    NSLog("No back cameras found on this device")
                    backCamera = nil
                    
                    // TODO: - Alert the user
                }
            }
        }
    }
    
    // Get the best frontCamera option for this device
    private func setFrontCamera() {
        
        if let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .front) {
            frontCamera = ultraWideCamera
            
        } else if let wideCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = wideCamera
            
        } else {
            // TODO: - Look for a better way of searching for ALL possible front cameras
            
            // Get all the cameras for this device
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
            
            let devices = deviceDiscoverySession.devices
            
            for camera in devices {
                
                if camera.position == AVCaptureDevice.Position.front {
                    frontCamera = camera
                    
                } else {
                    NSLog("No front cameras found on this device")
                    frontCamera = nil
                    
                    // TODO: - Alert the user
                }
            }
        }
    }
    
    // Best microphone for this device
    private func setBestMicrophone() {
        
        // If there's an audio device, set it as the microphone
        if let device = AVCaptureDevice.default(for: .audio) {
            microphone = device
        }
        
        NSLog("No microphone device found to record Audio")
        microphone = nil
    }
}

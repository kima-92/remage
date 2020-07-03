//
//  PhotoPreviewViewController.swift
//  Remage
//
//  Created by macbook on 7/3/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class PhotoPreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    var image: UIImage?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        savePhoto()
    }
    
    // MARK: - Methods
    
    // Save image in Photo Album
    private func savePhoto() {
        guard let image = image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateViews() {
        guard let image = image else { return }
        imageView.image = image
    }
}

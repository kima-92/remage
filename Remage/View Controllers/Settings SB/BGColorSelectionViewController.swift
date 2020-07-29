//
//  BGColorSelectionViewController.swift
//  Remage
//
//  Created by macbook on 7/29/20.
//  Copyright © 2020 WilmaRodz. All rights reserved.
//

import UIKit

class BGColorSelectionViewController: UIViewController {
    
    // MARK: - Properties
    var colorsCollectionView: UICollectionView?
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: view.bounds.height / 2)
        
        // Size of colorsCollectionView
        colorsCollectionView?.frame = view.bounds
        //colorsCollectionView?.frame = size
    }
    
    // MARK: - Methods
    
    // Setup colorsCollectionView
    private func setupCollectionView() {
        
        // Setup CollectionView's Layout
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // Size of each cell
        let cellSize = view.frame.size.width/2.2
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        
        // Setup collectionView
        colorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        colorsCollectionView?.delegate = self
        colorsCollectionView?.dataSource = self
        
        // Background Color
        colorsCollectionView?.backgroundColor = .cyan
        
        // Register cell class
        colorsCollectionView?.register(ColorCollectionViewCell.nib(), forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        
        // Add it to the view
        if let colorsCollectionView = colorsCollectionView {
            view.addSubview(colorsCollectionView)
        }
    }
}

// MARK: - Extension

// CollectionView Protocols
extension BGColorSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

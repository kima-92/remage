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
    
    var headerView = UIView()
    var cellSize: CGFloat?
    
    var titleLabel: UILabel = {
       
        let label = UILabel()
        
        label.text = "Choose Color Theme!"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods
    
    // Setup colorsCollectionView
    private func setupCollectionView() {
        
        // Setup CollectionView's Layout
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Size of each cell
        let cellSize = view.frame.size.width/2
        self.cellSize = cellSize
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        
        // Setup collectionView
        colorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        colorsCollectionView?.delegate = self
        colorsCollectionView?.dataSource = self
        
        // Register the cell
        colorsCollectionView?.register(ColorCollectionViewCell.nib(), forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        
        // Add it to the view
        guard let colorsCollectionView = colorsCollectionView else { return }
        
        view.addSubview(colorsCollectionView)
        
        // Constraints
        colorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        colorsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant:  20).isActive = true
        colorsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        colorsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        colorsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        
        colorsCollectionView.heightAnchor.constraint(equalToConstant: (cellSize * 2) / 1.5).isActive = true
    }
    
    // HeaderView Setup
    private func setupHeaderView() {
        
        // Header
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // NameLabel
        headerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
    }
    
    // Set Background Colors
    private func setBGColors() {
        headerView.backgroundColor = .darkGray
        titleLabel.backgroundColor = .magenta
        colorsCollectionView?.backgroundColor = .cyan
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        setupHeaderView()
        setupCollectionView()
        setBGColors()
    }
}

// MARK: - Extension

// CollectionView Protocols
extension BGColorSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // Dequeue the Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

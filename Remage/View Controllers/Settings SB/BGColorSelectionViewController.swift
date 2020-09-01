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
    
    var controllers: ModelControllers?
    var user: User?
    
    var colorsCollectionView: UICollectionView?
    var headerView = UIView()
    
    var chooseColorLabel: UILabel = {
       
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
        
        colorsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant:  view.bounds.height / 15).isActive = true
        colorsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        colorsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        colorsCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2).isActive = true
    }
    
    // HeaderView Setup
    private func setupHeaderView() {
        
        // Header
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        headerView.layer.cornerRadius = 15
        
        // NameLabel
        headerView.addSubview(chooseColorLabel)
        
        chooseColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chooseColorLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 40).isActive = true
        chooseColorLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -40).isActive = true
        chooseColorLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        chooseColorLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        
        chooseColorLabel.layer.cornerRadius = 5
        chooseColorLabel.layer.masksToBounds = true
    }
    
    // MARK: - Update Views
    
    private func updateViews() {
        
        guard let controllers = controllers,
            let color = controllers.themeController.currentColor else { return }
        
        setupHeaderView()
        setupCollectionView()
        setBGColors(color: color)
    }
    
    // Set Background Colors
    private func setBGColors(color: BGColor) {
        setTabBarsBGColors(color: color)
        
        headerView.backgroundColor = color.bgColor
        colorsCollectionView?.backgroundColor = color.highlightColor
        
        // Label
        chooseColorLabel.backgroundColor = color.bgColor
        chooseColorLabel.textColor = color.fontColor
    }
}

// MARK: - Extension

// CollectionView Protocols
extension BGColorSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers?.themeController.bgColors.count ?? 0
    }
    
    // Dequeue the Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
        
        // Set BGColor for this Cell
        cell.color = controllers?.themeController.bgColors[indexPath.item]
        cell.setColors()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let controllers = controllers,
            let user = user else { return }
        
        // Get chosen Color
        let color = controllers.themeController.bgColors[indexPath.item]
        
        // Set this color as the User's bgColor
        controllers.userController.setBGColorFor(user: user, color: color)
        
        // Set as currentColor in the ThemeController
        controllers.themeController.userSetColorAs(color: color)
        
        // Change the background colors of this VC
        setBGColors(color: color)
    }
}

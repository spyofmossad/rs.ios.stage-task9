//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class MainViewController: UIViewController {
    
    private let itemsPerRow = 2
    private let interItemSpacing = 16
    private let interLineSpacing = 30
    private var leftRightInset = 20
                
    private lazy var itemsCollection: UICollectionView = {
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(ItemCell.self, forCellWithReuseIdentifier: "itemCell")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Items", image: UIImage(systemName: "square.grid.2x2"), tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.view.addSubview(itemsCollection)
        NSLayoutConstraint.activate([
            itemsCollection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            itemsCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            itemsCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            itemsCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraints()
    }
    
    private func setupConstraints() {
        let size = UIScreen.main.bounds.size
        leftRightInset = size.width < size.height ? 20 : 35
    }
    
    private func updateConstraints() {
        leftRightInset = UIDevice.current.orientation.isPortrait ? 20 : 35
        itemsCollection.collectionViewLayout.invalidateLayout()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch FillingData.data[indexPath.row] {
        case .story(let story):
            coordinator.goToStoryScreen(from: self, content: story)
        case .gallery(let gallery):
            coordinator.goToGalleryScreen(from: self, content: gallery)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FillingData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell {
            let data = FillingData.data[indexPath.row]
            cell.prepare(with: data)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableSpace = Int(self.view.bounds.width) - (leftRightInset * 2) - (interItemSpacing * (itemsPerRow - 1))
        return CGSize(width: availableSpace / itemsPerRow, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: CGFloat(leftRightInset), bottom: 40, right: CGFloat(leftRightInset))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interLineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interItemSpacing)
    }
}

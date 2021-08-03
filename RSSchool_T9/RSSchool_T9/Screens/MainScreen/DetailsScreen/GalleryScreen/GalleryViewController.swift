//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryViewController: HeaderViewController {
    
    private var itemSize = CGSize.zero
    private var interItemSpace: CGFloat = 20
    private var leftRightPadding: CGFloat = 20
    private var collectionViewHeight = NSLayoutConstraint()
    
    var isPortrait: Bool {
        if !UIDevice.current.orientation.isValidInterfaceOrientation {
            let size = UIScreen.main.bounds.size
            if size.width < size.height {
                return true
            }
            return false
        }
        
        return UIDevice.current.orientation.isPortrait
    }
    
    private var coordinator: AppCoordinator
    private var data: Gallery
    
    private lazy var imagesCollection: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ImageViewCell.self, forCellWithReuseIdentifier: "imageCell")
        return collection
    }()
    
    init(coordinator: AppCoordinator, gallery data: Gallery) {
        self.coordinator = coordinator
        self.data = data
        super.init(coordinator: coordinator, coverImage: data.coverImage, headerTitle: data.title, type: data.type)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        scrollContainer.addSubview(imagesCollection)
        collectionViewHeight = imagesCollection.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            collectionViewHeight,
            imagesCollection.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 40),
            imagesCollection.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor),
            imagesCollection.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor),
            imagesCollection.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor, constant: -30)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        if isPortrait {
            imagesCollection.collectionViewLayout.invalidateLayout()
            let collectionHeight = itemSize.height * CGFloat(data.images.count) + (CGFloat(data.images.count - 1) * interItemSpace)
            collectionViewHeight.constant = collectionHeight
        } else {
            imagesCollection.collectionViewLayout.invalidateLayout()
            let rowsCount = CGFloat(data.images.count / 2)
            let collectionHeight = rowsCount * itemSize.height + (rowsCount - 1) * interItemSpace
            collectionViewHeight.constant = collectionHeight
        }
        
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.goToImageScreen(from: self, image: data.images[indexPath.row])
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imagesCollection.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageViewCell {
            cell.prepate(with: data.images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isPortrait {
            let width = collectionView.bounds.width - (leftRightPadding * 2)
            itemSize = CGSize(width: width, height: width * 1.36)
        } else {
            let width = (collectionView.bounds.width - (leftRightPadding * 4) - interItemSpace) / 2
            itemSize = CGSize(width: width, height: width * 1.36)
        }
        return CGSize(width: itemSize.width, height: itemSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isPortrait {
            return UIEdgeInsets(top: 0, left: leftRightPadding, bottom: 0, right: leftRightPadding)
        }
        
        return UIEdgeInsets(top: 0, left: leftRightPadding * 2, bottom: 0, right: leftRightPadding * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if isPortrait {
            return 0
        }
        return interItemSpace
    }
}

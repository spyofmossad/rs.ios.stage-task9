//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryViewController: HeaderViewController {
    
    private var textContainerLeft = NSLayoutConstraint()
    private var textContainerRight = NSLayoutConstraint()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 75
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        layout.itemSize = CGSize(width: 75, height: 75)
        return layout
    }()
    
    private lazy var drawsCollection: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(DrawItemCell.self, forCellWithReuseIdentifier: "drawCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private var textContainer: UIView = {
        let container = UIView()
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.cornerRadius = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private var text: UILabel = {
        let label = GoodSizeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rockwell-Regular", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        return label
    }()

    private var coordinator: AppCoordinator
    private var data: Story
    private var settings: StoriesSettings
    
    init(coordinator: AppCoordinator, story data: Story, settings: StoriesSettings) {
        self.coordinator = coordinator
        self.data = data
        self.settings = settings
        super.init(coordinator: coordinator, coverImage: data.coverImage, headerTitle: data.title, type: data.type)
        self.modalPresentationStyle = .fullScreen
        text.text = data.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraints()
    }
    
    private func setupSubviews() {
        scrollContainer.addSubview(drawsCollection)
        scrollContainer.addSubview(textContainer)
        textContainer.addSubview(text)
        
        textContainerLeft = textContainer.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 20)
        textContainerRight = textContainer.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            drawsCollection.topAnchor.constraint(equalTo: super.lineView.bottomAnchor, constant: 55),
            drawsCollection.heightAnchor.constraint(equalToConstant: 75),
            drawsCollection.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 20),
            drawsCollection.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -20),
            
            textContainer.topAnchor.constraint(equalTo: drawsCollection.bottomAnchor, constant: 58),
            textContainerLeft,
            textContainerRight,
            textContainer.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor, constant: -20),
            
            text.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 30),
            text.leftAnchor.constraint(equalTo: textContainer.leftAnchor, constant: 30),
            text.rightAnchor.constraint(equalTo: textContainer.rightAnchor, constant: -30),
            text.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupConstraints() {
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            textContainerLeft.constant = portraitConstant
            textContainerRight.constant = -portraitConstant
        } else {
            textContainerLeft.constant = landscapeConstant
            textContainerRight.constant = -landscapeConstant
        }
    }
    
    private func updateConstraints() {
        if UIDevice.current.orientation.isPortrait {
            textContainerLeft.constant = portraitConstant
            textContainerRight.constant = -portraitConstant
        } else {
            textContainerLeft.constant = landscapeConstant
            textContainerRight.constant = -landscapeConstant
            drawsCollection.collectionViewLayout.invalidateLayout()
        }
    }
}

extension StoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            drawsCollection.isScrollEnabled = true
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        } else {
            drawsCollection.isScrollEnabled = false
            let collectionWidth = drawsCollection.bounds.width
            let itemsCount = data.paths.count
            let width = 75
            let inset = (Int(collectionWidth) - (itemsCount * width) - ((itemsCount - 1) * width)) / 2
            return UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: CGFloat(inset))
        }
    }
}

extension StoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.paths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = drawsCollection.dequeueReusableCell(withReuseIdentifier: "drawCell", for: indexPath) as? DrawItemCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DrawItemCell {
            cell.prepare(with: data.paths[indexPath.row], settings: settings)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DrawItemCell {
            cell.clean()
        }
    }
}

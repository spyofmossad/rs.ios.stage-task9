//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class HeaderViewController: UIViewController {
    
    var portraitConstant: CGFloat = 20
    var landscapeConstant: CGFloat = 150
    private var headerLeft : NSLayoutConstraint?
    private var headerRight : NSLayoutConstraint?
    
    public lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    public lazy var scrollContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var closeBtn: CloseButton = {
        let button = CloseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeOnTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = coverImage
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var itemTitle: GoodSizeLabel = {
        let label = GoodSizeLabel()
        label.text = headerTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rockwell-Regular", size: 48)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private lazy var itemTypeView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .black
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.cornerRadius = 8
        container.addSubview(itemType)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 40),
            itemType.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 3),
            itemType.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),
            itemType.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -30),
        ])
        return container
    }()
    
    private lazy var itemType: GoodSizeLabel = {
        let label = GoodSizeLabel()
        label.text = type
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rockwell-Regular", size: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var shadowLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.5]
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        return gradient
    }()
    
    private var coordinator: AppCoordinator
    private var coverImage: UIImage
    private var headerTitle: String
    private var type: String
    
    init(coordinator: AppCoordinator, coverImage: UIImage, headerTitle: String, type: String) {
        self.coordinator = coordinator
        self.coverImage = coverImage
        self.headerTitle = headerTitle
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        shadowLayer.frame = headerImage.bounds
    }
    
    private func updateConstraints() {
        if UIDevice.current.orientation.isPortrait {
            headerLeft?.constant = portraitConstant
            headerRight?.constant = -portraitConstant
        } else {
            headerLeft?.constant = landscapeConstant
            headerRight?.constant = -landscapeConstant
        }
    }
    
    private func setupConstraints() {
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            headerLeft?.constant = portraitConstant
            headerRight?.constant = -portraitConstant
        } else {
            headerLeft?.constant = landscapeConstant
            headerRight?.constant = -landscapeConstant
        }
    }
        
    private func setupSubviews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubview(closeBtn)
        scrollContainer.addSubview(headerImage)
        scrollContainer.addSubview(itemTypeView)
        scrollContainer.addSubview(lineView)
        headerImage.addSubview(itemTitle)
        
        headerLeft = headerImage.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 20)
        headerRight = headerImage.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            scrollContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            closeBtn.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 30),
            closeBtn.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -25),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            
            headerImage.topAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: 30),
            headerLeft!,
            headerRight!,
            headerImage.heightAnchor.constraint(equalToConstant: 500),
            
            itemTitle.leftAnchor.constraint(equalTo: headerImage.leftAnchor, constant: 30),
            itemTitle.rightAnchor.constraint(equalTo: headerImage.rightAnchor, constant: -30),
            itemTitle.bottomAnchor.constraint(equalTo: itemTypeView.topAnchor, constant: -34),
            
            itemTypeView.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor),
            itemTypeView.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: -20),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -100),
            lineView.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 100),
            lineView.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 58)

        ])
        
        headerImage.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    @objc private func closeOnTap() {
        coordinator.close(controller: self)
    }
}

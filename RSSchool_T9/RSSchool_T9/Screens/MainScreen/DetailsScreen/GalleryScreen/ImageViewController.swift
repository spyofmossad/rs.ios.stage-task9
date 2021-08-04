//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ImageViewController: UIViewController {
    
    private var top = NSLayoutConstraint()
    private var left = NSLayoutConstraint()
    private var right = NSLayoutConstraint()
    private var bottom = NSLayoutConstraint()
    
    private lazy var closeBtn: CloseButton = {
        let button = CloseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeOnTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.minimumZoomScale = 1
        view.maximumZoomScale = 3
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var singleTap: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        return gesture
    }()
    
    private var coordinator: AppCoordinator
    private var image: UIImage
    
    init(coordinator: AppCoordinator, image: UIImage) {
        self.coordinator = coordinator
        self.image = image
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.view.backgroundColor = .black
        self.view.addGestureRecognizer(singleTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    func setupSubviews() {
        self.view.addSubview(imageScrollView)
        imageScrollView.addSubview(imageView)
        self.view.addSubview(closeBtn)
        
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            closeBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            
            imageScrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageScrollView.frameLayoutGuide.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            imageScrollView.frameLayoutGuide.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            imageScrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            imageScrollView.contentLayoutGuide.topAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.topAnchor),
            imageScrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.leftAnchor),
            imageScrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.rightAnchor),
            imageScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: imageScrollView.frameLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageScrollView.contentLayoutGuide.bottomAnchor)
            
        ])
    }
    
    @objc private func closeOnTap() {
        coordinator.close(controller: self)
    }

    @objc private func onTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.1) {
            if self.closeBtn.isHidden {
                self.closeBtn.alpha = 1
            } else {
                self.closeBtn.alpha = 0
            }

        } completion: { _ in
            self.closeBtn.isHidden = !self.closeBtn.isHidden
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        imageScrollView.zoomScale = 1
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

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
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: image)
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLayoutSubviews() {
        minZoomScale()
    }
    
    func setupSubviews() {
        self.view.addSubview(imageScrollView)
        imageScrollView.addSubview(imageView)
        self.view.addSubview(closeBtn)
        
        top = imageView.topAnchor.constraint(equalTo: imageScrollView.topAnchor)
        left = imageView.leftAnchor.constraint(equalTo: imageScrollView.leftAnchor)
        right = imageView.rightAnchor.constraint(equalTo: imageScrollView.rightAnchor)
        bottom = imageView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor)
        
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            closeBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            closeBtn.heightAnchor.constraint(equalToConstant: 40),
            closeBtn.widthAnchor.constraint(equalToConstant: 40),
            
            imageScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            imageScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            imageScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            imageScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            top, left, right, bottom
        ])
    }
    
    private func updateConstraints() {
        let y = max(0, (self.view.bounds.height - imageView.frame.height) / 2)
        top.constant = y
        bottom.constant = y
        
        let x = max(0, (self.view.bounds.width - imageView.frame.width) / 2)
        left.constant = x
        right.constant = x
        
        self.view.layoutIfNeeded()
    }
    
    private func minZoomScale() {
        let bounds = self.view.bounds
        let imageSize = imageView.bounds.size

        let xScale = bounds.width / imageSize.width
        let yScale = bounds.height / imageSize.height
        let minScale = min(xScale, yScale)
        self.imageScrollView.minimumZoomScale = minScale
        self.imageScrollView.maximumZoomScale = minScale * 3
        self.imageScrollView.zoomScale = minScale
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
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
       updateConstraints()
    }
}

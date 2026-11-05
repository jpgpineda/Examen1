//
//  LoaderViewController.swift
//  Bankodemia
//
//  Created by javier pineda on 29/10/26.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    
    @IBOutlet weak var animationContainer: UIView!
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let animation = LottieAnimationView(name: "loader_2")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        animationContainer.addSubview(animation)
        
        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: animationContainer.topAnchor),
            animation.bottomAnchor.constraint(equalTo: animationContainer.bottomAnchor),
            animation.leadingAnchor.constraint(equalTo: animationContainer.leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: animationContainer.trailingAnchor)
        ])
        animationView = animation
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        animationView?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        animationView?.stop()
    }
    
    
    
    deinit {
        animationView?.stop()
    }
}

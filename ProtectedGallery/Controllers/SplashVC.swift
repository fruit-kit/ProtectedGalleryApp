//
//  ViewController.swift
//  ProtectedGallery
//
//  Created by User on 04.05.2024.
//

import UIKit

import Lottie

class SplashVC: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SplashAnimation()
    }

    private func SplashAnimation() {
        
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode = .loop
        
        animationView.animationSpeed = 0.5
        
        animationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            [weak self] in
            self?.animationView.pause()
        }
    }
    
}


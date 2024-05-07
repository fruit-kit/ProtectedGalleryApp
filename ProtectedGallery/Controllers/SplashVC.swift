//
//  ViewController.swift
//  ProtectedGallery
//
//  Created by User on 04.05.2024.
//

import UIKit

import Lottie

class SplashVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SplashAnimation()
        
    }
    
    // MARK: - Private Methods
    
    private func SplashAnimation() {
        
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode = .loop
        
        animationView.animationSpeed = 0.5
        
        animationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            [weak self] in
            
            self?.animationView.pause()
            
            self?.presentGalleryVC()
            
        }
        
    }
    
    private func presentGalleryVC() {
        
        let destinationVC = LoginVC()
        
        destinationVC.modalPresentationStyle = .fullScreen
        
        self.present(destinationVC, animated: true)
        
    }
    
}


//
//  LoginVC.swift
//  ProtectedGallery
//
//  Created by User on 05.05.2024.
//

import UIKit

import LocalAuthentication

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var displayPinLabel: UILabel!
    
    // MARK: - Properties
    
    var requiredPin = "1111"
    
    var enteredPin = "" {
        
        didSet {
            
            let pinLenght = enteredPin.count
            
            let maskedPin = String(repeating: "*", count: pinLenght)
            
            self.displayPinLabel.text = maskedPin
            
            if enteredPin == requiredPin {
                
                presentGalleryVC()
                
            }
            
            if enteredPin == "" {
                
                displayPinLabel.text = "Enter PIN"
                
            }
            
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction func pinNumberButtonPressed(_ sender: UIButton) {
        
        self.enteredPin.append("\(sender.tag)")
        
    }
    
    
    @IBAction func faceIDButtonPressed(_ sender: Any) {
        
        authenticate()
        
    }
    
    
    @IBAction func deleteSymbolButtonPressed(_ sender: Any) {
        
        guard !self.enteredPin.isEmpty else {
            
            self.displayPinLabel.text = "Enter PIN"
            
            return
            
        }
        
        self.enteredPin.removeLast()
        
    }
    
    // MARK: - Private Methods
    
    private func presentGalleryVC() {
        
        let destinationVC = GalleryVC()
        
        destinationVC.modalPresentationStyle = .fullScreen
        
        self.present(destinationVC, animated: true)
        
    }
    
    private func authenticate() {
        
        let context = LAContext()
        
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    
                    guard success, error == nil else{
                        
                        return
                        
                    }
                    
                    self?.presentGalleryVC()
                    
                }
                
            }
            
        } else {
            
            let alert = UIAlertController(title: "Unavailable", message: "FaceID Auth not available", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
            
        }
        
    }
    
}

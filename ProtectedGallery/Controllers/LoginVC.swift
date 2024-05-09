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
                
                let destinationVC = GalleryVC()
                
                destinationVC.modalPresentationStyle = .fullScreen
                
                self.present(destinationVC, animated: true)
                
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
        
        print(#function)
        
    }
    
    
    @IBAction func deleteSymbolButtonPressed(_ sender: Any) {
        
        guard !self.enteredPin.isEmpty else {
            
            self.displayPinLabel.text = "Enter PIN"
            
            return
            
        }
        
        self.enteredPin.removeLast()
        
    }
    
}

//
//  LoginVC.swift
//  ProtectedGallery
//
//  Created by User on 05.05.2024.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var displayPinLabel: UILabel!
    
    var requiredPin = "1111"
    
    var enteredPin = "" {
        
        didSet {
            
            let pinLenght = enteredPin.count
            
            let maskedPin = String(repeating: "*", count: pinLenght)
            
            self.displayPinLabel.text = maskedPin
            
            if enteredPin == requiredPin {
                
                print("You have entered!")
                
            }
            
            if enteredPin == "" {
                
                displayPinLabel.text = "Enter PIN"
                
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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

//
//  GalleryVC.swift
//  ProtectedGallery
//
//  Created by User on 07.05.2024.
//

import UIKit

class GalleryVC: UIViewController {
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
        showImagePickerAlert()
        
    }
    
    // MARK: - Private Methods
    
    private func showImagePickerAlert() {
        
        let alert = UIAlertController(title: "Add photo",
                                      message: "Choose source for adding photo",
                                      preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) {_ in
            
            self.showImagePickerControlle(source: .camera)
            
        }
        
        let galleryAction = UIAlertAction(title: "Open Gallery", style: .default) {_ in
            
            self.showImagePickerControlle(source: .photoLibrary)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        
        alert.addAction(galleryAction)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    private func showImagePickerControlle(source type: UIImagePickerController.SourceType) {
        
        if type == .camera {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            
            imagePicker.sourceType = .camera
            
            self.present(imagePicker, animated: true)
            
        } else if type == .photoLibrary {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true)
            
        }
        
    }
    
}

// MARK: - Extensions

// MARK: UIImagePickerControllerDelegate

extension GalleryVC: UIImagePickerControllerDelegate {
    
}

// MARK: UINavigationControllerDelegate

extension GalleryVC: UINavigationControllerDelegate {
    
}

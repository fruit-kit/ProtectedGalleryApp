//
//  GalleryVC.swift
//  ProtectedGallery
//
//  Created by User on 07.05.2024.
//

import UIKit

class GalleryVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            
            if let imageData = image.pngData() {
                
                let fileManager = FileManager.default
                
                guard let documentsURL = fileManager.urls(
                    for: .documentDirectory,
                    in: .userDomainMask
                ).first else {
                    
                    return
                    
                }
                
                let mediaFolderName = "Media"
                
                let mediaURL = documentsURL.appendingPathComponent(mediaFolderName)
                
                if !fileManager.fileExists(atPath: mediaURL.path) {
                    
                    do {
                        
                        try fileManager.createDirectory(at: mediaURL, withIntermediateDirectories: false, attributes: nil)
                        
                        print("Media folder created successfully")
                        
                    } catch {
                        
                        print("Error creating media folder: \(error)")
                        
                    }
                    
                }
                
                let uniqueFileName = UUID().uuidString + ".png"
                
                let fileURL = mediaURL.appendingPathComponent(uniqueFileName)
                
                do {
                    
                    try imageData.write(to: fileURL)
                    
                    print("Image successfully saved to \(fileURL)")
                    
                    if let loadImage = UIImage(contentsOfFile: fileURL.path) {
                        
                        // MARK: Если нужно что-то сделать с загруженным изображением
                        
                    }
                    
                } catch {
                    
                    print("Error saving image: \(error)")
                    
                }
                
            }
            
        } else if let image = info[.originalImage] as? UIImage {
            if let imageData = image.pngData() {
                
                let fileManager = FileManager.default
                
                guard let documentsURL = fileManager.urls(
                    for: .documentDirectory,
                    in: .userDomainMask
                ).first else {
                    
                    return
                    
                }
                
                let mediaFolderName = "Media"
                
                let mediaURL = documentsURL.appendingPathComponent(mediaFolderName)
                
                if !fileManager.fileExists(atPath: mediaURL.path) {
                    
                    do {
                        
                        try fileManager.createDirectory(at: mediaURL, withIntermediateDirectories: false, attributes: nil)
                        
                        print("Media folder created successfully")
                        
                    } catch {
                        
                        print("Error creating media folder: \(error)")
                        
                    }
                    
                }
                
                let uniqueFileName = UUID().uuidString + ".png"
                
                let fileURL = mediaURL.appendingPathComponent(uniqueFileName)
                
                do {
                    
                    try imageData.write(to: fileURL)
                    
                    print("Image successfully saved to \(fileURL)")
                    
                    if let loadImage = UIImage(contentsOfFile: fileURL.path) {
                        
                        // MARK: Если нужно что-то сделать с загруженным изображением
                        
                    }
                    
                } catch {
                    
                    print("Error saving image: \(error)")
                    
                }
                
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: UINavigationControllerDelegate

extension GalleryVC: UINavigationControllerDelegate {
    
}

// MARK: UICollectionViewDelegate

extension GalleryVC: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource

extension GalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        UICollectionViewCell()
        
    }
    
}

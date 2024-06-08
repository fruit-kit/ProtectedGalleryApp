//
//  GalleryVC.swift
//  ProtectedGallery
//
//  Created by User on 07.05.2024.
//

import UIKit

class GalleryVC: UIViewController {
    
    // MARK: - Properties
    
    private let photosPerRow: CGFloat = 4
    
    private let spacingBetweenPhotos: CGFloat = 5
    
    private lazy var sectionInsets: UIEdgeInsets = {
        return UIEdgeInsets(top: spacingBetweenPhotos, left: spacingBetweenPhotos, bottom: spacingBetweenPhotos, right: spacingBetweenPhotos)
    }()
    
    private var arrayOfPhotos: [UIImage] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerGalleryCell()
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
        loadImagesFromDirectory()
        
    }
    
    // MARK: - Private Methods
    
    private func loadImagesFromDirectory() {
        
        let fileManager = FileManager.default
        
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let mediaFolderName = "Media"
        
            let mediaURL = documentsURL.appendingPathComponent(mediaFolderName)
        
        do {
            
                let fileURLs = try fileManager.contentsOfDirectory(at: mediaURL, includingPropertiesForKeys: nil)
            
                for fileURL in fileURLs {
                    
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        
                        self.arrayOfPhotos.append(image)
                        
                    }
                    
                }
            
                self.collectionView.reloadData()
            
            } catch {
                
                print("Error while enumerating files \(mediaURL.path): \(error.localizedDescription)")
                
            }
        
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
        showImagePickerAlert()
        
    }
    
    // MARK: - Private Methods
    
    private func registerGalleryCell() {
        
        let galleryNib = UINib(nibName: "GalleryCollectionViewCell", bundle: .main)
        
        collectionView.register(galleryNib, forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
    }
    
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
                        
                        self.arrayOfPhotos.append(loadImage)
                        
                        self.collectionView.reloadData()
                        
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
                        
                        self.arrayOfPhotos.append(loadImage)
                        
                        self.collectionView.reloadData()
                        
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

// MARK: UICollectionViewDataSource

extension GalleryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.arrayOfPhotos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as? GalleryCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        
        cell.imageView.image = self.arrayOfPhotos[indexPath.row]
        
        return cell
        
    }
    
}

// MARK: UICollectionViewDelegate

extension GalleryVC: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension GalleryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing = spacingBetweenPhotos * (photosPerRow - 1) + sectionInsets.left + sectionInsets.right
        
        let width = (self.view.frame.width - totalSpacing) / photosPerRow
        
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
           return sectionInsets
        
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
           return spacingBetweenPhotos
           
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           
           return spacingBetweenPhotos
           
       }
    
}

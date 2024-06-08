//
//  FullScreenPhotoVC.swift
//  ProtectedGallery
//
//  Created by Admin on 08.06.2024.
//

import UIKit

class FullScreenPhotoVC: UIViewController {
    
    var photo: UIImage? = nil

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = self.photo {
            
            self.imageView.image = photo
            
        }
        
    }

}

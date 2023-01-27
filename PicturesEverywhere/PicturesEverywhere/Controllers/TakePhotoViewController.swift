//
//  TakePhotoViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import UIKit

class TakePhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    private var context = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    override func viewDidAppear(
        _ animated: Bool
    ) {
        self.setupComponents()
    }
    
    private func setupComponents() {
        // Title View Controller
        self.title = "Picture Screen"
        
        // Picker Configuration
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(
            picker,
            animated: true
        )
    }
}

extension TakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        picker.dismiss(animated: true) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)
        
        guard
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
            let imageData = image.pngData()
        else {
            return
        }
        
        self.photoImageView.contentMode = .scaleToFill
        self.photoImageView.image = image
        
        let picture = Picture(context: self.context)
        picture.location = "No se donde estoy parado"
        picture.content = UIImage(data: imageData)
        
        try? self.context.save()
    }
}

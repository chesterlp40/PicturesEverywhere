//
//  MainGalleryViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import UIKit
import CoreData

class MainGalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var takePictureButton: UIButton!
    
    internal let viewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    override func viewWillAppear(
        _ animated: Bool
    ) {
        self.viewModel.fetchPictures()
        self.galleryCollection.reloadData()
    }
    
    private func setupComponents() {
        // Title View Controller
        self.title = "Main Gallery"
        
        // Button Configuration
        self.takePictureButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.takePictureButton.layer.cornerRadius = 10
        
        // Collection Configuration
        self.galleryCollection.delegate = self
        self.galleryCollection.dataSource = self
        self.galleryCollection.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if
            let indexPath = self.galleryCollection.indexPathsForSelectedItems,
            let row = indexPath.first?.row,
            segue.identifier == "toDetailView"
        {
            let controller = segue.destination as? DetailViewController
            controller?.picture = self.viewModel.pictures[row]
        }
    }
    
    @IBAction func takePictureButtonPressed(
        _ sender: UIButton
    ) {
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

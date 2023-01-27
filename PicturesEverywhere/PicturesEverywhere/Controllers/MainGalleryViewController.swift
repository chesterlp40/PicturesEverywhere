//
//  MainGalleryViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import UIKit

class MainGalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var takePictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
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
    
    @IBAction func takePictureButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toTakePhoto", sender: self)
    }
    
    override func prepare(
        for segue: UIStoryboardSegue, sender: Any?
    ) {
        switch segue.identifier {
        case "toTakePhoto":
            _ = segue.destination as? TakePhotoViewController
        default:
            let detailViewController = segue.destination as? DetailViewController
            let image = UIImage(systemName: "person.fill")
            detailViewController?.image = image
            detailViewController?.location = "Tu hna en tanga"
        }
        
    
    }
}

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = self.galleryCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = self.galleryCollection.frame.width/6
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // let image = self.galleryCollection[indexPath.row]
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
}

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
    
    private var context = CoreDataManager.sharedInstance.persistentContainer.viewContext
    private var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    override func viewWillAppear(
        _ animated: Bool
    ) {
        self.fetchPictures()
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
    
    private func fetchPictures() {
        let request: NSFetchRequest<Picture> = NSFetchRequest(entityName: "Picture")
        do {
            let pictures: [Picture] = try self.context.fetch(request)
            self.pictures = pictures
            self.galleryCollection.reloadData()
        } catch {
            print(error)
        }
    }
    
    @IBAction func takePictureButtonPressed(
        _ sender: UIButton
    ) {
        self.performSegue(
            withIdentifier: "toTakePhoto",
            sender: self
        )
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
            detailViewController?.location = "Unknown"
        }
    }
}

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.pictures.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let imageView = UIImageView()
        imageView.image = self.pictures[indexPath.row].content
        let cell = self.galleryCollection.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        )
        cell.backgroundView = imageView
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
        self.performSegue(withIdentifier: "toDetailView", sender: self)
    }
}

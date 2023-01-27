//
//  MainGalleryViewController+Extension.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import UIKit
import CoreData

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
        /*let detailViewController = DetailViewController()
        detailViewController.picture = self.pictures[indexPath.row]*/
        self.performSegue(
            withIdentifier: "toDetailView",
            sender: nil
        )
    }
}

extension MainGalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        picker.dismiss(
            animated: true
        )
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
            let imageData = image.pngData()
        else {
            return
        }
        
        let picture = Picture(context: self.context)
        picture.location = "No se donde estoy parado"
        picture.content = UIImage(data: imageData)
        
        try? self.context.save()
        
        picker.dismiss(
            animated: true
        )
    }
}


//
//  MainGalleryViewController+Extension.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import UIKit
import CoreData

// MARK: - MainGalleryViewController Collection View Delegate Section

extension MainGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.viewModel.pictures.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let imageView = UIImageView()
        imageView.image = self.viewModel.pictures[indexPath.row].content
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
        let width: CGFloat = self.galleryCollection.frame.width * 0.30
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        self.performSegue(
            withIdentifier: "toDetailView",
            sender: nil
        )
    }
}

// MARK: - MainGalleryViewController Picker Delegate Section

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
        
        self.viewModel.savePicture(imageData) { [weak self] in
            self?.viewModel.fetchPictures()
            self?.galleryCollection.reloadData()
        }
        
        picker.dismiss(
            animated: true
        )
    }
}


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
            withReuseIdentifier: Constants.mainCellIdentifier,
            for: indexPath
        )
        cell.backgroundView = imageView
        
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.cornerRadius = 5.0
        cell.layer.borderWidth = 0.5
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSizeMake(0, 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(
            roundedRect: cell.bounds,
            cornerRadius: cell.contentView.layer.cornerRadius
        ).cgPath
        
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
            withIdentifier: Constants.mainSegueIdentifier,
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
            if self?.viewModel.pictures.count != 0 {
                self?.noImagesStackView.isHidden = true
            }
        }
        
        picker.dismiss(
            animated: true
        )
    }
}


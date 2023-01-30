//
//  MainGalleryViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import AVFoundation
import CoreData
import CoreLocation
import UIKit

// MARK: - MainGalleryViewController Section

class MainGalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryCollection: UICollectionView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var noImagesStackView: UIStackView!
    
    internal let viewModel = DataViewModel()
    
    // MARK: - LifeCycle Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
        self.fetchInfo()
    }
    
    override func viewWillAppear(
        _ animated: Bool
    ) {
        self.fetchInfo()
    }
    
    // MARK: - Configuration Methods Section
    
    private func setupComponents() {
        self.title = Constants.mainTitleText
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.noImagesStackView.isHidden = true
        
        self.takePictureButton.layer.cornerRadius = 10
        self.takePictureButton.layer.shadowColor = UIColor(
            red: 0,
            green: 0,
            blue: 0,
            alpha: 0.25
        ).cgColor
        self.takePictureButton.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        self.takePictureButton.layer.shadowOpacity = 1.0
        self.takePictureButton.layer.shadowRadius = 0.0
        self.takePictureButton.layer.masksToBounds = false
        
        self.galleryCollection.delegate = self
        self.galleryCollection.dataSource = self
        self.galleryCollection.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func fetchInfo() {
        self.viewModel.fetchPictures()
        self.galleryCollection.reloadData()
        if self.viewModel.pictures.count == 0 {
            self.noImagesStackView.isHidden = false
        }
    }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if
            let indexPath = self.galleryCollection.indexPathsForSelectedItems,
            segue.identifier == Constants.mainSegueIdentifier
        {
            let controller = segue.destination as? DetailViewController
            controller?.viewModel = self.viewModel
            controller?.indexPath = indexPath.first
        }
    }
    
    // MARK: - Actions Methods Section
    
    @IBAction func takePictureButtonPressed(
        _ sender: UIButton
    ) {
        self.validateCameraAuthorization()
    }
    
    private func validateCameraAuthorization() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] granted in
            if granted {
                DispatchQueue.main.async {
                    self?.viewModel.locationManager.requestAuthorization()
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    picker.allowsEditing = true
                    picker.delegate = self
                    self?.present(
                        picker,
                        animated: true
                    )
                }
            } else {
                self?.showAlert(
                    Constants.mainCameraDeniedTitle,
                    Constants.mainCameraDeniedMessage
                )
            }
        }
    }
    
    private func showAlert (
        _ title: String,
        _ message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(
            UIAlertAction(
                title: Constants.okText,
                style: UIAlertAction.Style.default,
                handler: nil
            )
        )
        DispatchQueue.main.async { [weak self] in
            self?.present(
                alert,
                animated:true,
                completion: nil
            )
        }
    }
}

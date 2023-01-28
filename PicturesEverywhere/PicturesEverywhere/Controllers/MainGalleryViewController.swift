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
    
    internal let viewModel = DataViewModel()
    
    // MARK: - LifeCycle Section
    
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
    
    // MARK: - Configuration Methods Section
    
    private func setupComponents() {
        self.title = "Main Gallery"
        
        self.takePictureButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.takePictureButton.layer.cornerRadius = 10
        
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
    
    // MARK: - Actions Methods Section
    
    @IBAction func takePictureButtonPressed(
        _ sender: UIButton
    ) {
        self.validateLocationAuthorization()
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
                title: "OK",
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
    
    private func validateLocationAuthorization() {
        switch self.viewModel.locationManager.authorizationStatus {
        case .none, .notDetermined, .restricted, .denied:
            self.showAlert(
                "Location denied",
                "Location services are not enabled"
            )
        case .authorizedAlways, .authorizedWhenInUse:
            self.validateCameraAuthorization()
        @unknown default:
            break
        }
    }
    
    private func validateCameraAuthorization() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] granted in
            if granted {
                DispatchQueue.main.async {
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
                    "Camera Permission Denied",
                    "You don´t allow access to camera permission"
                )
            }
        }
    }
}

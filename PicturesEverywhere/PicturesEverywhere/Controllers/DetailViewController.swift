//
//  DetailViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import UIKit

// MARK: - DetailViewController Section

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    internal var indexPath: IndexPath?
    internal var viewModel: DataViewModel?
    
    // MARK: - LifeCycle Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    // MARK: - Configuration Methods Section
    
    private func setupComponents() {
        self.title = Constants.detailTitleText
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        guard
            let row = indexPath?.row,
            let picture = self.viewModel?.pictures[row]
        else {
            return
        }
        
        self.detailImageView.image = picture.content
        self.detailImageView.clipsToBounds = true
        self.detailImageView.layer.cornerRadius = 8
        self.detailImageView.contentMode = .scaleAspectFill
        
        self.locationLabel.text = picture.location
        
        let rightbutton = UIBarButtonItem(
            image: UIImage(
                systemName: Constants.detailRightButtonImageName
            ),
            style: .done,
            target: self,
            action: #selector(deleteImage)
        )
        self.navigationItem.rightBarButtonItem  = rightbutton
    }
    
    @objc func deleteImage() {
        self.showAlert(
            Constants.detailDeletePictureTitle,
            Constants.detailDeletePictureMessage
        )
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
                title: Constants.cancelText,
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        alert.addAction(
            UIAlertAction(
                title: Constants.okText,
                style: UIAlertAction.Style.default,
                handler: { [weak self] _ in
                    guard let indexPath = self?.indexPath else {
                        return
                    }
                    self?.viewModel?.deletePicture(indexPath)
                    self?.navigationController?.popViewController(animated: true)
                }
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

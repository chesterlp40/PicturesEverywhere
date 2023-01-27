//
//  DetailViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 26/01/2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    internal var image: UIImage?
    internal var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    private func setupComponents() {
        // Title View Controller
        self.title = "Picture Screen"
        
        guard
            let safeImage = self.image,
            let safeLocation = self.location
        else {
            return
        }
        
        self.detailImageView.image = safeImage
        self.detailImageView.contentMode = .scaleToFill
        self.locationLabel.text = safeLocation
    }

}

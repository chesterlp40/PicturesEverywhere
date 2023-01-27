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
    
    internal var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    private func setupComponents() {
        // Title View Controller
        self.title = "Picture Screen"
        
        guard let picture = self.picture else {
            return
        }
        
        self.detailImageView.image = picture.content
        self.detailImageView.contentMode = .scaleToFill
        self.locationLabel.text = picture.location
    }

}

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
    
    internal var picture: Picture?
    
    // MARK: - LifeCycle Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
    }
    
    // MARK: - Configuration Methods Section
    
    private func setupComponents() {
        self.title = "Picture Screen"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        guard let picture = self.picture else {
            return
        }
        
        self.detailImageView.image = picture.content
        self.detailImageView.clipsToBounds = true
        self.detailImageView.layer.cornerRadius = 8
        self.detailImageView.contentMode = .scaleAspectFill
        self.locationLabel.text = picture.location
    }
}

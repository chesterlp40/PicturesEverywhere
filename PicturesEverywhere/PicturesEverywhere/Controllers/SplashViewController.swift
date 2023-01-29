//
//  SplashViewController.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 28/01/2023.
//

import UIKit

// MARK: - SplashViewController Section

class SplashViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - LifeCycle Section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupComponents()
        self.animateTitle()
        self.redirectToMainApp()
    }
    
    // MARK: - Configuration Methods Section
    
    private func setupComponents() {
        self.titleLabel.text = Constants.splashLoadingText
        
        let image = UIImage(
            named: Constants.splashImageName
        )
        self.imageView.image = image
        self.imageView.contentMode = .scaleAspectFill
    }
    
    private func animateTitle() {
        let title = Constants.splashDotText
        var letterIndex = 0.0
        for letter in title {
            Timer.scheduledTimer(
                withTimeInterval: 0.5 * letterIndex,
                repeats: false
            ) { [weak self] timer in
                self?.titleLabel.text?.append(letter)
            }
            letterIndex += 1
        }
    }
    
    private func redirectToMainApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let storyBoard = UIStoryboard(
                name: Constants.splashStoryboardName,
                bundle: nil
            )
            guard
                let mainGalleryViewController = storyBoard.instantiateViewController(
                    withIdentifier: Constants.splashNavigationIdentifier
                ) as? UINavigationController
            else {
                return
            }
            mainGalleryViewController.modalPresentationStyle = .fullScreen
            mainGalleryViewController.modalTransitionStyle = .flipHorizontal
            self?.present(
                mainGalleryViewController,
                animated: true
            ) {
                UIView.animate(withDuration: 1.0, delay: 0.5) {
                    self?.view.alpha = 0
                }
            }
        }
    }
}

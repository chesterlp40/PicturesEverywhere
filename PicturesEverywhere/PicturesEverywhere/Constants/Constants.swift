//
//  Constants.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 29/01/2023.
//

import Foundation

class Constants {
    // MARK: - Data Model Section
    
    internal static let pictureEntity = "Picture"
    internal static let picturesDataModel = "PicturesDataModel"
    internal static let imageTransformer = "UIImageTransformer"
    internal static let pictureLocationPrefix = "Picture location:"
    
    // MARK: - SplashViewController Section
    
    internal static let splashLoadingText = "Loading"
    internal static let splashDotText = "..."
    internal static let splashImageName = "rocket"
    internal static let splashStoryboardName = "Main"
    internal static let splashNavigationIdentifier = "NavigationController"
    
    // MARK: - MainGalleryViewController Section
    
    internal static let mainTitleText = "Pics Everywhere"
    internal static let mainSegueIdentifier = "toDetailView"
    internal static let mainCameraDeniedTitle = "Camera Permission Denied"
    internal static let mainCameraDeniedMessage = "You don´t allow access to camera permission"
    internal static let mainCellIdentifier = "cell"
    
    // MARK: - DetailViewController Section
    
    internal static let detailTitleText = "Picture Screen"
    internal static let detailRightButtonImageName = "trash"
    internal static let detailDeletePictureTitle = "Delete picture?"
    internal static let detailDeletePictureMessage = "Are you sure you want to delete the picture?"
    
    // MARK: - Generic Section
    
    internal static let okText = "OK"
    internal static let cancelText = "CANCEL"
}

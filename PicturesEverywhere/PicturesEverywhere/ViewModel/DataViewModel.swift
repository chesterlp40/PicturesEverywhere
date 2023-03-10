//
//  DataViewModel.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import UIKit
import CoreData

// MARK: - DataViewModel Section

class DataViewModel {
    
    private var context = CoreDataManager.sharedInstance.persistentContainer.viewContext
    internal var locationManager = LocationManager()
    internal var pictures: [Picture] = []
    
    // MARK: - Core Data Section
    
    internal func fetchPictures() {
        let request: NSFetchRequest<Picture> = NSFetchRequest(
            entityName: Constants.pictureEntity
        )
        do {
            self.pictures = try self.context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    internal func savePicture(
        _ imageData: Data,
        completion: @escaping () -> Void
    ) {
        switch self.locationManager.authorizationStatus {
        case .none, .notDetermined, .restricted, .denied:
            self.saveWithoutLocation(
                imageData,
                completion: completion
            )
        case .authorizedAlways, .authorizedWhenInUse:
            self.saveWithLocation(
                imageData,
                completion: completion
            )
        @unknown default:
            break
        }
    }
    
    internal func saveWithoutLocation(
        _ imageData: Data,
        completion: @escaping () -> Void
    ) {
        let picture = Picture(
            context: self.context
        )
        picture.location = Constants.pictureLocationPrefix + "\nUNKNOWN"
        picture.content = UIImage(
            data: imageData
        )
        
        try? self.context.save()
        completion()
    }
    
    internal func saveWithLocation(
        _ imageData: Data,
        completion: @escaping () -> Void
    ) {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        self.locationManager.getPlace(for: exposedLocation) { [weak self] placemark in
            guard
                let placemark = placemark,
                let safeSelf = self
            else {
                return
            }
                        
            var output = Constants.pictureLocationPrefix
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
            
            let picture = Picture(
                context: safeSelf.context
            )
            picture.location = output
            picture.content = UIImage(
                data: imageData
            )
            
            try? safeSelf.context.save()
            completion()
        }
    }
    
    internal func deletePicture(
        _ indexPath: IndexPath
    ) {
        self.context.delete(
            self.pictures[indexPath.row] as NSManagedObject
        )
        self.pictures.remove(
            at: indexPath.row
        )
        try? self.context.save()
    }
}

//
//  DataViewModel.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import UIKit
import CoreData

class DataViewModel {
    private var context = CoreDataManager.sharedInstance.persistentContainer.viewContext
    internal var pictures: [Picture] = []
    
    internal func fetchPictures() {
        let request: NSFetchRequest<Picture> = NSFetchRequest(
            entityName: "Picture"
        )
        do {
            let pictures: [Picture] = try self.context.fetch(request)
            self.pictures = pictures
        } catch {
            print(error)
        }
    }
    
    internal func savePicture(
        _ imageData: Data,
        _ location: String
    ) {
        let picture = Picture(context: self.context)
        picture.location = location
        picture.content = UIImage(data: imageData)
        
        try? self.context.save()
    }
}

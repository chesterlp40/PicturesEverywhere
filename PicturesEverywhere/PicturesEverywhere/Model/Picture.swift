//
//  Picture.swift
//  PicturesEverywhere
//
//  Created by Ezequiel Rasgido on 27/01/2023.
//

import UIKit
import CoreData

@objc(Picture)
class Picture: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture")
    }

    @NSManaged public var content: UIImage?
    @NSManaged public var location: String?

}

extension Picture : Identifiable {

}


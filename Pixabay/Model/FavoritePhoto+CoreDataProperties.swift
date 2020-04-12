//
//  FavoritePhoto+CoreDataProperties.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/12/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePhoto> {
        return NSFetchRequest<FavoritePhoto>(entityName: "FavoritePhoto")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var user: String?
    @NSManaged public var likes: Int16

}

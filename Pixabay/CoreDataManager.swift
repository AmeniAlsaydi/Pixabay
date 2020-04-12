//
//  CoreDataManager.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/12/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// class to manage core data storage and functions 

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() { }
    
    private var favoritePhotos = [FavoritePhoto]()
    
    // access persistentContainer from the app delegate which was created with core data
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createFavPhoto(imageUrl: String, user: String, likes: Int) -> FavoritePhoto {
        let favPhoto = FavoritePhoto(entity: FavoritePhoto.entity(), insertInto: context)
        
        favPhoto.imageURL = imageUrl
        favPhoto.likes = Int16(likes)
        favPhoto.user = user
        
         do {
             try context.save()
         } catch {
             print("error saving user: \(error)")
         }
         
        
        return favPhoto
        
    }
    
    public func fetchFavs() -> [FavoritePhoto] {
        
        do {
            favoritePhotos = try context.fetch(FavoritePhoto.fetchRequest())
        } catch {
            print("error fetching fav photos: \(error)")
        }
        
        return favoritePhotos 
    }
}

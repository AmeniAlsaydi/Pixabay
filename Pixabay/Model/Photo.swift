//
//  Photo.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/12/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct PhotoSearch:Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let largeImageURL: String
    let id: Int
    let user: String
    let likes: Int
    let favorites: Int
    let views: Int
    let tags: String
    let downloads: Int
}

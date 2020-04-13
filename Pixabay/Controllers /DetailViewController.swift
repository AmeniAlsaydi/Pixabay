//
//  DetailViewController.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/11/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    public var photo: Photo?
    public var favPhoto: FavoritePhoto?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height/60

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    private func updateUI() {
        
        if let photo = photo {
            postedByLabel.text = "Posted by: \(photo.user)"
            likesLabel.text = "♥️ \(photo.likes) likes"
            
            imageView.getImage(with: photo.largeImageURL) { (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
        if let favPhoto = favPhoto {
            favoriteButton.isHidden = true
            
            postedByLabel.text = "Posted by: \(favPhoto.user)"
            likesLabel.text = "♥️ \(favPhoto.likes) likes"
            
            imageView.getImage(with: favPhoto.imageURL ?? "") { (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        // save to core data
        
        if let photo = photo {
            CoreDataManager.shared.createFavPhoto(imageUrl: photo.largeImageURL, user: photo.user, likes: photo.likes)
        }
        
    }
    
    
    
    
}

//
//  PhotoCell.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/11/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        photoImageView.layer.cornerRadius = photoImageView.frame.height/40

    }
    
    public func configureCell(with photoUrl: String) {
        
        photoImageView.getImage(with: photoUrl) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
    }
    
}

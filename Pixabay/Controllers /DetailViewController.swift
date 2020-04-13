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
    
    private var photo: Photo
    
    init?(coder: NSCoder, photo: Photo) {
        self.photo = photo
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height/60

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    private func updateUI() {
        
        postedByLabel.text = "Posted by: @\(photo.user)"
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
    
    
    
    
}

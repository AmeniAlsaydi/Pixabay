//
//  FavoriteViewController.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/11/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var favoritePhotos = [FavoritePhoto]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadFavorites()
    }
    
    private func loadFavorites() {
        favoritePhotos = CoreDataManager.shared.fetchFavs()
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not downcast to custom cell")
        }
        
        let photo = favoritePhotos[indexPath.row]
        
        cell.configureCell(with: photo.imageURL ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = favoritePhotos[indexPath.row]
         guard let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
             print("could not down cast to detail vc")
             return
         }
         detailVC.favPhoto = photo
         present(detailVC, animated: true)

    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // going for a rectangle shape //
        let maxWidth = UIScreen.main.bounds.size.width // device width
        let itemWidth: CGFloat = maxWidth/2.2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // padding sround collectionview
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
}

// add segue to detail from fav
// long press to allow them to delete from the stored favs
// if they click on a filled heart - delete it from the stored favs - maybe use NSPredicate to check if is already in the favs return true



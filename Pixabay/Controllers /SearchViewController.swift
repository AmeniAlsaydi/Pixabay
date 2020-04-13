//
//  SearchViewController.swift
//  Pixabay
//
//  Created by Amy Alsaydi on 4/11/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    private var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.loadPhotos()
            }
        }
    }
    
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                if self.photos.count == 0 {
                    self.collectionView.backgroundView = EmptyView(title: "No Photos Found", message: "Check your search and try again!", imageName: "questionmark.diamond")
                    
                } else {
                    self.collectionView.backgroundView = nil
                }
                self.collectionView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        searchbar.delegate = self

    }
    
    private func loadPhotos() {
        PhotoApiClient.getPhotos(searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                print("api client error: \(appError)")
            case .success(let photos):
                self.photos = photos
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundView = EmptyView(title: "Explore", message: "Enter a keyword and explore!", imageName: "pencil")
    }

}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not downcast to custom cell")
        }
        
        let photo = photos[indexPath.row]
        cell.configureCell(with: photo.largeImageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") {
            (coder) in
            return DetailViewController(coder: coder, photo: photo)
        }
        
        present(detailVC!, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        
        guard !searchText.isEmpty else {
            loadPhotos()
            return
        }
        
        searchQuery = searchText.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "fun"
    }
}

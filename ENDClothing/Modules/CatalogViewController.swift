//
//  CatalogViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import UIKit

final class CatalogViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 300)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(CatalogViewCell.self, forCellWithReuseIdentifier: "CatalogViewCell")
        collection.backgroundColor = .white
        return collection
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.pin(to: view)
    }
}

// MARK: - UICollectionViewDelegate

extension CatalogViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: push to new product details screen
        print("Push to product details screen")
    }
}

// MARK: - UICollectionViewDataSource

extension CatalogViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogViewCell", for: indexPath) as? CatalogViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .red
        return cell
    }
}




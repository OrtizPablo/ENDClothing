//
//  CatalogViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import UIKit
import Combine

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
    
    private let viewModel: CatalogViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(viewModel: CatalogViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.pin(to: view)
        bindViewModel()
    }
}

// MARK: - Binding

extension CatalogViewController {
    
    private func bindViewModel() {
        viewModel.products.sink { _ in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }.store(in: &cancellables)
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
        return viewModel.products.value.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogViewCell", for: indexPath) as? CatalogViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .red
        return cell
    }
}

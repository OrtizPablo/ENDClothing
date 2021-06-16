//
//  CatalogViewController.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import UIKit
import Combine

final class CatalogViewController: BaseViewController {

    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
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
        title = viewModel.navTitle
        view.backgroundColor = .white
        collectionView.pin(to: view)
        bindViewModel()
        viewModel.onViewReady.send(())
    }
}

// MARK: - Binding

extension CatalogViewController {
    
    private func bindViewModel() {
        viewModel.isLoading.sink { isLoading in
            DispatchQueue.main.async { [weak self] in
                isLoading ? self?.showLoadingIndicator() : self?.stopLoadingIndicator()
            }
        }.store(in: &cancellables)
        
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
        viewModel.onProductTapped.send(indexPath.row)
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
        cell.setupView(imagePath: viewModel.products.value[indexPath.row].imagePath,
                       title: viewModel.products.value[indexPath.row].name,
                       price: viewModel.products.value[indexPath.row].price)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2) -  Constants.largePadding
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constants.margin, bottom: 0, right: Constants.margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

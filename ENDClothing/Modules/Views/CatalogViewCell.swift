//
//  CatalogViewCell.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 13/06/2021.
//

import UIKit

final class CatalogViewCell: UICollectionViewCell {
    
    // MARK: - Properties
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tshirtPlaceholder")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var wishlistButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartUnfilled"), for: .normal)
        button.constraintToSize(CGSize(width: 20, height: 20))
        button.addTarget(self, action: #selector(onWishlistButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, wishlistButton])
        stack.axis = .horizontal
        wishlistButton.setContentHuggingPriority(.required, for: .horizontal)
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let bottomStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, priceStack])
        bottomStack.axis = .vertical
        bottomStack.spacing = Constants.halfPadding
        let stack = UIStackView(arrangedSubviews: [imageView, bottomStack])        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        subtitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        bottomStack.setContentCompressionResistancePriority(.required, for: .vertical)
        
        stack.axis = .vertical
        stack.spacing = Constants.margin
        return stack
    }()
    
    private var itemSaved = false
    
    // MARK: - Public functions
    
    func setupView(title: String, subtitle: String = "Yellow", price: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        priceLabel.text = price
        stackView.pin(to: self)
    }
}

// MARK: - Private helpers

extension CatalogViewCell {
    
    @objc private func onWishlistButtonTapped() {
        if itemSaved {
            setButtonImage("heartUnfilled")
        } else {
            setButtonImage("heartFilled")
        }
        itemSaved = !itemSaved
        // TODO: save item to saved items
    }
    
    private func setButtonImage(_ imageName: String) {
        wishlistButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

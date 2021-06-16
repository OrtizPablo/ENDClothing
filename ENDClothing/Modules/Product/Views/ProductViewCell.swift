//
//  ImageViewCell.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import UIKit

final class ProductViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.constraintToHeight(300)
        return imageView
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Select a size"
        return label
    }()
    
    private lazy var sizeButtons = [UIButton]()
    
    private lazy var sizeContainerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [productImageView, sizeLabel, sizeContainerView])
        stack.axis = .vertical
        stack.spacing = Constants.margin
        return stack
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public methods
    
    func setupCell(imagePath: String, titles: [[String]]) {
        productImageView.loadImage(urlString: imagePath, placeholderImageName: "tshirtPlaceholder")
        createButtonSizeStack(titles: titles)
    }
}

// MARK: - Private helpers

extension ProductViewCell {
    
    private func commonInit() {
        stack.pin(to: self, padding: Constants.margin)
    }
    
    private func createButtonSizeStack(titles: [[String]]) {
        for i in 0..<titles.count {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            for j in 0..<titles[i].count {
                let button = UIButton()
                button.setTitle(titles[i][j], for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.lightGray.cgColor
                horizontalStack.constraintToHeight(50)
                button.addTarget(self, action: #selector(onButtonTapped(_:)), for: .touchUpInside)
                horizontalStack.addArrangedSubview(button)
                sizeButtons.append(button)
            }
            sizeContainerView.addArrangedSubview(horizontalStack)
        }
    }
    
    @objc private func onButtonTapped(_ sender: UIButton) {
        for button in sizeButtons {
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        sender.layer.borderColor = UIColor.black.cgColor
        sizeLabel.text = sender.titleLabel?.text
    }
}

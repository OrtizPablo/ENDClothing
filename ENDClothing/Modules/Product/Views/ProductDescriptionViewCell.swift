//
//  ProductDescriptionViewCell.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 15/06/2021.
//

import UIKit

final class ProductDescriptionViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, headingLabel])
        stack.axis = .horizontal
        headingLabel.setContentHuggingPriority(.required, for: .horizontal)
        stack.spacing = Constants.margin
        return stack
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStack, descriptionLabel])
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
    
    func setupCell(title: String, heading: String?, description: String) {
        titleLabel.text = title
        headingLabel.text = heading
        descriptionLabel.text = description
    }
}

// MARK: - Private methods

extension ProductDescriptionViewCell {
    
    private func commonInit() {
        stack.pin(to: self, padding: Constants.margin)
    }
}

//
//  PlaceholderView.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 16/06/2021.
//

import UIKit
import SnapKit

protocol PlaceholderViewDelegate: AnyObject {
    func onRetryTapped()
}

final class PlaceholderView: UIView {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "errorPlaceholder")
        return view
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong, please try again"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onRetryTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: PlaceholderViewDelegate?

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private helpers

extension PlaceholderView {

    private func setupView() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(retryButton)
        
        imageView.constraintToSize(CGSize(width: 100, height: 100))
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.margin)
            make.leading.equalTo(Constants.margin)
            make.trailing.equalTo(-Constants.margin)
        }

        retryButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.margin)
            make.leading.equalTo(Constants.margin)
            make.trailing.equalTo(-Constants.margin)
        }
    }

    @objc private func onRetryTapped() {
        delegate?.onRetryTapped()
    }
}

//
//  UIView+Helpers.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import UIKit
import SnapKit

extension UIView {

    func pin(to view: UIView) {
        view.addSubview(self)
        snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

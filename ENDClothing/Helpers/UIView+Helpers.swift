//
//  UIView+Helpers.swift
//  ENDClothing
//
//  Created by Pablo Ortiz on 08/06/2021.
//

import UIKit
import SnapKit

extension UIView {
    
    func pin(to view: UIView, padding: CGFloat = 0) {
        pin(to: view,
            leadingConstant: padding,
            topConstant: padding,
            trailingConstant: padding,
            bottomConstant: padding)
    }

    func pin(to view: UIView,
             leadingConstant: CGFloat = 0,
             topConstant: CGFloat = 0,
             trailingConstant: CGFloat = 0,
             bottomConstant: CGFloat = 0) {
        view.addSubview(self)
        snp.makeConstraints { make in
            make.leading.equalTo(leadingConstant)
            make.top.equalTo(topConstant)
            make.trailing.equalTo(-trailingConstant)
            make.bottom.equalTo(-bottomConstant)
        }
    }
    
    func constraintToSize(_ size: CGSize) {
        snp.makeConstraints { make in
            make.height.equalTo(size.height)
            make.width.equalTo(size.width)
        }
    }
    
    func constraintToHeight(_ height: CGFloat) {
        snp.makeConstraints { make in
            make.height.equalTo(height).priority(.high)
        }
    }
}

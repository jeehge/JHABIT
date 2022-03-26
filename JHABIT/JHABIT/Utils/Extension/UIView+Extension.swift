//
//  UIView+Extension.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

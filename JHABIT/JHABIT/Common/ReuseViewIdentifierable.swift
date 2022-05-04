//
//  ReuseViewIdentifierable.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import UIKit

protocol ReuseViewIdentifierable { }

extension ReuseViewIdentifierable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseViewIdentifierable { }
extension UICollectionViewCell : ReuseViewIdentifierable { }

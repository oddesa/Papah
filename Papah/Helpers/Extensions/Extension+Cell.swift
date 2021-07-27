//
//  Extension+Cell.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit

extension UIViewController: XIBIdentifiable {}

extension UITableViewCell: XIBIdentifiable {}

extension UICollectionViewCell: XIBIdentifiable {}

protocol XIBIdentifiable {
    static var id: String { get }
    static var nib: UINib { get }
}

extension XIBIdentifiable {
    static var id: String {
        String(describing: Self.self)
    }

    static var nib: UINib {
        UINib(nibName: id, bundle: nil)
    }
}

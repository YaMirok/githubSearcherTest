//
//  Fonts.swift
//  Created by Damir Sitdikov on 28.01.2021.
//

import UIKit

extension UIFont {
    // MARK: - Regular

    public enum Regular {
        static let system12: UIFont = .systemFont(ofSize: 12)
        static let system15: UIFont = .systemFont(ofSize: 15)
    }

    // MARK: - Bold

    public enum Bold {
        static let system7: UIFont = .boldSystemFont(ofSize: 7)
        static let system8: UIFont = .boldSystemFont(ofSize: 8)
        static let system12: UIFont = .boldSystemFont(ofSize: 12)
        static let system14: UIFont = .boldSystemFont(ofSize: 14)
    }
}
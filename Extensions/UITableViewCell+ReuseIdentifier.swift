//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
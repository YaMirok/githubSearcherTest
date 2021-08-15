//
// Created by Damir Sitdikov on 27.01.2021.
//

import UIKit

extension UIColor {
    enum Static {
        public static let white = UIColor.dynamic(light: UIColor.white)
        public static let black = UIColor.dynamic(light: UIColor.black)
    }
    enum Themed {
        public static let white = UIColor.dynamic(light: UIColor.white, dark: .black)
        public static let black = UIColor.dynamic(light: UIColor.black, dark: .white)
    }
}

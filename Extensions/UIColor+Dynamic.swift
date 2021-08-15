//
// Created by Damir Sitdikov on 23.05.2020.
// Copyright (c) 2020 Aparlay Limited. All rights reserved.
//

import UIKit

extension UIColor {
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                switch $0.userInterfaceStyle {
                case .dark:
                    return dark
                case .light, .unspecified:
                    return light
                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \($0.userInterfaceStyle)")
                    return light
                }
            })
        }
        return light
    }

    static func dynamic(light: UIColor) -> UIColor {
        .dynamic(light: light, dark: light)
    }
}

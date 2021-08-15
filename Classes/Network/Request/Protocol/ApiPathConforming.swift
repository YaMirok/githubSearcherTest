//
// Created by Damir Sitdikov on 01.12.2020.
//

import Foundation

protocol ApiPathConforming {
    var pathValue: String { get }
    var requiresAuthentication: Bool { get }
}

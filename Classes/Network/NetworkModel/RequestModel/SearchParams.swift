//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

struct SearchParams: Encodable {
    let searchString: String
    let page: Int
    let pageSize: Int

    enum CodingKeys: String, CodingKey {
        case searchString = "q"
        case page
        case pageSize = "per_page"
    }
}

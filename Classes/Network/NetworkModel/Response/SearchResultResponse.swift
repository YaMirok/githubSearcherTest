//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

struct SearchResultResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchResultItem]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

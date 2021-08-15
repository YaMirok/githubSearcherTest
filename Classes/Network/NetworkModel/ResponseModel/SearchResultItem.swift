//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

struct SearchResultItem: Decodable {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    let id: Int
    let fullName: String
    let starsCount: Int
    private let updatedAtRaw: String
    private let htmlUrlString: String

    var url: URL? {
        URL(string: htmlUrlString)
    }

    var updatedAt: Date? {
        Self.dateFormatter.date(from: updatedAtRaw)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case starsCount = "stargazers_count"
        case htmlUrlString = "html_url"
        case updatedAtRaw = "updated_at"
    }
}

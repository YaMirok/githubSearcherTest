//
// Created by Damir Sitdikov on 08.12.2020.
//

import Foundation

enum ApiRoutes {
    enum Search: ApiPathConforming {
        case searchRepositories
        var pathValue: String {
            switch self {
            case .searchRepositories:
                return "search/repositories"
            }
        }

        var requiresAuthentication: Bool {
            false
        }
    }

}

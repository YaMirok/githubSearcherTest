//
// Created by Damir Sitdikov on 08.12.2020.
//

import Foundation

enum ApiRoutes {
    enum Auth: ApiPathConforming {
        case authenticate

        var pathValue: String {
            switch self {
            case .authenticate:
                return "session/auth"
            }
        }

        var requiresAuthentication: Bool {
            false
        }
    }

    enum GeneralWebsocket: ApiPathConforming {
        case general

        var pathValue: String {
            switch self{
            case .general:
                return "ws/general"
            }
        }

        var requiresAuthentication: Bool {
            true
        }
    }

    enum Games: ApiPathConforming {
        case invite
        case gameInfo(_ inviteCode: String)
        case gameStart(gameId: String)
        case gameTurn(gameId: String)

        var pathValue: String {
            switch self{
            case .invite:
                return "games/invite"
            case let .gameInfo(inviteCode):
                return "games/invite/\(inviteCode)"
            case let .gameStart(gameId):
                return "games/start/\(gameId)"
            case let .gameTurn(gameId):
                return "games/turn/\(gameId)"
            }
        }

        var requiresAuthentication: Bool {
            true
        }
    }
}

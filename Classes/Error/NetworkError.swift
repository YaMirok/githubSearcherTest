//
// Created by Damir Sitdikov on 07.12.2020.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case requestBuildError
    case accessTokenNotFound
    case cancelled
    case unknown
    case apiError(error: ApiError)
    case inner(afError: AFError)
}

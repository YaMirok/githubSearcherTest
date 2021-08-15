//
// Created by Damir Sitdikov on 01.12.2020.
//

import Foundation
import Alamofire

struct GetRequest: BaseRequestProtocol {
    let path: ApiPathConforming
    let additionalHeaders: [HTTPHeader]?
    let parameters: Parameters?

    var method: HTTPMethod {
        .get
    }

    var parametersEncoding: ParameterEncoding {
        URLEncoding.default
    }

    let cachePolicy: NSURLRequest.CachePolicy?
    let timeInterval: TimeInterval?

    init(path: ApiPathConforming,
         parameters: Parameters? = nil,
         additionalHeaders: [HTTPHeader]? = nil,
         cachePolicy: NSURLRequest.CachePolicy? = nil,
         timeInterval: TimeInterval? = nil) {
        self.path = path
        self.parameters = parameters
        self.additionalHeaders = additionalHeaders
        self.cachePolicy = cachePolicy
        self.timeInterval = timeInterval
    }
}

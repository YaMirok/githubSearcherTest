//
// Created by Damir Sitdikov on 01.12.2020.
//

import Foundation
import Alamofire

protocol BaseRequestProtocol {
    var path: ApiPathConforming { get }
    var method: HTTPMethod { get }
    var parametersEncoding: ParameterEncoding { get }
    var additionalHeaders: [HTTPHeader]? { get }
    var parameters: Parameters? { get }

    var cachePolicy: NSURLRequest.CachePolicy? { get }
    var timeInterval: TimeInterval? { get }
}

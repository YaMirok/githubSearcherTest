//
// Created by Damir Sitdikov on 07.12.2020.
//

import Foundation
import Alamofire

final class RequestBuilder: RequestBuilderProtocol {

    private let baseApiUrl: String
    private let cachePolicy: NSURLRequest.CachePolicy
    private let timeInterval: TimeInterval

    init(_ baseApiUrl: String,
         timeInterval: TimeInterval = 30,
         cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) {
        self.baseApiUrl = baseApiUrl
        self.timeInterval = timeInterval
        self.cachePolicy = cachePolicy
    }

    func getURLRequest(requestProperties: BaseRequestProtocol) throws -> URLRequest {
        guard let requestURL = URL(string: baseApiUrl)?.appendingPathComponent(requestProperties.path.pathValue) else {
            throw NetworkError.requestBuildError
        }
        var urlRequest = URLRequest(url: requestURL,
                                    cachePolicy: requestProperties.cachePolicy ?? cachePolicy,
                                    timeoutInterval: requestProperties.timeInterval ?? timeInterval)
        urlRequest.httpMethod = requestProperties.method.rawValue
        requestProperties.additionalHeaders?.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }
        do {
            let request = try requestProperties.parametersEncoding.encode(urlRequest, with: requestProperties.parameters)
            return request
        } catch {
            throw NetworkError.requestBuildError
        }
    }

}

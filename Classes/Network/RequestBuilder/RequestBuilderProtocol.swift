//
// Created by Damir Sitdikov on 08.12.2020.
//

import Foundation

protocol RequestBuilderProtocol {
    func getURLRequest(requestProperties: BaseRequestProtocol) throws -> URLRequest
}

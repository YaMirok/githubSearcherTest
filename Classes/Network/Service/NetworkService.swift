//
// Created by Damir Sitdikov on 08.12.2020.
//

import Foundation
import Alamofire

typealias RequestCompletionClosureType<ResultType> = (_ result: Result<ResultType, NetworkError>) -> Void

final class NetworkService {

    private let builder: RequestBuilderProtocol


    private(set) lazy var guestSession: Session = {
        let session = Session()
        return session
    }()


    init(builder: RequestBuilderProtocol) {
        self.builder = builder
    }

    func sendRequest<ResultType: Decodable>(baseRequest: BaseRequestProtocol,
                                            completion: @escaping RequestCompletionClosureType<ResultType>) throws -> DataRequest {
        do {
            let request = try builder.getURLRequest(requestProperties: baseRequest)
            return sendRequestWithoutAuthentication(request, completion: completion)
        } catch NetworkError.requestBuildError {
            throw NetworkError.requestBuildError
        }
    }

    private func sendRequestWithoutAuthentication<ResultType: Decodable>(_ request: URLRequest,
                                                                         completion: @escaping RequestCompletionClosureType<ResultType>) -> DataRequest {
        guestSession.request(request).responseDecodable(of: ResultType.self) { (dataResponse: AFDataResponse<ResultType>) in
            if let responseObject = dataResponse.value {
                completion(.success(responseObject))
            } else if let error = dataResponse.error {
                completion(.failure(.inner(afError: error)))
            }
        }
    }

}

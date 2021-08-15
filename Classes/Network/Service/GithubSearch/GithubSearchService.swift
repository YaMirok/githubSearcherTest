//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation
import Alamofire

final class GithubSearchService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension GithubSearchService: GithubSearching {
    func search(text: String,
                page: Int,
                pageSize: Int,
                completion: @escaping (_ result: Result<SearchResultResponse, Error>) -> Void) -> Cancellable? {
        let params = SearchParams(searchString: text, page: page, pageSize: pageSize)
        let request = GetRequest(path: ApiRoutes.Search.searchRepositories, parameters: params.toParameters())
        do {
            let request = try networkService.sendRequest(baseRequest: request, completion: { (result: Result<SearchResultResponse, NetworkError>) in
                switch result {
                case let .success(response):
                    completion(.success(response))
                case let .failure(error):
                    completion(.failure(error))
                }
            })
            return request
        } catch {
            completion(.failure(error))
        }
        return nil
    }
}

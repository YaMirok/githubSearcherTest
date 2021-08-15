//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

final class GithubSearchService: GithubSearching {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension GithubSearchService {

}

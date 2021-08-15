//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

final class SearchInteractor {
    weak var output: SearchInteractorOutput!
    var searchService: GithubSearching!

    private var currentPage = 0
    private let pageSize = 30

    private var currentActiveRequest: Cancellable?
}

// MARK: - SearchInteractorInput

extension SearchInteractor: SearchInteractorInput {
    func obtainSearchResults(for text: String) {
        currentActiveRequest?.cancel()
        currentActiveRequest = searchService.search(text:
                                                    text,
                                                    page: currentPage,
                                                    pageSize: pageSize,
                                                    completion: { [weak self]searchResult in
                                                        guard let sSelf = self else {
                                                            return
                                                        }
                                                        switch searchResult {
                                                        case let .success(result):
                                                            debugPrint(result)
                                                        case let .failure(error):
                                                            debugPrint(error)
                                                        }
                                                    })
    }
}

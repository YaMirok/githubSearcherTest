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
        output.didStartLoadingFirstPage(for: text)
        currentPage = 0
        currentActiveRequest?.cancel()
        currentActiveRequest = searchService.search(text:
                                                    text,
                                                    page: currentPage,
                                                    pageSize: pageSize,
                                                    completion: { [weak self, text]searchResult in
                                                        guard let sSelf = self else {
                                                            return
                                                        }
                                                        switch searchResult {
                                                        case let .success(result):
                                                            sSelf.output.showInitial(items: result.items,
                                                                                     for: text,
                                                                                     canLoadMore: !result.incompleteResults)
                                                        case let .failure(error):
                                                            debugPrint(error)
                                                        }
                                                    })
    }

    func loadNextResultsPage(for text: String) {
        output.didStartLoadingNextPage(for: text)
        currentActiveRequest?.cancel()
        currentPage += 1
        currentActiveRequest = searchService.search(text:
                                                    text,
                                                    page: currentPage,
                                                    pageSize: pageSize,
                                                    completion: { [weak self, text]searchResult in
                                                        guard let sSelf = self else {
                                                            return
                                                        }
                                                        switch searchResult {
                                                        case let .success(result):
                                                            sSelf.output.addResult(items: result.items,
                                                                                   for: text,
                                                                                   canLoadMore: !result.incompleteResults)
                                                        case let .failure(error):
                                                            debugPrint(error)
                                                        }
                                                    })
    }
}

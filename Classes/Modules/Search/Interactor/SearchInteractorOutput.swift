//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

protocol SearchInteractorOutput: AnyObject {
    func didStartLoadingFirstPage(for text: String)
    func showInitial(items: [SearchResultItem], for text: String, canLoadMore: Bool)
    func loadFirstPageFailed(error: Error)
    func didStartLoadingNextPage(for text: String)
    func addResult(items: [SearchResultItem], for text: String, canLoadMore: Bool)
    func loadNextPageFailed(error: Error)
}

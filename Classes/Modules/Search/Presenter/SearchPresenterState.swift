//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

class SearchPresenterState {
    var currentSearchString: String = ""
    var canLoadMore: Bool = false

    var isLoadingFirstPage: Bool = false{
        didSet {
            updateLoadingSummaryState()
        }
    }
    var isLoadingNextPage: Bool = false{
        didSet {
            updateLoadingSummaryState()
        }
    }

    var loadingSummaryStateUpdateClosure: ((_ isLoading: Bool) -> Void)?

    private func updateLoadingSummaryState() {
        let isLoading = isLoadingFirstPage || isLoadingNextPage
        loadingSummaryStateUpdateClosure?(isLoading)
    }
}

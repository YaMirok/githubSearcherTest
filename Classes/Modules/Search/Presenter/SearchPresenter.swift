//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

final class SearchPresenter {
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchModuleRouterInput!

    // MARK: - Private variables

    private var state = SearchPresenterState()
    private var startSearchDispatchItem: DispatchWorkItem?

}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        state.loadingSummaryStateUpdateClosure = { [weak view] isLoading  in
            if isLoading {
                view?.showLoadingAnimation()
            } else {
                view?.hideLoadingAnimation()
            }
        }
    }

    func searchTextChanged(text: String) {
        startSearchDispatchItem?.cancel()
        guard !text.isEmpty else {
            state.currentSearchString = ""
            view.showNewItems([])
            return
        }
        let nextSearchDispatchItem = DispatchWorkItem(qos: .utility, block: { [weak self, text] in
            self?.state.currentSearchString = text
            self?.interactor.obtainSearchResults(for: text)
        })
        startSearchDispatchItem = nextSearchDispatchItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(250), execute: nextSearchDispatchItem)
    }

    func loadMoreIndexWillShow() {
        guard state.canLoadMore else {
            return
        }
        guard !state.isLoadingNextPage else {
            return
        }
        interactor.loadNextResultsPage(for: state.currentSearchString)
    }

    func showDetailsPageForRepo(on url: URL) {
        router.pushWebViewController(with: url)
    }
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    func didStartLoadingFirstPage(for text: String) {
        guard text == state.currentSearchString else {
            return
        }
        state.isLoadingFirstPage = true
    }

    func showInitial(items: [SearchResultItem], for text: String, canLoadMore: Bool) {
        guard text == state.currentSearchString else {
            return
        }
        state.canLoadMore = canLoadMore
        let viewModels = prepareViewModels(from: items)
        view.showNewItems(viewModels)
        state.isLoadingFirstPage = false
    }

    func loadFirstPageFailed(error: Error) {
        state.isLoadingFirstPage = false
        processNetworkError(error)
    }

    func didStartLoadingNextPage(for text: String) {
        guard text == state.currentSearchString else {
            return
        }
        state.isLoadingNextPage = true
    }

    func addResult(items: [SearchResultItem], for text: String, canLoadMore: Bool) {
        guard text == state.currentSearchString else {
            return
        }
        state.canLoadMore = canLoadMore
        state.isLoadingNextPage = false
        let viewModels = prepareViewModels(from: items)
        view.appendItems(viewModels)
    }

    func loadNextPageFailed(error: Error) {
        state.isLoadingNextPage = false
        processNetworkError(error)
    }
}

private extension SearchPresenter {

    func processNetworkError(_ error: Error) {
        var errorDescription: String?
        if let networkError = error as? NetworkError {
            switch networkError {
            case .cancelled:
                return
            case let .apiError(error):
                errorDescription = error.message
            case let .inner(innerError):
                errorDescription = innerError.errorDescription
            case .unknown:
                errorDescription = "Something went wrong."
            default:
                break
            }
        } else {
            errorDescription = error.localizedDescription
        }
        guard let errorDescription = errorDescription else { return }
        view.showErrorAlert(with: errorDescription)
    }

    func prepareViewModels(from items: [SearchResultItem]) -> [SearchResultTableCellModel] {
        var viewModels = [SearchResultTableCellModel]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        for item in items {
            guard let url = item.url else {
                continue
            }
            let updatedString: String?
            if let updatedAtValue = item.updatedAt {
                updatedString = dateFormatter.string(from: updatedAtValue)
            } else {
                updatedString = nil
            }
            viewModels.append(SearchResultTableCellModel(id: item.id,
                                                         title: item.fullName,
                                                         updatedAtString: updatedString,
                                                         starsCount: item.starsCount,
                                                         url: url))
        }
        return viewModels
    }
}

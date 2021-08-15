//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

final class SearchPresenter {
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchModuleRouterInput!

    // MARK: - Private variables

    private var startSearchDispatchItem: DispatchWorkItem?

}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {

    }

    func searchTextChanged(text: String) {
        startSearchDispatchItem?.cancel()
        let nextSearchDispatchItem = DispatchWorkItem(qos: .utility, block: { [weak self] in
            self?.interactor.obtainSearchResults(for: text)
        })
        startSearchDispatchItem = nextSearchDispatchItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(250), execute: nextSearchDispatchItem)
    }
}

extension SearchPresenter: SearchInteractorOutput {

}

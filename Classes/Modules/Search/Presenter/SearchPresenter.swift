//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

final class SearchPresenter {
    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchModuleRouterInput!

}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {

}

//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit

class SearchModuleAssembler {
    func build() -> UIViewController {
        let viewController = SearchViewController()

        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchModuleRouter()

        viewController.output = presenter

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }
}

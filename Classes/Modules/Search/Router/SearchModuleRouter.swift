//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit

final class SearchModuleRouter: SearchModuleRouterInput {
    weak var moduleViewController: UIViewController!

    func pushWebViewController(with url: URL) {
        let viewController = WebBrowserModuleAssembler(url: url).build()
        moduleViewController.present(viewController, animated: true)
    }
}

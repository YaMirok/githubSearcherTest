//
// Created by Damir Sitdikov on 15.08.2021.
//

import UIKit
import SafariServices

class WebBrowserModuleAssembler {

    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func build() -> UIViewController {
        let viewController = SFSafariViewController(url: url)
        viewController.dismissButtonStyle = .close
        return viewController
    }
}

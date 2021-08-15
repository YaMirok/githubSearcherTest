//
// Created by Damir Sitdikov on 15.08.2021.
//

import Foundation

protocol SearchViewInput: AnyObject {
    func showLoadingAnimation()
    func hideLoadingAnimation()
    func showNewItems(_ items: [SearchResultTableCellModel])
    func appendItems(_ items: [SearchResultTableCellModel])
}
